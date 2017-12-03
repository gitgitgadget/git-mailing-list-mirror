Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3234320C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdLCV3V (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:64488 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbdLCV3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:20 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MMHaL-1eROB445LJ-0083iH; Sun, 03 Dec 2017 22:28:44 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 5/7] t4013: prepare for upcoming "diff --raw --abbrev" output format change
Date:   Sun,  3 Dec 2017 22:27:41 +0100
Message-Id: <20171203212743.10228-5-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:NdydGIGuoQY9q1uIlC2C1FriZlXehpdagiV7q2WH80mPOUKZLHl
 BhHAckfxwBUhNnfWHxRDI/HQijA0ABea3Di3Ir8lvKEaXJRKfInICEMop3mGn6/QsTAHeNx
 DlF3UrgumX+OL3+iICOgpyZYFmth7BMttUwOAAt5q7dY9lcY8OAwtlB4tREafYqglDiSaLp
 5htN3z1IBuc1+eux5WN4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:31fgWfiN5bs=:Ug2giVBQraLwFGn48BJcV9
 R0jX2cW6eG+2ku8lLvVkhtvRCkz5+aB3pDGztJG0ZNrHDfuROrflGCciH/5uRiSenYGQHsLVn
 3VeAf+kvLiAXL/XIgHaJfDcvNePYFXVYgZAJsxM497LJ+TVATGNjJl2Q1uGvr7bDr2Klx5VSB
 TN1fY8MEBQW9chdCOfBMkBnpHYP7QCT93oC2qgMFwXN+LOHhtATc297XTPRGMCyrJ9Ry2hBok
 Okez8D7EHvFeWT/8Ed9j5yf1zH1ocdGzRqxlqXdVQh4xLBfAP7v2OYSgr45zq95zy5chRfox2
 +G8lbId9vKvDQ0QKRI51uw/hTrGXTXPR7LYl6A8RcBpls0wi3rzwFRxby8dnlrlU3Jv4tI+Bl
 mch6yJ0zuOseiChIfZKRj2oL3MQLXDl683RYCtoJxOOV34RzFOatVjTu47CUsYj246o4k3xwR
 KG7BN0T9FDlVxG6j0MipgOuINmNPhhYxCT9YOjPMArpZDKg9iccSzGXhx/d66V+bDPkhu367/
 sOgi3ltA1S0KG/xsSOUDrQEye9YGB2gIbs+RQJMlV1YXU/KJuVHYPg+veh711ogrbrJOFidDh
 soot1mONxCVWypRtqvIDoJei7COtVhP/rYcmePVx2xMb+EdllOVDfLUopJ0FXqFZaoypLOXuC
 xnla+PVuZJ+MnR1cTS5r1buOGZ0CJme7LWYWp9wsHb1ZN5oPJTkEKLi8kwBUjDT7NSX3R9TkS
 V7H92omVUrgvc/7YI2MhWoSjKQOJs4GBzn3WcmT/A5CyMVbVqNvoUImgyNxBFR3FqEKKOxc0n
 d0Z7vJxg7lHcGyPMgiiCvex4iAbOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the t4013 tests go through a list of sample command lines,
and each of them is executed and its output compared with an
expected one stored in t4013/ directory.  Allow these lines to begin
with a colon followed by magic word(s) so that test conditions can
easily be tweaked.

The expected use that will happen in later steps of this is to run
tests expecting the traditional output and run the same test without
the GIT_PRINT_SHA1_ELLIPSIS=yes environment exported for (perhaps
some of) them, which will have to expect different output.  Since
all of the existing tests are meant to run with the environment,
use the magic word "noellipses" to cause the variable not to be set
and exported.

As this step does not add any new test with the magic word, all
tests still run with the environment variable, expecting the
traditional output, but it will change soon.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 t/t4013-diff-various.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9bed64d53e01..7288b540450f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -118,20 +118,37 @@ test_expect_success setup '
 EOF
 
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
-while read cmd
+while read magic cmd
 do
-	case "$cmd" in
-	'' | '#'*) continue ;;
+	case "$magic" in
+	'' | '#'*)
+		continue ;;
+	:*)
+		magic=${magic#:}
+		label="$magic-$cmd"
+		case "$magic" in
+		noellipses) ;;
+		*)
+			die "bug in t4103: unknown magic $magic" ;;
+		esac ;;
+	*)
+		cmd="$magic $cmd" magic=
+		label="$cmd" ;;
 	esac
-	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
+	test=$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
 	pfx=$(printf "%04d" $test_count)
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
 	test_expect_success "git $cmd" '
 		{
-			echo "\$ git $cmd"
-			GIT_PRINT_SHA1_ELLIPSIS="yes" git $cmd |
+			echo "$ git $cmd"
+			case "$magic" in
+			"")
+				GIT_PRINT_SHA1_ELLIPSIS=yes git $cmd ;;
+			noellipses)
+				git $cmd ;;
+			esac |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
-- 
2.13.6

