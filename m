From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 01/15] t3020 (ls-files-error-unmatch): remove stray '1' from end of file
Date: Sun, 26 Sep 2010 17:14:25 -0600
Message-ID: <1285542879-16381-2-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00PJ-0005V8-Ey
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026Ab0IZXNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45170 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757639Ab0IZXNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:04 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1218934pxi.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ywy9OzBbTswKqPXQidkBiTS8Bn2d0Fu/zUpr0dqyA3U=;
        b=r7uTJEtvHvjDzLUZCufpKZS7A57fuvIew1/lAnUskeLIKeVIbeuV6qoBxEYEPaWOxH
         1+Th26NAXP0nsNLtyd7ckQwpX3jYAg1wUwXpvMW2SC0kU3TJZq5VtciX22JWFsj44w1J
         CxeH8BAP0ruTfu14vs2FiZBsCRYFoOgmXINEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KKYjWUlNd3eWC761SV0EVkapDiRf8Kka7wFMlZ3pNgLS8GwfQiN7aRR/YkmWJ1VAX2
         VcB3oxl8hbITqkaThqgTgzAEaJQ9y46g6tsT/e32m2cXi+WFsrlXCXy6l1bAlWhAbtne
         UpdSfkRMNR1AuJXVDVZY+xTggBq+ajEb2qZAE=
Received: by 10.114.75.17 with SMTP id x17mr7337628waa.177.1285542783908;
        Sun, 26 Sep 2010 16:13:03 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157269>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3020-ls-files-error-unmatch.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error=
-unmatch.sh
index a7d8187..ca01053 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -26,4 +26,3 @@ test_expect_success \
     'git ls-files --error-unmatch foo bar'
=20
 test_done
-1
--=20
1.7.3.95.g14291
