From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 0/2] create HTML for http-protocol.txt
Date: Sun, 26 Jan 2014 13:52:03 +0100 (CET)
Message-ID: <735028458.1102653.1390740723616.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spearce@spearce.org, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 13:52:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7PC8-0001qO-0n
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 13:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaAZMwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 07:52:07 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:57454 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751245AbaAZMwF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 07:52:05 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id A596810BA6A;
	Sun, 26 Jan 2014 13:52:03 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 9F56F366BA9;
	Sun, 26 Jan 2014 13:52:03 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 952EC1978D1;
	Sun, 26 Jan 2014 13:52:03 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 952EC1978D1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1390740723; bh=/WssKaVpg/vEz1Wr4/AwAA52bDAtGB0xIE6Ul8v8cJA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=qXkTK8hHznQ2n67QKDMziRN3QLzDFMDYsNz2bh8Tgk+FBmXSMXgaH/bZlp4q49FcH
	 rCM9bWke9FMYorxxgAB5pgPP+Dvo+QG+kwfOU79+831MC0MDV+c25RKLAHuM0mYmj7
	 6LTxB/6WTlXfm4pPCV8x2ETXwARB9mc0egVq71gQ=
Received: from [94.217.129.144] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Sun, 26 Jan 2014 13:52:03 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.129.144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241082>


This is a reroll of my attempt to create usable HTML for http-protocol.txt.

The first patch addresses Junio's remarks regarding the conversion to better ASCIIDOC.
The patch contains some whitespace-only changes so these shouldn't be ignored while applying.

The second patch tries to fix one of the TODOs the original author has put into the document.


---
Thomas
