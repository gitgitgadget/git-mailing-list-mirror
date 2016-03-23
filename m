From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Wed, 23 Mar 2016 11:55:20 +0100 (CET)
Message-ID: <93fc4beb28097a021b2549ab2c156869c178597d.1458730457.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <cover.1458730457.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-316087508-1458730521=:4690"
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:56:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigSb-0006sy-3P
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbcCWKzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:55:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:53565 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068AbcCWKzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:55:42 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0h9K-1ZuhzL1hXi-00uszX; Wed, 23 Mar 2016 11:55:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458730457.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+zhgAsto8SG2cTHBw/8O5gs2D+i2bwRWWg1ohyuhVWWFLPEkUL+
 unbzJRRfY/UL2NNwun2uVkXbNe1kM6FdtSCbl4qgtxl6duanqPmErxgEfkaycV1FYQo2xkT
 ad7z98F+6qtb02tn0zuObnOFACyAnF8zdcq4vZEK7ovcJGy3gBWMV5WFWao158gFs9n6wqi
 kyTCfvHFg+cRMVl/GzgXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1QvLB5uipvc=:d7/0eUeVhyONdYGodbRdsv
 winoeHrJkaWlTRkGM9CbG0H7kCmamMVphnodFWHt0OdXj+rmMXT4B8uF0v3orKMdS3yHhQl+8
 kNGXH5P72V3u5npG2XzfcX5twYzzpZ8d3/l3M5bjCAYmv5UabYz6Jxq/+ZQpZvDmCqJdzVRj6
 y2uY6UInom7rEd++llDh8HCSi0pCPZh/GlVbw8te1+uW6uThX564iI/UAcaKE8lp5fnBNgfQh
 6a5aCSwSZ+h3xdUV8zfk+Uhfo7wq1sEIAccuOjHKqoP8umXmhOrngSkbmyEU/KNqenxkxbcM/
 oIQpJL3TDbtnw1MporeP7bSHuxsaXwPpZf/ZxFtcEVvGclb5TBrAuXki8EkmE4Sh5B4nwUnrY
 CpzllYb/oToeYwDMdeHkVdmUw5R37eOsi4ZXDB8F64egnqQu5raXMD7Yqh7mcb9d/clMLWej1
 vSMy+M9AoAIDgBzU7VQbijFvfunkAsc1l2778YvJtKquh76QdNrez1gm7jYVDOZR+1dnFNxYP
 ywSAYVHictuDgPjbwuywgTn1IC/7xSfOAJEkuwFauogLRlVkce98qwB8I/ZNseQX5nMjI0BJQ
 GBmAYOWrk+AOkcMAwJ1l0nALxaslB+vfPKV6h491V70tqMDVKSLYTw5fOKYdHrumqvQjHwnpM
 2mxhWWAO59wcKI5IYBgcIDNzPFyW4/JzFvxBK/WTqNclHh0J8hCw9KtQMfTQfLHkd981geN8s
 ovNt9DHDPQZxAp12eqOTpYJL6hdXVf0QRJhZkjVPH2D6JXhTAgKn0OM2PoA9DO1zb3h/2uji 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289644>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-316087508-1458730521=:4690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

These two tests wanted to write file names which are incompatible with
Windows' file naming rules (even if they pass using Cygwin due to
Cygwin's magic path mangling).

While at it, skip the same tests also on MacOSX/HFS, as pointed out by
Torsten B=C3=B6gershausen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9115-git-svn-dcommit-funky-renames.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dco=
mmit-funky-renames.sh
index 0990f8d..a87d3d3 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fresh-=
cloned repository' '
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
 prepare_a_utf8_locale
-test_expect_success UTF8 'svn.pathnameencoding=3Dcp932 new file on dcommit=
' '
+test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=3Dc=
p932 new file on dcommit' '
 =09LC_ALL=3D$a_utf8_locale &&
 =09export LC_ALL &&
 =09neq=3D$(printf "\201\202") &&
@@ -105,7 +105,7 @@ test_expect_success UTF8 'svn.pathnameencoding=3Dcp932 =
new file on dcommit' '
 '
=20
 # See the comment on the above test for setting of LC_ALL.
-test_expect_success 'svn.pathnameencoding=3Dcp932 rename on dcommit' '
+test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=3Dcp932 =
rename on dcommit' '
 =09LC_ALL=3D$a_utf8_locale &&
 =09export LC_ALL &&
 =09inf=3D$(printf "\201\207") &&
--=20
2.7.4.windows.1
--8323329-316087508-1458730521=:4690--
