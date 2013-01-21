From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: [PATCH v2 0/6] GIT, Git, git
Date: Mon, 21 Jan 2013 19:51:47 +0100 (CET)
Message-ID: <1119403422.632150.1358794307467.JavaMail.ngmail@webmail20.arcor-online.net>
References: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 19:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMTb-0007qY-2h
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 19:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab3AUSvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 13:51:49 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:38592 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752782Ab3AUSvt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 13:51:49 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 8B5DE10BBD5;
	Mon, 21 Jan 2013 19:51:47 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 885ED7DAB88;
	Mon, 21 Jan 2013 19:51:47 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 7A40821262F;
	Mon, 21 Jan 2013 19:51:47 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 7A40821262F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358794307; bh=SCXLn8mc32oxqzSa+/HvpYIB5Ui7KAotvyaVnuoeZq0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=MEBgg7iGzo5VTx0Gmtpry5qqRx08EvPenEYonbXAmVUGbvDyeUuab9zERXtq9YDtw
	 ibh3ngJIBdgPYOzCSjoUIxJOytZ97xSQgZ6df5cYUudvhcfflcCuW4xJsOwWpSXFXR
	 wpDp9QqFg0BfbtH2SxRsSMRtKhvOIR/t4SEXW8Mo=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 19:51:47 +0100 (CET)
In-Reply-To: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214138>

 
Please ignore these series ... there are still problems with the size of the patches :-|

----- Original Nachricht ----
Von:     Thomas Ackermann <th.acker@arcor.de>
An:      gitster@pobox.com, th.acker@arcor.de
Datum:   21.01.2013 19:36
Betreff: [PATCH v2 0/6] GIT, Git, git

> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
> (as can be seen in the corresponding release note where 'GIT' was 
> changed to 'Git' in the header line).
> 
> Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
> Git system. So change every occurrence of 'GIT" and 'git' in the 
> documention  to 'Git' whenever Git as a system is referred to 
> (but don't do this change in the release notes because they 
> constitute a history orthogonal to the history versioned by Git).
> 
> There is also one occurence of 'GITweb' which is changed to 'Gitweb' but
> changing 'gitweb' to 'Gitweb' (or 'GitWeb'?) should be part of another
> patch.
> 
> The "'git' to 'Git'" patch has to be divided in four parts to stay within
> the mail size limit of 100kB.
> 
> [PATCH v2 1/6] Change old system name 'GIT' to 'Git'
> [PATCH v2 2/6] Change 'git' to 'Git' whenever the whole system is referred
> to #1
> [PATCH v2 3/6] Change 'git' to 'Git' whenever the whole system is referred
> to #2
> [PATCH v2 4/6] Change 'git' to 'Git' whenever the whole system is referred
> to #3
> [PATCH v2 5/6] Change 'git' to 'Git' whenever the whole system is referred
> to #4
> [PATCH v2 6/6] Add rule for when to use 'git' and when to use 'Git'
> 
> 
> ---
> Thomas
> 

---
Thomas
