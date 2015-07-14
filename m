From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/9] icase match on non-ascii
Date: Tue, 14 Jul 2015 18:42:59 +0200
Message-ID: <55A53C13.5090405@web.de>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, tboegi@web.de
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 18:43:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF3IV-0004f0-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbbGNQnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 12:43:06 -0400
Received: from mout.web.de ([212.227.15.14]:63608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbbGNQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 12:43:05 -0400
Received: from macce.local ([62.75.239.21]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Lgs1W-1YazNz1v3W-00oE8f; Tue, 14 Jul 2015 18:43:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:TXbiAI/nPv1MBrGrhfPRqMj6PqV9INljkG3/vHMWPGTcV8sJv0I
 mmPQ/ldHa3bSDXjXOP4J5ffHDedteG32rNK90FcLaq4MuICaNsYBrVk0MIL1U2rsnB7cdht
 XoRruQ+IaDHss9DapncPxNl+EmdTxGCQKQhcNOgdXQIxRhC6pdowKnTcOOF4w01qytD9xrY
 qzltNHM2QziCZ8dbEYuAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jdcYfJi554M=:6QzfBbnxCYXSoxOA5S7hrm
 F33UwS1R3hEJAQoe5tMZla32lYBB8c2/kJsofFLEKIlll4ZoFzkEuWpjWVV4hfLieVmTnaHmj
 vvadDU26K+QGU2PH8lW1w3iPF3T2+75ds7hbA/6Uwk9QA6rpDlxEccp33X4XKJxZnVJYnbKaL
 4E5exryiUCEMDKrCoDALxw3eYE9i0z/43QtA8SWvgoTm9VjKd/ji+zoIzEX3ZpLSxlHPpQkZI
 hyeMT+3ibKTEvhDIBatlFT3u2uMXYVpHrBuR6mk5qIvNeqnoFiyv2YUUkhc2i6vcwxiDZIfgR
 mvUG9dRkhU8ncLKsiOl6N7cq9uNm7MsUzu1b4Z7/WU9v4OS+tK0OvmYIwihdcUczs0xE3FsQa
 9vuH5ogixTEEcpJLX6uPE5/bBQ+1JvjOMWIj6D9cBeSrRoCBu0UvZ8gG93G2UAO7ZtzCPdF6z
 7zbvewEQVn3ETxsSUfqplR3InjbWSARfEdh1UJfSRz4rMX1tvNy0Se+9UUyARX7l2j/gYESL2
 2GCwDtufVgsauABJHKXPeFwXPe1JkNh+y8XzRUux4njy/lIic44coSBic58MTGiIc0YLmWQCr
 eQRBpFQEptKEcCb9sbapYn9uiEdYgEQ8cERLq+Bpxzcx2Dbw7xWx5HPvjjCRaXjXk1dOoGQsm
 PN5D/KvOn48c+YU5+Pd1TYq7MjjzDGxVRFXge4QHXk64DC7hrrrVzqOHLRqKCXl55NF8zHuKq
 C3uPevE3+yr2YB4X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273966>

(I haven't been able to do more debugging yet,
but this doesn't fully work on my Mac OS X box:)

Initialized empty Git repository in
/Users/tb/NoBackup/projects/git/tb.150714_Duy_grep_utf8/t/trash
directory.t7812-grep-icase-non-ascii/.git/
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
expecting success:
    printf "TILRAUN: Hall=C3=B3 Heimur!" >file &&
    git add file &&
    LC_ALL=3D"$is_IS_locale" &&
    export LC_ALL

ok 1 - setup

expecting success:
    git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
    git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"

file:TILRAUN: Hall=C3=B3 Heimur!
not ok 2 - grep literal string, no -F
#  =20
#        git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
#        git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
#  =20

skipping test: grep pcre utf-8 icase
    git grep --perl-regexp    "TILRAUN: H.ll=C3=B3 Heimur!" &&
    git grep --perl-regexp -i "TILRAUN: H.ll=C3=B3 Heimur!" &&
    git grep --perl-regexp -i "TILRAUN: H.LL=C3=93 HEIMUR!"

ok 3 # skip grep pcre utf-8 icase (missing LIBPCRE of GETTEXT_LOCALE,LI=
BPCRE)

skipping test: grep pcre utf-8 string with "+"
    printf "TILRAUN: Hall=C3=B3=C3=B3 Heimur!" >file2 &&
    git add file2 &&
    git grep -l --perl-regexp "TILRAUN: H.ll=C3=B3+ Heimur!" >actual &&
    echo file >expected &&
    echo file2 >>expected &&
    test_cmp expected actual

ok 4 # skip grep pcre utf-8 string with "+" (missing LIBPCRE of
GETTEXT_LOCALE,LIBPCRE)

expecting success:
    git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/nu=
ll |
         grep fixed >debug1 &&
    echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
    test_cmp expect1 debug1 &&

    git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/nu=
ll |
         grep fixed >debug2 &&
    echo "fixedTILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
    test_cmp expect2 debug2

ok 5 - grep literal string, with -F

expecting success:
    printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&

    git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2=
>&1 >/dev/null |
         grep fixed >debug1 &&
    echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >e=
xpect1 &&
    test_cmp expect1 debug1 &&

    git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  =
2>&1 >/dev/null |
         grep fixed >debug2 &&
    echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >e=
xpect2 &&
    test_cmp expect2 debug2

--- expect1    2015-07-14 16:38:22.000000000 +0000
+++ debug1    2015-07-14 16:38:22.000000000 +0000
@@ -1 +1 @@
-fixed\^*TILR^AUN:\.\* \Hall=C3=B3 $He\[]imur!\$
+fixed\^*TILR^AUN:\.\* \\Hall=C3=B3 $He\[]imur!\$
not ok 6 - grep string with regex, with -F
#  =20
#        printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&
#  =20
#        git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!=
\$" 2>&1
>/dev/null |
#             grep fixed >debug1 &&
#        echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\=
$" >expect1 &&
#        test_cmp expect1 debug1 &&
#  =20
#        git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!=
\$"  2>&1
>/dev/null |
#             grep fixed >debug2 &&
#        echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\=
$" >expect2 &&
#        test_cmp expect2 debug2
#  =20

expecting success:
    git commit -m first &&
    git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
    echo first >expected &&
    test_cmp expected actual

[master (root-commit) e6052d5] first
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
--- expected    2015-07-14 16:38:22.000000000 +0000
+++ actual    2015-07-14 16:38:22.000000000 +0000
@@ -1 +0,0 @@
-first
not ok 7 - pickaxe -i on non-ascii
#  =20
#        git commit -m first &&
#        git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actu=
al &&
#        echo first >expected &&
#        test_cmp expected actual
#  =20

# failed 3 among 7 test(s)
1..7
