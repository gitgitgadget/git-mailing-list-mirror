From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 7/7] t5540-http-push: remove redundant fetches
Date: Sun, 25 Oct 2009 23:24:01 +0800
Message-ID: <20091025232401.e82925a9.rctay89@gmail.com>
References: <20091025232310.2c512a1b.rctay89@gmail.com>
 <20091025232227.96769e50.rctay89@gmail.com>
 <20091025232142.6558d9e4.rctay89@gmail.com>
 <20091025232044.06d7ce5c.rctay89@gmail.com>
 <20091025231932.be9a6dfa.rctay89@gmail.com>
 <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24x4-0002bS-VT
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbZJYPYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZJYPYE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:24:04 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:53723 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZJYPYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:24:02 -0400
Received: by gxk8 with SMTP id 8so12603328gxk.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Fu3DnPB7Ds2SWC15m7jJ5gLOjPbOYV7XF1aZiMG0MRM=;
        b=aMt62/TcgSnI36W62U8MRPq5C0lTQER98peSX08tRKkw7bl9nz4W3IlXtdHFH+0Td8
         QXDEnqTjUcJ2eSqJap/nBE0T/KQbc0y5Zpi6Z6BYmFxyeZpDd3SwIYumGfsFGFQp8ggk
         dQi/sDVZCWw6JHQdX8DUp1r4lUXaq5UwXRHjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=K6Fu6OqsgnUjhxKUEM35Z9vHS0As1EQQgxLuwuIcj22KhFsPvPxYLX16yPRH1l8x5k
         rhJqzeKjy3up1KgHugcpmI47tmYFtW5z2iejLaeBHN3LLOqbWTKFfR7QplS08eTUr1HZ
         /+bS9N0xr2CEgBhpZ+zjcnOYI4pY/GhsCt8PQ=
Received: by 10.101.205.8 with SMTP id h8mr5242466anq.142.1256484247131;
        Sun, 25 Oct 2009 08:24:07 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 6sm895183yxg.30.2009.10.25.08.24.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:24:06 -0700 (PDT)
In-Reply-To: <20091025232310.2c512a1b.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131214>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 6bb5afa..3852dcb 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -114,9 +114,7 @@ test_expect_success 'create and delete remote branch' '
 	test_tick &&
 	git commit -m dev &&
 	git push origin dev &&
-	git fetch &&
 	git push origin :dev &&
-	git fetch &&
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '

--
1.6.4.4
