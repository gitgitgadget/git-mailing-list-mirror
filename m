From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/9] icase match on non-ascii
Date: Wed, 15 Jul 2015 21:51:53 +0200
Message-ID: <55A6B9D9.2070102@web.de>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <55A53C13.5090405@web.de>
 <CACsJy8BXGt25tGoarry=UQS6E4Q54kicG5oY9uoU6W_hw1wYtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:52:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFSiz-0001RJ-A6
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 21:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbbGOTwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2015 15:52:08 -0400
Received: from mout.web.de ([212.227.17.11]:63687 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbbGOTwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 15:52:06 -0400
Received: from macce.local ([80.237.177.148]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MWj6V-1ZUaza1yEl-00XxS5; Wed, 15 Jul 2015 21:52:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <CACsJy8BXGt25tGoarry=UQS6E4Q54kicG5oY9uoU6W_hw1wYtg@mail.gmail.com>
X-Provags-ID: V03:K0:y/JAymiL1GIEm0giFjvf5xlLVTa4FHsW+pJ0mgy00CK0ig6VHex
 qBi706O4k4DQikftVoGEt1hVHjcj8skyUgPpoNRsBYciuSyp4pgdYcpO6x7UiD8DR9tl3WB
 UuPr6L8EF6szTAWhDyRJt8XOBNqUXNoJt8acQ5ZomFyE7q0MZSTUrJDviXxAXasrzIxI9jR
 8++zw3BE3DRd7W8E9xQuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SzkcTALxtiU=:9GW82LC+7QXIYDQaIQoqPj
 P4nAuJBeeccYumRxSgNs8thglGKI+nxGL/VClm6Oq42zUoAKCLzaVfT+BjYs8niMBq4mRBa3C
 kRCWzmXgFzWR0OGSrpwbfvzENtVVIJpp/8mrDTKMmNjxk5QrWJXqrWzY3dgDC5sAbk+YnESw2
 43du/lwlAJVyOMyFqf4O1HiY39gD+S5IKu8lLrA+fZNrVkeHQ52uoM+I1Guf+kMaYBfog0sWy
 iUnV+wWStRbQDVwPfECW0Cr7X19VqyPV/789DKn9cZw+HBGXeXg0vjjjoSEGTDs/z5Vm3LP64
 IoAXEpm4R5dzgzWpjNukZzRMsQ8Tx4ZOwLYfYdqWSUDFHyOJekOfAWB9NlNvEAgVN7dyjSWQ3
 kvhh0dENOVvi9RorBHaJHSO2bBQQVsNCYxLlyAM/+JAvPKqJVmSgPBKXt6YUS1OON7tkEdl5Q
 SDPBhPNRyro+G0eFos1TCpDqSyPnohjMF23EMQI3J/4AWUsRrk6BxEmWDwSgZKnNBtWT3jmRE
 +RmZ7TTcGADFXn2qnfWPsw5pyV7DCFVFXDuyM0KGM/jqPBcQz4WgWmcmUe/fbEQWVmgk9t6WU
 o77+nZHamaGkiKoXimieZSGLzh1r+TA0uAUSiCEaB3y/z1SxdH4h3Y2M+weB7cP+KwwerOQKo
 m3exBCkk4oD2N+ZND0rh0iR2HWiu4CrgVISkPLJQPGFB9jWE0NqhL3vSv8C5Sa7zNsJjk1VJ/
 Ze3VwImvYktfH9Fk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273996>

> I don't see any way around it, except dropping all the tests. I don't
> think there is a way for us to test regex locale support at runtime.
>=20
(I don't think dropping all tests is a good way forward)
Either there is runtime code similar to test-regex.c,
or how about something like this:

commit a1cdac0fc0df1dad20f4dc196688a73c11b00480
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Wed Jul 15 21:43:47 2015 +0200

    t7812: More LIBPCRE preconditions

    Some (e.g. BSD based) regex libraries are not able to handle
    UTF-8 strings case-insensitive (if asked so)

    Exclude some test cases by using the LIBPCRE precondition

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index d07fa20..30d3d68 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -11,9 +11,12 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 	export LC_ALL
 '

-test_expect_success GETTEXT_LOCALE 'grep literal string, no -F' '
-	git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
-	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
+test_expect_success GETTEXT_LOCALE 'grep literal low string, no -F' '
+	git grep -i "TILRAUN: Hall=C3=B3 Heimur!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep literal up string, no=
 -F' '
+	git grep -i "TILRAUN: HALL=C3=93. HEIMUR!"
 '

 test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
@@ -31,33 +34,37 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pc=
re utf-8
string with "+"' '
 	test_cmp expected actual
 '

-test_expect_success GETTEXT_LOCALE 'grep literal string, with -F' '
+test_expect_success GETTEXT_LOCALE 'grep literal low string, with -F' =
'
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
 	echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
-	test_cmp expect1 debug1 &&
+	test_cmp expect1 debug1
+'

+test_expect_success GETTEXT_LOCALE 'grep literal up string, with -F' '
 	git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug2 &&
 	echo "fixedTILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
 	test_cmp expect2 debug2
 '

-test_expect_success GETTEXT_LOCALE 'grep string with regex, with -F' '
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep string with regex, wi=
th -F' '
 	printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&

 	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
 		 grep fixed >debug1 &&
 	echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >exp=
ect1 &&
-	test_cmp expect1 debug1 &&
+	test_cmp expect1 debug1
+'

+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep up string with regex,=
 with -F' '
 	git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  2>=
&1 >/dev/null |
 		 grep fixed >debug2 &&
 	echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >exp=
ect2 &&
 	test_cmp expect2 debug2
 '

-test_expect_success GETTEXT_LOCALE 'pickaxe -i on non-ascii' '
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'pickaxe -i on non-ascii' '
 	git commit -m first &&
 	git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
 	echo first >expected &&
