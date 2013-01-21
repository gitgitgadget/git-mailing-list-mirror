From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 0/6] GIT, Git, git
Date: Mon, 21 Jan 2013 19:36:15 +0100 (CET)
Message-ID: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
References: <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 19:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMEY-0008Vz-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 19:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3AUSgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 13:36:17 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:41949 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751134Ab3AUSgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 13:36:16 -0500
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 3942ED7E9C;
	Mon, 21 Jan 2013 19:36:15 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 3551B6F2AF3;
	Mon, 21 Jan 2013 19:36:15 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 2B2CA212321;
	Mon, 21 Jan 2013 19:36:15 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 2B2CA212321
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358793375; bh=amy+opnmxFqc3u3VFAOPqkXmAbtNbVXmhEmVTASrUfQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=jMLXwUtE4Kw/9GdI6+yui7i8pBHCMPybS8Vk64rvjnKwCXM/CeAZBtDSio4YIXAkY
	 Kif4f0aXJ/WSC+oGgui3TFclPIrBUclIl8GhBIrzbs9J6zlwQWtZvjz5PkQ+koEj80
	 DnV7R5AsDNCrQJP+wiLyZoaDd77XqRkeZWbDiMPo=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 19:36:14 +0100 (CET)
In-Reply-To: <7vvcark1f2.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214135>

Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
(as can be seen in the corresponding release note where 'GIT' was 
changed to 'Git' in the header line).

Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
Git system. So change every occurrence of 'GIT" and 'git' in the 
documention  to 'Git' whenever Git as a system is referred to 
(but don't do this change in the release notes because they 
constitute a history orthogonal to the history versioned by Git).

There is also one occurence of 'GITweb' which is changed to 'Gitweb' but
changing 'gitweb' to 'Gitweb' (or 'GitWeb'?) should be part of another patch.

The "'git' to 'Git'" patch has to be divided in four parts to stay within
the mail size limit of 100kB.

[PATCH v2 1/6] Change old system name 'GIT' to 'Git'
[PATCH v2 2/6] Change 'git' to 'Git' whenever the whole system is referred to #1
[PATCH v2 3/6] Change 'git' to 'Git' whenever the whole system is referred to #2
[PATCH v2 4/6] Change 'git' to 'Git' whenever the whole system is referred to #3
[PATCH v2 5/6] Change 'git' to 'Git' whenever the whole system is referred to #4
[PATCH v2 6/6] Add rule for when to use 'git' and when to use 'Git'


---
Thomas
