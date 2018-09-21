Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B024C1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbeIVFuO (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:50:14 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55700 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:50:14 -0400
Received: by mail-qk1-f201.google.com with SMTP id z18-v6so14409757qki.22
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YI6hWQXG0v7rFU8i2z0qKkYCjrGtzwDLxzlk5N7gKHk=;
        b=pP1R9eAoTOoVYw5KmVY5zS1BlLFjh78nH3dGavunmHVJMEc5YFLlkOBKFZUKtj8X2G
         KYiY3BjMO3A3GhYqQvchhpQSkesjEPtHkV1sszjgzGhmxkm/3fQ69JF4T/CU7qJaNiXn
         IRv6ltm9vHnItDSjvxfdXX1/i4HWo2mExLj02+y++PuQi/HNzgKgYWiaL7eqy4Xiba0P
         k6/de6YeBRPehlEcVbL9QkTnkv0yRdIj8y8JiJlPep7TNQmnvz4GrX9UnflNKwcTqMqO
         vgjxSr0Y74Q7C1//CvQmJJnOO/T+h/SRn346L4exF5JxjYoy93M7zpuRYHYxbSxH8aJi
         Lziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YI6hWQXG0v7rFU8i2z0qKkYCjrGtzwDLxzlk5N7gKHk=;
        b=GPOKuNQffsX0KI35Sw2GJjPPy2iwdr1wNALmMfkDbGq4xrQ5mLwryLv+BdmzNpnT+L
         wZSnq+fCyseGCTu1rIfxdt4WqmeXsHsRLrz1BDk0OyBhsO13HetrMujq5Olgpzf+OC1r
         sCrroqoYdxIA1y8+PSAqbp1NG7Ul+zGjWslEqGt/rsGlgkKCfKdZqZzqRDzXYcxfUlZI
         vJ/Ouzpn1gOsJ6xanUXa6d8Grrd3J6ahyfv0FtW8ZCRs7RufZzTmnDCVA9cxz4GhTSiZ
         A3ycmVKN37uBWvtxP+cX60E8UG4iglBj+jEVWat6EQDQBniQcgD18Vxsi2sYvIdfYE/B
         p9SA==
X-Gm-Message-State: ABuFfojueHbUlTQEQMtYuUNCzYd4dCfYJDeNVE6p4VFd5hla//dV4SLO
        XdbOEhdgyewY49OcPH7UdixtJVROvsPAI1e08co98xyth8r+bE/tVp1le9resuoI6PGIGH5LSvc
        PmM3K2Xso8y+idzyoLETho+5JD+UloF+f4fzlYSPZ8Hr61ToOstJ1SlBnz1Ks
X-Google-Smtp-Source: ANB0VdZTURK3/7lXrvsEwUj9/FQ8Aace4W5N/Byzhq/n/6PbiRrRuKOHBWujm0YAyi6pG1jykZxogY4a3Hud
X-Received: by 2002:aed:38e6:: with SMTP id k93-v6mr28037qte.46.1537574340300;
 Fri, 21 Sep 2018 16:59:00 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:58:32 -0700
In-Reply-To: <20180921235833.99045-1-sbeller@google.com>
Message-Id: <20180921235833.99045-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180921235833.99045-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 2/3] t7004: reformat style
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7004-tag.sh | 149 +++++++++++++++++++------------------------------
 1 file changed, 56 insertions(+), 93 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0b01862c23a..03a96b7f79e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -144,26 +144,25 @@ test_expect_success 'listing a tag using a matching pattern should succeed' \
 test_expect_success 'listing a tag with --ignore-case' \
 	'test $(git tag -l --ignore-case MYTAG) = mytag'
 
-test_expect_success \
-	'listing a tag using a matching pattern should output that tag' \
-	'test $(git tag -l mytag) = mytag'
+test_expect_success 'listing a tag using a matching pattern should output that tag'  '
+	test $(git tag -l mytag) = mytag
+'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should succeed' \
-	'git tag -l xxx'
+test_expect_success 'listing tags using a non-matching pattern should succeed'  '
+	git tag -l xxx
+'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should output nothing' \
-	'test $(git tag -l xxx | wc -l) -eq 0'
+test_expect_success 'listing tags using a non-matching pattern should output nothing'  '
+	test $(git tag -l xxx | wc -l) -eq 0
+'
 
 # special cases for creating tags:
 
-test_expect_success \
-	'trying to create a tag with the name of one existing should fail' \
-	'test_must_fail git tag mytag'
+test_expect_success 'trying to create a tag with the name of one existing should fail'  '
+	test_must_fail git tag mytag
+'
 
-test_expect_success \
-	'trying to create a tag with a non-valid name should fail' '
+test_expect_success 'trying to create a tag with a non-valid name should fail' '
 	test $(git tag -l | wc -l) -eq 1 &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
@@ -201,15 +200,13 @@ cat >expect <<EOF
 myhead
 mytag
 EOF
-test_expect_success \
-	'trying to delete tags without params should succeed and do nothing' '
+test_expect_success 'trying to delete tags without params should succeed and do nothing' '
 	git tag -l > actual && test_cmp expect actual &&
 	git tag -d &&
 	git tag -l > actual && test_cmp expect actual
 '
 
-test_expect_success \
-	'deleting two existing tags in one command should succeed' '
+test_expect_success 'deleting two existing tags in one command should succeed' '
 	tag_exists mytag &&
 	tag_exists myhead &&
 	git tag -d mytag myhead &&
@@ -217,15 +214,13 @@ test_expect_success \
 	! tag_exists myhead
 '
 
-test_expect_success \
-	'creating a tag with the name of another deleted one should succeed' '
+test_expect_success 'creating a tag with the name of another deleted one should succeed' '
 	! tag_exists mytag &&
 	git tag mytag &&
 	tag_exists mytag
 '
 
-test_expect_success \
-	'trying to delete two tags, existing and not, should fail in the 2nd' '
+test_expect_success 'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
 	! tag_exists myhead &&
 	test_must_fail git tag -d mytag anothertag &&
@@ -270,8 +265,7 @@ a1
 aa1
 cba
 EOF
-test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
+test_expect_success 'listing tags with substring as pattern must print those matching' '
 	rm *a* &&
 	git tag -l "*a*" > current &&
 	test_cmp expect current
@@ -281,8 +275,7 @@ cat >expect <<EOF
 v0.2.1
 v1.0.1
 EOF
-test_expect_success \
-	'listing tags with a suffix as pattern must print those matching' '
+test_expect_success 'listing tags with a suffix as pattern must print those matching' '
 	git tag -l "*.1" > actual &&
 	test_cmp expect actual
 '
@@ -291,8 +284,7 @@ cat >expect <<EOF
 t210
 t211
 EOF
-test_expect_success \
-	'listing tags with a prefix as pattern must print those matching' '
+test_expect_success 'listing tags with a prefix as pattern must print those matching' '
 	git tag -l "t21*" > actual &&
 	test_cmp expect actual
 '
@@ -300,8 +292,7 @@ test_expect_success \
 cat >expect <<EOF
 a1
 EOF
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	git tag -l a1 > actual &&
 	test_cmp expect actual
 '
@@ -309,8 +300,7 @@ test_expect_success \
 cat >expect <<EOF
 v1.0
 EOF
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	git tag -l v1.0 > actual &&
 	test_cmp expect actual
 '
@@ -319,14 +309,12 @@ cat >expect <<EOF
 v1.0.1
 v1.1.3
 EOF
-test_expect_success \
-	'listing tags with ? in the pattern should print those matching' '
+test_expect_success 'listing tags with ? in the pattern should print those matching' '
 	git tag -l "v1.?.?" > actual &&
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using v.* should print nothing because none have v.' '
+test_expect_success 'listing tags using v.* should print nothing because none have v.' '
 	git tag -l "v.*" > actual &&
 	test_must_be_empty actual
 '
@@ -337,8 +325,7 @@ v1.0
 v1.0.1
 v1.1.3
 EOF
-test_expect_success \
-	'listing tags using v* should print only those having v' '
+test_expect_success 'listing tags using v* should print only those having v' '
 	git tag -l "v*" > actual &&
 	test_cmp expect actual
 '
@@ -404,8 +391,7 @@ EOF
 
 # creating and verifying lightweight tags:
 
-test_expect_success \
-	'a non-annotated tag created without parameters should point to HEAD' '
+test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
 	test $(git cat-file -t non-annotated-tag) = commit &&
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
@@ -414,13 +400,13 @@ test_expect_success \
 test_expect_success 'trying to verify an unknown tag should fail' \
 	'test_must_fail git tag -v unknown-tag'
 
-test_expect_success \
-	'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git tag -v non-annotated-tag'
+test_expect_success 'trying to verify a non-annotated and non-signed tag should fail'  '
+	test_must_fail git tag -v non-annotated-tag
+'
 
-test_expect_success \
-	'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+test_expect_success 'trying to verify many non-annotated or unknown tags, should fail'  '
+	test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2
+'
 
 # creating annotated tags:
 
@@ -444,8 +430,7 @@ time=$test_tick
 
 get_tag_header annotated-tag $commit commit $time >expect
 echo "A message" >>expect
-test_expect_success \
-	'creating an annotated tag with -m message should succeed' '
+test_expect_success 'creating an annotated tag with -m message should succeed' '
 	git tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
 	test_cmp expect actual
@@ -459,8 +444,7 @@ test_expect_success 'set up editor' '
 	mv "$1-" "$1"
 	EOF
 '
-test_expect_success \
-	'creating an annotated tag with -m message --edit should succeed' '
+test_expect_success 'creating an annotated tag with -m message --edit should succeed' '
 	GIT_EDITOR=./fakeeditor git tag -m "A message" --edit annotated-tag-edit &&
 	get_tag_msg annotated-tag-edit >actual &&
 	test_cmp expect actual
@@ -472,8 +456,7 @@ in a file.
 EOF
 get_tag_header file-annotated-tag $commit commit $time >expect
 cat msgfile >>expect
-test_expect_success \
-	'creating an annotated tag with -F messagefile should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile should succeed' '
 	git tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
 	test_cmp expect actual
@@ -487,8 +470,7 @@ test_expect_success 'set up editor' '
 	mv "$1-" "$1"
 	EOF
 '
-test_expect_success \
-	'creating an annotated tag with -F messagefile --edit should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile --edit should succeed' '
 	GIT_EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
 	get_tag_msg file-annotated-tag-edit >actual &&
 	test_cmp expect actual
@@ -506,16 +488,14 @@ test_expect_success 'creating an annotated tag with -F - should succeed' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'trying to create a tag with a non-existing -F file should fail' '
+test_expect_success 'trying to create a tag with a non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists notag &&
 	test_must_fail git tag -F nonexistingfile notag &&
 	! tag_exists notag
 '
 
-test_expect_success \
-	'trying to create tags giving both -m or -F options should fail' '
+test_expect_success 'trying to create tags giving both -m or -F options should fail' '
 	echo "message file 1" >msgfile1 &&
 	echo "message file 2" >msgfile2 &&
 	! tag_exists msgtag &&
@@ -524,15 +504,14 @@ test_expect_success \
 	test_must_fail git tag -F msgfile1 -m "message 1" msgtag &&
 	! tag_exists msgtag &&
 	test_must_fail git tag -m "message 1" -F msgfile1 \
-		-m "message 2" msgtag &&
+	-m "message 2" msgtag &&
 	! tag_exists msgtag
 '
 
 # blank and empty messages:
 
 get_tag_header empty-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -m message should succeed' '
+test_expect_success 'creating a tag with an empty -m message should succeed' '
 	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
 	test_cmp expect actual
@@ -540,8 +519,7 @@ test_expect_success \
 
 >emptyfile
 get_tag_header emptyfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -F messagefile should succeed' '
+test_expect_success 'creating a tag with an empty -F messagefile should succeed' '
 	git tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -561,16 +539,14 @@ Trailing spaces
 
 Trailing blank lines
 EOF
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
+test_expect_success 'extra blanks in the message for an annotated tag should be removed' '
 	git tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
 get_tag_header blank-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -m message with spaces should succeed' '
+test_expect_success 'creating a tag with blank -m message with spaces should succeed' '
 	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
 	test_cmp expect actual
@@ -580,8 +556,7 @@ echo '     ' >blankfile
 echo ''      >>blankfile
 echo '  '    >>blankfile
 get_tag_header blankfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -F messagefile with spaces should succeed' '
+test_expect_success 'creating a tag with blank -F messagefile with spaces should succeed' '
 	git tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -589,8 +564,7 @@ test_expect_success \
 
 printf '      ' >blanknonlfile
 get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with -F file of spaces and no newline should succeed' '
+test_expect_success 'creating a tag with -F file of spaces and no newline should succeed' '
 	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -624,16 +598,14 @@ Another line.
 
 Last line.
 EOF
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
+test_expect_success 'creating a tag using a -F messagefile with #comments should succeed' '
 	git tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
 get_tag_header comment-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a #comment in the -m message should succeed' '
+test_expect_success 'creating a tag with a #comment in the -m message should succeed' '
 	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
 	test_cmp expect actual
@@ -643,8 +615,7 @@ echo '#comment' >commentfile
 echo ''         >>commentfile
 echo '####'     >>commentfile
 get_tag_header commentfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with #comments in the -F messagefile should succeed' '
+test_expect_success 'creating a tag with #comments in the -F messagefile should succeed' '
 	git tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -652,8 +623,7 @@ test_expect_success \
 
 printf '#comment' >commentnonlfile
 get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a file of #comment and no newline should succeed' '
+test_expect_success 'creating a tag with a file of #comment and no newline should succeed' '
 	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -661,8 +631,7 @@ test_expect_success \
 
 # listing messages for annotated non-signed tags:
 
-test_expect_success \
-	'listing the one-line message of a non-signed tag should succeed' '
+test_expect_success 'listing the one-line message of a non-signed tag should succeed' '
 	git tag -m "A msg" tag-one-line &&
 
 	echo "tag-one-line" >expect &&
@@ -701,8 +670,7 @@ test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing the zero-lines message of a non-signed tag should succeed' '
+test_expect_success 'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
 
 	echo "tag-zero-lines" >expect &&
@@ -729,8 +697,7 @@ test_expect_success \
 echo 'tag line one' >annotagmsg
 echo 'tag line two' >>annotagmsg
 echo 'tag line three' >>annotagmsg
-test_expect_success \
-	'listing many message lines of a non-signed tag should succeed' '
+test_expect_success 'listing many message lines of a non-signed tag should succeed' '
 	git tag -F annotagmsg tag-lines &&
 
 	echo "tag-lines" >expect &&
@@ -1372,13 +1339,11 @@ test_expect_success GPG \
 	'verify signed tag fails when public key is not present' \
 	'test_must_fail git tag -v signed-tag'
 
-test_expect_success \
-	'git tag -a fails if tag annotation is empty' '
+test_expect_success 'git tag -a fails if tag annotation is empty' '
 	! (GIT_EDITOR=cat git tag -a initial-comment)
 '
 
-test_expect_success \
-	'message in editor has initial comment' '
+test_expect_success 'message in editor has initial comment' '
 	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
 '
 
@@ -1389,8 +1354,7 @@ test_expect_success 'message in editor has initial comment: first line' '
 	test_i18ncmp first.expect first.actual
 '
 
-test_expect_success \
-	'message in editor has initial comment: remainder' '
+test_expect_success 'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
 	sed -e 1d -e "/^#/d" <actual >rest.actual &&
 	test_must_be_empty rest.actual
@@ -1398,8 +1362,7 @@ test_expect_success \
 
 get_tag_header reuse $commit commit $time >expect
 echo "An annotation to be reused" >> expect
-test_expect_success \
-	'overwriting an annoted tag should use its previous body' '
+test_expect_success 'overwriting an annoted tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
 	GIT_EDITOR=true git tag -f -a reuse &&
 	get_tag_msg reuse >actual &&
-- 
2.19.0.444.g18242da7ef-goog

