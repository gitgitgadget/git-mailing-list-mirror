From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 5/6] Add a description for 'gitfile' to glossary
Date: Fri, 1 Feb 2013 19:11:24 +0100 (CET)
Message-ID: <274664435.1090127.1359742284591.JavaMail.ngmail@webmail18.arcor-online.net>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net> <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L5X-0005Fl-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab3BASL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:11:26 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:60202 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab3BASLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:11:25 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 8B242D86ED;
	Fri,  1 Feb 2013 19:11:24 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 8FE3B11202D;
	Fri,  1 Feb 2013 19:11:24 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 8408B35AA8D;
	Fri,  1 Feb 2013 19:11:24 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net 8408B35AA8D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742284; bh=J0EpiMlc4pDh/LshHMuJ3EbQOCHSvjVggD5FyTs539s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=sNWbiI6B/TIBeGjXcO/B0bDLJVP3i9w3Kkt83KhNFTsuBL3/lFjlYdR8/w9HUX9cc
	 zZrgdt5g7JefDWoeGysKHTsUgrNKxWPN/lkwrQnkYYs5DTYoAFznNxXtxHDu3GPOq0
	 ZNDZG8CZOWzNgX8JjRQel7JixXWwg/ykFVrELS6Y=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:11:24 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215243>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 7c15bc0..ddf2f66 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -149,6 +149,9 @@ to point at the new commit.
 [[def_git_archive]]Git archive::
 	Synonym for <<def_repository,repository>> (for arch people).
 
+[[def_gitfile]]gitfile::
+	A `.git` file which points to a `$GIT_DIR` (used for Git submodules).
+
 [[def_grafts]]grafts::
 	Grafts enables two otherwise different lines of development to be joined
 	together by recording fake ancestry information for commits. This way
-- 
1.8.0.msysgit.0


---
Thomas
