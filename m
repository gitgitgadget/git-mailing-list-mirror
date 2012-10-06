From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 0/5] Create single PDF for all HTML files
Date: Sat, 6 Oct 2012 17:51:15 +0200 (CEST)
Message-ID: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:52:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWg5-0002CE-KG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab2JFPvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:51:20 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:45878 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab2JFPvR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:51:17 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id ED734212A62
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:51:15 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id E29CA2E610C;
	Sat,  6 Oct 2012 17:51:15 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id E3364212A33;
	Sat,  6 Oct 2012 17:51:15 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net E3364212A33
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349538675; bh=m6LP/cgo5p3xJM8r8KQP7BYOMHciXuuVbtzMj0A2kzE=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=b8hptrO8+9aMFkj5sM40BjGqc1jNP1E8Ssp4FW49QTMVo4MpEjIanQhTOWDwQmdFp
	 GgOXoHh493gWAuKXmMwOKwKrHBskL1P+bSWjaiC56MM2xa/nufDsDpwbVdORUAlpkW
	 h4GQNSjY474GrqKoizvw56yYXPAFZ6ZRmjL9XSfQ=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:51:15 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207151>

Hi,

I wanted to have a single PDF file which contains the complete Git documentation 
(except user-manual) for easier reading on my tablet. The simplest way to do 
this was by using wkhtmltopdf which can combine a set of HTML files into a sinlge 
PDF file and also apply some reformatting. To this end HTML files for all the missing 
files in Documentation/technical and Documentation/howto and also for all the 
release notes in Documentation/RelNotes were created. 
The resulting PDF file "git-doc.pdf" is created by a new make target called "fullpdf".

Hope anybody finds that useful.


---
Thomas
