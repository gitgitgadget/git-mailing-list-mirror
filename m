From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 12/16] t7001 (mv): add missing &&
Date: Sun,  3 Oct 2010 14:00:10 -0600
Message-ID: <1286136014-7728-13-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:00:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2UjS-0003B7-0P
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab0JCT7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab0JCT7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:11 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so946630pwj.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=muO4PLcsLy5lX4OdGRQzJX1ioC6TiuWN5p/1cugDXIo=;
        b=JkrsCbZjLSgNTdBXZd7ZfYAvew+lw1JcR3zdrGILEwa+gGZe+m5Q5er+40/LWMMa82
         LvNoXwby2zPdPchHrekEDQgiIEkiM/hs6L3AfSbItH7kGEgjM6GPpc9D0wQqwoDXGn2x
         9q3wW3EbS8vR2xug6WZhR/jzKqsYvF1hzS7wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pYCgpOWnQo8y8fHGkEfsGJEwwRFlJezpDkcfqQ9hAD2fQEwB2mZkKK/iqhgfwN102E
         d9dVwuyOY3hnDuqMT3HyJ3IBAGKQsIDaxbmTmdQpnE7NyDam2jx2FOvekK+DyDqWiAB2
         obHm38uPOaipUmBazsKLy5hb/xrKHbrTKpkdk=
Received: by 10.114.130.5 with SMTP id c5mr10102547wad.125.1286135950911;
        Sun, 03 Oct 2010 12:59:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157915>

Also, prefix an expected-to-fail git mv command with 'test_must_fail'.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7001-mv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 65a35d9..624e6d2 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -61,7 +61,7 @@ test_expect_success \
 test_expect_success \
     'checking -f on untracked file with existing target' \
     'touch path0/untracked1 &&
-     git mv -f untracked1 path0
+     test_must_fail git mv -f untracked1 path0 &&
      test ! -f .git/index.lock &&
      test -f untracked1 &&
      test -f path0/untracked1'
--=20
1.7.3.1.66.gab790
