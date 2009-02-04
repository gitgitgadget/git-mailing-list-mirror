From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: [PATCH 1/2] fix typo in Documentation
Date: Thu,  5 Feb 2009 05:00:40 +0800
Message-ID: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Cc: Guanqun Lu <guanqun.lu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 05:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUZqP-0008Mq-Nj
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 05:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBDE5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 23:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZBDE5K
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 23:57:10 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:1412 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZBDE5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 23:57:08 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1238245tic.23
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 20:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=37SlXUDz/sC4eng6+n9wbsWFKzGBRjuF8p0AUxJkH/4=;
        b=EtcK2zDTG3EcJb6ZTvBffiZ4O5Zd4gLzXWC8i4uHadUAmmvdgTDO8pr/euRLzreVLA
         Px1HCViO3ZJlI28UpboLDkev83WMvOa87+yd1GAJO7vcMkJuaGL5/awYbeVEE/lq6zGa
         AmFWqd5m8ne3aRATbD8k0t7+nYE9XRk66PPeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=atCL4JlBh1GUdsGNzlYMoDtSz0jFxUP9Z2Ry4HOUqbkRokr0AGz22TqK27/vYdVtD8
         CihPLtEx2BHfP5mjrNxdp9cnt8BSookzYmqxxTCW0OlVZ/XXM44HnE1L1K+DRKkx87wc
         e529EXk3gbY1DXC3MaOKvDVC4DaYZf097WQFU=
Received: by 10.110.21.17 with SMTP id 17mr9291961tiu.48.1233723427145;
        Tue, 03 Feb 2009 20:57:07 -0800 (PST)
Received: from localhost ([202.120.224.18])
        by mx.google.com with ESMTPS id i6sm1465671tid.36.2009.02.03.20.57.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 20:57:06 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.321.g4a9f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108293>

Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
---
 Documentation/technical/api-strbuf.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 9a4e3ea..ac56d1c 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -21,7 +21,7 @@ allocated memory or not), use `strbuf_detach()` to unwrap a memory
 buffer from its strbuf shell in a safe way. That is the sole supported
 way. This will give you a malloced buffer that you can later `free()`.
 +
-However, it it totally safe to modify anything in the string pointed by
+However, it is totally safe to modify anything in the string pointed by
 the `buf` member, between the indices `0` and `len-1` (inclusive).
 
 . The `buf` member is a byte array that has at least `len + 1` bytes
-- 
1.6.1.2.321.g4a9f7
