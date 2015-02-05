From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] Makefile: Improve wording in a comment
Date: Thu, 5 Feb 2015 14:26:34 +0100
Message-ID: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: normalperson@yhbt.net, amyrick@apple.com
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJMSD-0005gN-AC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 14:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbbBEN0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 08:26:36 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:42654 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232AbbBEN0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 08:26:35 -0500
Received: by mail-yk0-f182.google.com with SMTP id q9so3160663ykb.13
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 05:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Y1K6q9D3im8WweEDxoQsj6AGxz9FT+fSRFmqL8op6Pk=;
        b=dziXS0YUZN5dJ0+mPoJRrSt8PiZ/eHtx2H4OLJaOw5s2hhZJIH3gxu5G4/88seQAxW
         6iTWiQHK95moT8d2zOYBgrZtAGcGkofQT3Vm9JR+IDzIy8q5RlvZOQ3gEE7oH9oSht82
         XqADU2BLM1nZQwlZzIHRlaFx+mz6fnC5DpuE6LtBJygsEB3MqBMAd2uZtIupA8DtaQZ2
         CB5HPVbI7pDNtlA1Y8OfUiOLyCrTEjifdwm+R8O/7Kvlazo864mFsuCiauUAOA/r5BvG
         9Up22JnEH63eEexvGKlJG06ecPX60MCsQgb0MhU+PTRsYNIA9+htC6zWTJYRFnH/CNMr
         8WeA==
X-Received: by 10.236.61.138 with SMTP id w10mr1256641yhc.31.1423142794581;
 Thu, 05 Feb 2015 05:26:34 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 05:26:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263371>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c44eb3a..6f8ae23 100644
--- a/Makefile
+++ b/Makefile
@@ -2447,7 +2447,7 @@ check-docs::
         esac; \
     done ) | sort

-### Make sure built-ins do not have dups and listed in git.c
+### Make sure built-ins do not have dupes and are listed in git.c
 #
 check-builtins::
     ./check-builtins.sh
-- 
2.1.2-mingw-1
