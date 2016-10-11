Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6FD207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 08:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbcJKIMb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 04:12:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36712 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbcJKIMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 04:12:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id b75so2278272lfg.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BBzEn/Sc+tZq/Rui5vNrF9A7szUVSS3Gec4/GR2BBMs=;
        b=LmJy36fUJiQ8SUR4tSgQitMIdeUCOOR3KdmNQiXW2GFjz1Yo798wSSI1zz25ba4SWt
         2IXEi3DnLJc/MH/cWNsMKvk4TTWnSZ7N2EDLWgiuBGjbIyM557e/BQqczyPhGTxYeYNJ
         wW6K3tTiqWcXSnpLln2uedOG/rGiIhS45bSt4z6DWe6fHVExGVT6L7umpKTNerB7Py3B
         ziXoKL/RhCYG6gzzH0QxyNqa4JkluLaFSN+MYc60FPG5MQNsRvbjoO4yoeGpDxK2VeHr
         NiMIBky9d6HFeKzWwH/JBilxJ8xulbCt+2rGNm7A4vXTp0HXasWbngh9W6O0rAPNK85Y
         tBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BBzEn/Sc+tZq/Rui5vNrF9A7szUVSS3Gec4/GR2BBMs=;
        b=WpXZZW9filMA1bYcWhpV0NXKddOGR4+RUs1KhLGUhj8jUGef6NaYPCwPvss0mxgoWl
         a8UhGzhdDhYE/5AxWf0v+dXEvDi33I04+4o8EmwkuEo8SN8OhQx1yW74MSgExf81Lxe+
         Np1rxmDBVnqf9fetHG4BXevAGJvEGK60+sfJz1YK3RLdauOwAsLqvtwSl3BSul8nCels
         U6reimgh/bpqwopB/X8+y8ZBikHw/Mci4GrT88iztLrBAcyCNgr0+8PHPO6YTmOVTiRB
         l9/oo43uFjckg/1sMH/jiUFIh56QAryjLDvdgvuTLpop7WCE23PvrtLuecBFWt2ygNFb
         H6Mw==
X-Gm-Message-State: AA6/9RkCarfJ06isftE1iFEyR47lkyj6QFHjx608ja9RpKCDWmUDFNWk2q6BNj0rmW3BlA==
X-Received: by 10.194.127.5 with SMTP id nc5mr3226089wjb.16.1476173483486;
        Tue, 11 Oct 2016 01:11:23 -0700 (PDT)
Received: from [10.54.172.123] ([88.128.80.187])
        by smtp.gmail.com with ESMTPSA id y2sm4274508wjx.20.2016.10.11.01.11.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 01:11:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqint0dlis.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 11 Oct 2016 10:11:22 +0200
Cc:     git <git@vger.kernel.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <02E73D87-B036-40CA-AF54-F93415A028BC@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-14-larsxschneider@gmail.com> <xmqqint0dlis.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Oct 2016, at 21:58, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
> [...]
>> +# Count unique lines except clean invocations in two files and =
compare
>> +# them. Clean invocations are not counted because their number can =
vary.
>> +# c.f. =
http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
>> +test_cmp_count_except_clean () {
>> +	for FILE in $@
>> +	do
>> +		sort $FILE | uniq -c | sed "s/^[ ]*//" |
>> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" =
>$FILE.tmp
>> +		cat $FILE.tmp >$FILE
>> +	done &&
>> +	test_cmp $@
>> +}
>=20
> Why do you even _care_ about the number of invocations?  While I
> told you why "clean" could be called multiple times under racy Git
> as an example, that was not meant to be an exhaustive example.  I
> wouldn't be surprised if we needed to run smudge twice, for example,
> in some weirdly racy cases in the future.
>=20
> Can we just have the correctness (i.e. "we expect that the working
> tree file gets this as the result of checking it out, and we made
> sure that is the case") test without getting into such an
> implementation detail?

My goal is to check that clean/smudge is invoked at least once. I could
just run `uniq` to achieve that but then all other filter commands could
happen multiple times and the test would not detect that.

I also prefer to check the filter commands to ensure the filter is=20
working as expected (e.g. no multiple start ups etc) in addition to=20
checking the working tree.

Would the patch below work for you? If yes, then please squash it into
"convert: add filter.<driver>.process option".

Thank you,
Lars



diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9f892c0..714f706 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -31,38 +31,33 @@ filter_git () {
 	rm -f git-stderr.log
 }
=20
-# Count unique lines in two files and compare them.
-test_cmp_count () {
-	for FILE in $@
-	do
-		sort $FILE | uniq -c | sed "s/^[ ]*//" >$FILE.tmp
-		cat $FILE.tmp >$FILE
-	done &&
-	test_cmp $@
-}
-
-# Count unique lines except clean invocations in two files and compare
-# them. Clean invocations are not counted because their number can =
vary.
+# Compare two files and ensure that `clean` and `smudge` respectively =
are
+# called at least once if specified in the `expect` file. The actual
+# invocation count is not relevant because their number can vary.
 # c.f. =
http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
-test_cmp_count_except_clean () {
-	for FILE in $@
+test_cmp_count () {
+	expect=3D$1 actual=3D$2
+	for FILE in "$expect" "$actual"
 	do
-		sort $FILE | uniq -c | sed "s/^[ ]*//" |
-			sed "s/^\([0-9]\) IN: clean/x IN: clean/" =
>$FILE.tmp
-		cat $FILE.tmp >$FILE
+		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
+			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" =
>"$FILE.tmp" &&
+		cat "$FILE.tmp" >"$FILE"
 	done &&
-	test_cmp $@
+	test_cmp "$expect" "$actual"
 }
=20
-# Compare two files but exclude clean invocations because they can =
vary.
+# Compare two files but exclude all `clean` invocations because Git can
+# call `clean` zero or more times.
 # c.f. =
http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_exclude_clean () {
-	for FILE in $@
+	expect=3D$1 actual=3D$2
+	for FILE in "$expect" "$actual"
 	do
-		grep -v "IN: clean" $FILE >$FILE.tmp
-		cat $FILE.tmp >$FILE
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
+		cat "$FILE.tmp" >"$FILE"
 	done &&
-	test_cmp $@
+	test_cmp "$expect" "$actual"
 }
=20
 # Check that the contents of two files are equal and that their rot13 =
version
@@ -395,7 +390,7 @@ test_expect_success PERL 'required process filter =
should filter data' '
 			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_count_except_clean expected.log =
rot13-filter.log &&
+		test_cmp_count expected.log rot13-filter.log &&
=20
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x.r" &&

