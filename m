From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 0/8] Create single PDF for all HTML files
Date: Thu, 11 Oct 2012 19:13:09 +0200 (CEST)
Message-ID: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:13:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMK3-0003tu-94
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758980Ab2JKRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:13:12 -0400
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:44433 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758972Ab2JKRNL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:13:11 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id F0BDE9C571;
	Thu, 11 Oct 2012 19:13:09 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id E1B33834015;
	Thu, 11 Oct 2012 19:13:09 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id E37AD3DD569;
	Thu, 11 Oct 2012 19:13:09 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net E37AD3DD569
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349975589; bh=CQlUiXNUE1LHAcwc54UIbXhFJhZq3y+vCNG5mYcsG64=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=YyhrHgu8P/YkoppRnnYzZZ8Yyd3W580UTvR2ZTa6/B4ivjw6WVHT5wHVfctSUcBNF
	 8Ae760Uw4GW+wb6xY4JiZZY4BIIIWHhoInkNQ/Td2Y3/29L2zzWqgvKhOBDsOK7SD1
	 nQrKWypEjqF8popeUdKMmXt076OMnEOO/kcoFBO0=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:13:09 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207490>

 
Hi,

here is my reworked patch series for creating a single PDF for all
git documentation files.

Thanks to Junio Hamano, Philip Oakley and Jeff King for your comments!

In general, the following problems had to be fixed in doc files in order to create
HTML by using asciidoc and afterwards create a nice looking PDF using wkhtmltopdf:

- Wrong sectioning syntax (e.g. "===" instead of "---")
- Left-over shell scripting commands (in some release notes files)
- Over-long lines which caused very wide right margins in the resulting PDF
- Wrong formatting for email quotes, quoted script code, tables

Also some of the headlines in the documents where changed or even created
initially in order to give a more consistent structure in the resulting PDF.

If you want to have a quick look on the resulting PDF just clone
https://github.com/tacker66/git-docpdf.git. This repo contains
a current version of user.manual.pdf and git-doc.pdf


---
Thomas
