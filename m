From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 02/16] t3020 (ls-files-error-unmatch): remove stray '1' from end of file
Date: Sun,  3 Oct 2010 14:00:00 -0600
Message-ID: <1286136014-7728-3-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uhz-0002r3-DV
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab0JCT6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:48 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52092 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab0JCT6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:47 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1157426pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=88XqKjt4iIzeTNwuDLe7YbzEe3RmElBKHqEe8T2s+Ms=;
        b=MU9OiydRwakkcm7KEGwi1GHBK5vOwj8Ak+e184RjyDzjENSAsIthaEFWqEfVUNZ1P8
         vw+nc9UCvOFnRGFrwb6XljYUDcIsmLaKOT9nlEQgxYzP8DGnkSFgKkBcsqBxWOW1scvq
         Nhu3YNrZcPZc0xXAJXSZcMFx1y9gPOUcYWCJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HA/TgwqVB9Xm6zAZkfJw9jjKb79lVup7r42nzhyVtQCN403o/smHKj+N6sXOk+g29d
         o5mgCGc44+P6tjIHoRNK+oJVZ1u9y2SUtGY26BOrU2Agyr7jkgzH5tb17pjqO2aKDIjm
         iETZCZbtdLO/ouknyMIqXsi12RmU+V10/f1Pc=
Received: by 10.114.67.11 with SMTP id p11mr10020940waa.202.1286135927175;
        Sun, 03 Oct 2010 12:58:47 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157899>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.7.3.1.66.gab790
