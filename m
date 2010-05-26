From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] Documentation/SubmittingPatches: Fix typo in GMail section
Date: Wed, 26 May 2010 08:36:10 -0400
Message-ID: <AANLkTinWWEMB3VjX0HOnulzJG4KEddqdSQ9ls724_wO5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 26 14:36:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHFqM-00050h-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 14:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab0EZMgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 08:36:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46605 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab0EZMgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 08:36:12 -0400
Received: by wyb29 with SMTP id 29so3169066wyb.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=kzk4nSOit+wO9i2BE8IWvT4vVxdlyqbqyKtIgPMJlIk=;
        b=svVgRlFVUiUQlQSjgCLOtDckwJ87i47uo1J6bDkkOr3U8npGrwFykUd6jwxAdD2d7S
         kyty+xKJm0Z6fSPGFT/S4+JFRkD9MQq5KKeccJCKNEgEGe22zChb/WEXa6xz6+jkYhdL
         W7k9TYD864dr5W9g0owu/gM68Xj6eUg17nMXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=HBRWHXKZP7JtFtFuIAfnFJBlt2OhEXY7BBgUF9pcz7oY09ikv+vEb0kJA8WajoJ2NO
         vEpTJoQzJGFk22AJUInx4SYQ0J7p7LOJt1Ydg8IxkRmHfMhCswLK0/HQSo7o8D3tZ356
         QUCpPYTkulA4Tz3kQ384bZUlGrDVPldKaRnxg=
Received: by 10.216.85.14 with SMTP id t14mr124452wee.110.1274877370835; Wed, 
	26 May 2010 05:36:10 -0700 (PDT)
Received: by 10.216.52.74 with HTTP; Wed, 26 May 2010 05:36:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147792>

Commit e498257d introduced a typo while improving the GMail section
of SubmittingPatches.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch was based on 'maint'.

 Documentation/SubmittingPatches |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 22e3808..84248da 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -520,7 +520,7 @@ Gmail

 GMail does not appear to have any way to turn off line wrapping in the web
 interface, so this will mangle any emails that you send.  You can however
-use "git send e-mail" and send your patches through the GMail SMTP server, or
+use "git send-email" and send your patches through the GMail SMTP server, or
 use any IMAP email client to connect to the google IMAP server and forward
 the emails through that.

-- 
1.7.0.2.msysgit.0
