Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DFD1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 16:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbcIFQDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:03:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932874AbcIFQDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:03:14 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M3eDF-1aqZl62ekD-00rEIS; Tue, 06 Sep 2016 18:03:01
 +0200
Date:   Tue, 6 Sep 2016 18:02:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
In-Reply-To: <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609061613270.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de> <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/7zCkrF8RmkJAqg5UGBns0WeMRZIsvZiLvcerFqpDJUF5Z5Q0+M
 9nBxQUTbkePSv47mK6YSBWLrlei0zplLJox6x+Uc+xAdVyg/0jbjUoLqhTCvv3AViQIn7nc
 hcS5AR6q7Dcyr6IuiP/KBJYQLp1zvfP4JSAL2V0D1rcnvBl0Hsdz1xWXWFBfJTeJ6bDQUcV
 pF7mWHHb0zLy36XehVf3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NCmxLhl8atk=:JbdMxSpEMrCoLpVqLSC4Hc
 yDZshcIFRqMEv6jM8XtMT8bxBHhDTYFTkJMEkIDZku0N1uAtgZA731lt9SplQcVbGjOKccYr8
 DrJ3FrP23pGJYFDPxeW7NTI192xoRl4RuI5BuW7+JNsX9LkMfWrrgJ8dh6pUW4pBGOSooRBew
 XN9TXkBpj4RrT9dl9lxCA7HJdcjC6FgkZnAuLfSyHmoJKJ9HwGcHmTQOSSxIhrxLU1WqPMe+I
 xbySGBw0w7Vzo+Bmbu5oiBdVc32aYFLO/SwJ1kHH+VvrmHOR9iBvtoUzyzvEVCjHa2gTkttZK
 8QsI9vP2Rxd+bnJvU6FiuKr6S2eI+FKw0HzC2CkH88n4Uw+UY02l8001S3zXdQzvs/3RwG8X3
 MBL3efID6vBxlvW6CJp3w8+L06u++9LW/DcHPSvHAN5qqE6X6Nm+ryIdemC4WPYANdtazwco3
 j6SLixTaSwnmTSRiEqGhkzMvrvrGxxKV/Wxi8/zgpIbKwexAWDtvACrvFijXg8mk35jn6a88U
 qiR81yUcOsTwA55gwggowMc5uA4Vhxcj8nWBWrIuZEnvxdU1QKPQlxgoRXtxS5/b+G5xaItzA
 cXVm08CkyZdesgP5zd9Jp4joC87P1EtN+etOb+oo+Q+y5PSMitfgdsphPCP836NPWSRbElKNm
 vuWsTAikL4r5+Ry4HHqJFLQ0SHzqyT/o33G3NocOSNzbAX92DSHWgbv1S/XtGdRkSRx5BLF7K
 XZ0yfopuF3sM+k9R09Q5kFgd7vJZyUGu6NQdYzIoSX0HGt8UjMY3SuXrj43zgrNS7GJRhX4Lb
 liaPnCz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Mon, Sep 05, 2016 at 05:45:06PM +0200, Johannes Schindelin wrote:
> 
> > It is true that many code paths populate the mmfile_t structure
> > silently appending a NUL, e.g. when running textconv on a temporary
> > file and reading the results back into an strbuf.
> > 
> > The assumption is most definitely wrong, however, when mmap()ing a
> > file.
> > 
> > Practically, we seemed to be lucky that the bytes after mmap()ed
> > memory were 1) accessible and 2) somehow contained NUL bytes
> > *somewhere*.
> > 
> > In a use case reported by Chris Sidi, it turned out that the mmap()ed
> > file had the precise size of a memory page, and on Windows the bytes
> > after memory-mapped pages are in general not valid.
> > 
> > This patch works around that issue, giving us time to discuss the best
> > course how to fix this problem more generally.
> 
> I don't know if we are in that much of a rush.

I am ;-)

> This bug has been around for many years (the thread I linked earlier is
> from 2012). Yes, it's bad and annoying, but we can probably spend a few
> days discussing the solution.

Sure we can. But I got to have a solution due to a recent switch from
storing LF to storing CR/LF in the repository (that resulted in a
noticable performance improvement): combined with -G being an integral
part of the workflow in the project that reported the issue, it is
essential that this bug gets fixed. Before I go mostly offline.

> > diff --git a/diff.c b/diff.c
> > index 534c12e..32f7f46 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2826,6 +2826,15 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> >  			s->data = strbuf_detach(&buf, &size);
> >  			s->size = size;
> >  			s->should_free = 1;
> > +		} else {
> > +			/* data must be NUL-terminated so e.g. for regexec() */
> > +			char *data = xmalloc(s->size + 1);
> > +			memcpy(data, s->data, s->size);
> > +			data[s->size] = '\0';
> > +			munmap(s->data, s->size);
> > +			s->should_munmap = 0;
> > +			s->data = data;
> > +			s->should_free = 1;
> >  		}
> 
> Without having done a complete audit recently, my gut and my
> recollection from previous discussions is that regexec() really is the
> culprit here for the diff code[1]. If we are going to do a workaround
> like this, I think we could limit it only to cases where know it
> matters, like --pickaxe-regex.

Sure.

We could introduce a new NEEDS_NUL flag.

It will still be quite tricky, because we have to touch a function that is
rather at the bottom of the food chain: diff_populate_filespec() is called
from fill_textconv(), which in turn is called from pickaxe_match(), and
only pickaxe_match() knows whether we want to call regexec() or not (it
depends on its regexp parameter).

Adding a flag to diff_populate_filespec() sounds really reasonable until
you see how many call sites fill_textconv() has.

See below for a better idea.

> Can it be triggered with -G?

It can, and it is, as demonstrated by the test I introduced in 1/3.

> I thought that operated on the diff content itself, which would always
> be in a heap buffer (which should be NUL terminated, but if it isn't,
> that would be a separate fix from this).

That is true.

Except when preimage or postimage does not exist. In which case we call

	regexec(regexp, two->ptr, 1, &regmatch, 0);

or the same with one->ptr. Note the notable absence of two->size.

> [1] We do make the assumption elsewhere that git objects are
>     NUL-terminated, but that is enforced by the object-reading code
>     (with the exception of streamed blobs, but those are obviously dealt
>     with separately anyway).

I know. I am the reason you introduced that, because I added code to
fsck.c that assumes that tag/commit messages are NUL-terminated.

So now for the better idea.

While I was researching the code for this reply, I hit upon one thing that
I never knew existed, introduced in f96e567 (grep: use REG_STARTEND for
all matching if available, 2010-05-22). Apparently, NetBSD introduced an
extension to regexec() where you can specify buffer boundaries using
REG_STARTEND. Which is pretty much what we need.

So I have this as my current proof-of-concept (which passes the test
suite, but is white-space corrupted, because I really have no time to get
non-white-space-corrupted text into this here mailer):

-- snipsnap --
diff --git a/diff.c b/diff.c
index 534c12e..2c5a360 100644
--- a/diff.c
+++ b/diff.c
@@ -951,7 +951,13 @@ static int find_word_boundaries(mmfile_t *buffer,
regex_t *word_regex,
 {
 	if (word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
-		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
		0)) {
+		int f = 0;
+#ifdef REG_STARTEND
+		match[0].rm_so = 0;
+		match[0].rm_eo = *end - *begin;
+		f = REG_STARTEND;
+#endif
+		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
f)) {
 			char *p = memchr(buffer->ptr + *begin +
match[0].rm_so,
 					'\n', match[0].rm_eo -
match[0].rm_so);
 			*end = p ? p - buffer->ptr : match[0].rm_eo +
*begin;
@@ -994,7 +1000,7 @@ static void diff_words_fill(struct diff_words_buffer
*buffer, mmfile_t *out,
 	buffer->orig[0].begin = buffer->orig[0].end = buffer->text.ptr;
 	buffer->orig_nr = 1;
 
-	for (i = 0; i < buffer->text.size; i++) {
+	for (i = 0, j = buffer->text.size; i < buffer->text.size; i++) {
 		if (find_word_boundaries(&buffer->text, word_regex, &i,
&j))
 			return;
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 55067ca..2cd09e2 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -23,7 +23,9 @@ static void diffgrep_consume(void *priv, char *line,
unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
+#ifndef REG_STARTEND
 	int hold;
+#endif
 
 	if (line[0] != '+' && line[0] != '-')
 		return;
@@ -33,11 +35,18 @@ static void diffgrep_consume(void *priv, char *line,
unsigned long len)
 		 * caller early.
 		 */
 		return;
+#ifdef REG_STARTEND
+	regmatch.rm_so = 0;
+	regmatch.rm_eo = len;
+	data->hit = !regexec(data->regexp, line + 1, 1,
+			     &regmatch, REG_STARTEND);
+#else
 	/* Yuck -- line ought to be "const char *"! */
 	hold = line[len];
 	line[len] = '\0';
-	data->hit = !regexec(data->regexp, line + 1, 1, &regmatch, 0);
+	data->hit = !regexec(data->regexp, line + 1, 1, &regmatch, f);
 	line[len] = hold;
+#endif
 }
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
@@ -49,10 +58,24 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 
-	if (!one)
-		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
-	if (!two)
-		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
+	if (!one) {
+		int flags = 0;
+#ifdef REG_STARTEND
+		regmatch.rm_so = 0;
+		regmatch.rm_eo = two->size;
+		flags = REG_STARTEND;
+#endif
+		return !regexec(regexp, two->ptr, 1, &regmatch, flags);
+	}
+	if (!two) {
+		int flags = 0;
+#ifdef REG_STARTEND
+		regmatch.rm_so = 0;
+		regmatch.rm_eo = one->size;
+		flags = REG_STARTEND;
+#endif
+		return !regexec(regexp, one->ptr, 1, &regmatch, flags);
+	}
 
 	/*
 	 * We have both sides; need to run textual diff and see if
@@ -83,7 +106,13 @@ static unsigned int contains(mmfile_t *mf, regex_t
*regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
+#ifndef REG_STARTEND
 		assert(data[sz] == '\0');
+#else
+		regmatch.rm_so = 0;
+		regmatch.rm_eo = sz;
+		flags |= REG_STARTEND;
+#endif
 		while (*data && !regexec(regexp, data, 1, &regmatch,
flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f34ea76..c179d43 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -218,7 +218,7 @@ static long ff_regexp(const char *line, long len,
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
 	int i;
-	int result = -1;
+	int result = -1, flags = 0;
 
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
@@ -228,11 +228,20 @@ static long ff_regexp(const char *line, long len,
 			len--;
 	}
 
+#ifndef REG_STARTEND
 	line_buffer = xstrndup(line, len); /* make NUL terminated */
+#else
+	line_buffer = (char *)line;
+	flags = REG_STARTEND;
+#endif
 
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
-		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
+#ifdef REG_STARTEND
+		pmatch->rm_so = 0;
+		pmatch->rm_eo = len;
+#endif
+		if (!regexec(&reg->re, line_buffer, 2, pmatch, flags)) {
 			if (reg->negate)
 				goto fail;
 			break;
@@ -249,7 +258,9 @@ static long ff_regexp(const char *line, long len,
 		result--;
 	memcpy(buffer, line, result);
  fail:
+#ifndef REG_STARTEND
 	free(line_buffer);
+#endif
 	return result;
 }
