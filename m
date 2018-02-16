Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B70E1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755699AbeBPQ6f (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 11:58:35 -0500
Received: from mout.web.de ([212.227.17.11]:36931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbeBPQ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 11:58:33 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGaV-1ez9nW2B8d-00E41J; Fri, 16
 Feb 2018 17:58:17 +0100
Date:   Fri, 16 Feb 2018 17:58:15 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, lars.schneider@autodesk.com,
        git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180216165815.GA4681@tor.lan>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:uFHSS2yXmiV2w5V/4DxCLLYMgw2wntKBLw7XX+RO/letDtb+Bww
 2j0gimi8pPeQSkeYDo3veOvtj27XKsEAfxYhdGVvEOmW484UtfJxBsrn1fKzMWH/NucLC9V
 O9UfOKrDTOJA2gQfvI3q77pKHhU4nxJmwBcFYWtBXjNoKeUWgXHjQBew/zdRy/RK9fRoYTg
 LmTeeLbQtC/iEaA0XOL8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b/bWJydjhs0=:g4K2lBZ0N5COkobTmPpfXQ
 c1/dyg1ipafZOBy+o//H2rMeNgvVpEscAk7mX2wLjhPm2UOUDLpqicqNQTQrF305IxM1LIO/3
 X8KkecSzsTSboYy0zL7/0715qfkqGIgsMwfPnpFcLIe9sPpcekxu2UWmyVdTWsMIluBe0v4My
 EznKT7IbxrmvzRfuW17heY9d+fIwyMX5uGd9LWBNDweyetQCPvNnbUQc6C+Y9+EC57uDfuv6X
 uV87jRj7tKmCCj0WP//Kbru59HeADp8h3kuxsRAvM5GBL+BBxDF1nTwch8vbqZAV/yJwG7Kz9
 IMwC24Gv3qTa5uRbaYR2+UuReScyI1CSmxjZxmnk9sYV1QwVm4Y1MqrBwchjN83DGl0g4zn5n
 L0CqHp/72VHeVAvwNLTmnDPq0icV7Pimo9fvREP30a5xtvex6D9F4lnobBzc1jMd4iyVLKsCb
 DzCrjOb5wh8fszgzyDalKJuGtuj1R1c332xMn6eS2kGCzjD+6F/FuIquBVvK5MUrOq+lSY2ji
 PECY1p/H/WUhgSABx6iiaP57Q+1xnZFRuwCupjgZcRT1smPyxGIkj0azxBzSkbZQae8cOQA3L
 rnY2W8W3qt9c4xsrkaJz0W6ygipCnTpuGdi7DW+UtNiLZMkx0OoG89vF7byTy0AEzi/NejRnq
 Y06St64v1YiNO7Q3EvoJ/XRx43PpyCp4M02MzqV5gi1xpmGcCZRGDxl/sCXe/xwzVsaWfuuko
 Y91O5q3A6AmryYND+oPzEs0tjcgWRIG43sOQXGlfcfDTGNrAGbU9x5LkxFqTfvIBkcTKGpx2K
 ep11pCjak+vYECrN3YzTfv+kGUrXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 03:42:35PM +0100, Lars Schneider wrote:
[]
> 
> Agreed. However, people using ShiftJIS are not my target audience.
> My target audience are:
> 
> (1) People that have to encode their text files in UTF-16 (for 
>     whatever reason - usually because of legacy processes or tools).
> 
> (2) People that want to see textual diffs of their UTF-16 encoded 
>     files in their Git tools without special adjustments (on the 
>     command line, on the web, etc).
> 
> That was my primary motivation. The fact that w-t-e supports any
> other encoding too is just a nice side effect. I don't foresee people
> using other w-t-encodings other than UTF-16 in my organization.
> 
> I have the suspicion that the feature could be useful for the Git
> community at large. Consider this Stack Overflow question:
> https://stackoverflow.com/questions/777949/can-i-make-git-recognize-a-utf-16-file-as-text
> 
> This question was viewed 42k times and there is no good solution.
> I believe w-t-e could be a good solution.
> 

If it was only about a diff of UTF-16 files, I may suggest a patch.
I simply copy-paste it here for review, if someone thinks that it may
be useful, I can send it as a real patch/RFC.

git show HEAD


commit 9f7d43f29eaf6017b7b16261ce91d8ef182cf415
Author: Torsten Bögershausen <tboegi@web.de>
Date:   Fri Feb 2 15:35:23 2018 +0100

    Auto diff of UTF-16 files in UTF-8
    
    When an UTF-16 file is commited and later changed, `git diff` shows
    "Binary files XX and YY differ".
    
    When the user wants a diff in UTF-8, a textconv needs to be specified
    in .gitattributes and the textconv must be configured.
    
    A more user-friendly diff can be produced for UTF-16 if
    - the user did not use `git diff --binary`
    - the blob is identified as binary
    - the blob has an UTF-16 BOM
    - the blob can be converted into UTF-8
    
    Enhance the diff machinery to auto-detect UTF-16 blobs and show them
    as UTF-8, unless the user specifies `git diff --binary` which creates
    a binary diff.

diff --git a/diff.c b/diff.c
index fb22b19f09..51831ee94d 100644
--- a/diff.c
+++ b/diff.c
@@ -3192,6 +3192,10 @@ static void builtin_diff(const char *name_a,
 			strbuf_reset(&header);
 		}
 
+		if (one && one->reencoded_from_utf16)
+			strbuf_addf(&header, "a is converted to UTF-8 from UTF-16\n");
+		if (two && two->reencoded_from_utf16)
+			strbuf_addf(&header, "b is converted to UTF-8 from UTF-16\n");
 		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
 
@@ -3611,8 +3615,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->size = size;
 			s->should_free = 1;
 		}
-	}
-	else {
+		if (!s->binary && buffer_is_binary(s->data, s->size) &&
+		    buffer_has_utf16_bom(s->data, s->size)) {
+			int outsz = 0;
+			char *outbuf;
+			outbuf = reencode_string_len(s->data, (int)s->size,
+						     "UTF-8", "UTF-16", &outsz);
+			if (outbuf) {
+				if (s->should_free)
+					free(s->data);
+				if (s->should_munmap)
+					munmap(s->data, s->size);
+				s->should_munmap = 0;
+				s->data = outbuf;
+				s->size = outsz;
+				s->reencoded_from_utf16 = 1;
+				s->should_free = 1;
+			}
+		}
+	} else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
 			type = sha1_object_info(s->oid.hash, &s->size);
@@ -3629,6 +3650,19 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
+		if (!s->binary && buffer_is_binary(s->data, s->size) &&
+		    buffer_has_utf16_bom(s->data, s->size)) {
+			int outsz = 0;
+			char *buf;
+			buf = reencode_string_len(s->data, (int)s->size,
+						  "UTF-8", "UTF-16", &outsz);
+			if (buf) {
+				free(s->data);
+				s->data = buf;
+				s->size = outsz;
+				s->reencoded_from_utf16 = 1;
+			}
+		}
 		s->should_free = 1;
 	}
 	return 0;
@@ -5695,6 +5729,10 @@ static int diff_filespec_is_identical(struct diff_filespec *one,
 
 static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 {
+	if (p->binary) {
+		p->one->binary = 1;
+		p->two->binary = 1;
+	}
 	if (p->done_skip_stat_unmatch)
 		return p->skip_stat_unmatch_result;
 
@@ -5735,6 +5773,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
+		p->binary = diffopt->flags.binary;
 		if (diff_filespec_check_stat_unmatch(p))
 			diff_q(&outq, p);
 		else {
diff --git a/diffcore.h b/diffcore.h
index a30da161da..3cd97bb93b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -47,6 +47,8 @@ struct diff_filespec {
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
+	unsigned binary : 1;
+	unsigned reencoded_from_utf16 : 1;
 	struct userdiff_driver *driver;
 };
 
@@ -72,6 +74,7 @@ struct diff_filepair {
 	unsigned is_unmerged : 1;
 	unsigned done_skip_stat_unmatch : 1;
 	unsigned skip_stat_unmatch_result : 1;
+	unsigned binary : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
diff --git a/t/t4066-diff-encoding.sh b/t/t4066-diff-encoding.sh
new file mode 100755
index 0000000000..9bb3c70ada
--- /dev/null
+++ b/t/t4066-diff-encoding.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='git diff with encoding attribute'
+
+. ./test-lib.sh
+
+printf '\303\244rger\n\303\266se\n\303\274bel\n' |
+	iconv -f UTF-8 -t UTF-16 >UTF-16
+printf '\303\266se\n\303\274bel\n\303\245st\n' |
+	iconv -f UTF-8 -t UTF-16 >file2
+
+test_expect_success 'setup' '
+	cp UTF-16 file &&
+	git add file &&
+	git commit -m "add file in UTF-16" &&
+	test_tick &&
+	echo "file encoding=UTF-16" >.gitattributes
+'
+
+test_expect_success 'diff against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..e98d27a 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+åst
+EOF
+	git diff file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --binary against local change' '
+	cp file2 file &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa7828290f 100644
+	GIT binary patch
+	literal 28
+	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
+
+	literal 32
+	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
+
+EOF
+	git diff --binary file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'commit local change' '
+	git add file &&
+	git commit -m "add file V2 in UTF-16" &&
+	test_tick
+'
+
+test_expect_success 'diff HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09..e98d27a 100644
+	a is converted to UTF-8 from UTF-16
+	b is converted to UTF-8 from UTF-16
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	-ärger
+	 öse
+	 übel
+	+åst
+EOF
+	git diff HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --binary HEAD against HEAD^' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa7828290f 100644
+	GIT binary patch
+	literal 28
+	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
+
+	literal 32
+	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
+	
+EOF
+	git diff --binary HEAD^ HEAD -- file >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..a2184d0300 100644
--- a/utf8.h
+++ b/utf8.h
@@ -16,6 +16,17 @@ int utf8_fprintf(FILE *, const char *, ...);
 extern const char utf8_bom[];
 extern int skip_utf8_bom(char **, size_t);
 
+static inline int buffer_has_utf16_bom(const void *buf, size_t len) {
+  const unsigned char *text = (unsigned char *)buf;
+  if (!text ||  len < 2)
+    return 0;
+  if (text[0] == 0xff && text[1] == 0xfe)
+    return 1;
+  if (text[0] == 0xfe && text[1] == 0xff)
+    return 1;
+  return 0;
+}
+
 void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
