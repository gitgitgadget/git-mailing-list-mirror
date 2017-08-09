Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A13208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdHIWNC (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 18:13:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:64538 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbdHIWNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 18:13:01 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgHHO-1e2Cwb3NbS-00Nf8c; Thu, 10
 Aug 2017 00:12:55 +0200
Date:   Thu, 10 Aug 2017 00:12:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Convert size datatype to size_t
In-Reply-To: <xmqqa8387khm.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708100011391.11175@virtualbox>
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause> <xmqq8tit8efv.fsf@gitster.mtv.corp.google.com> <20170809071906.GA19310@mail.zuhause> <20170809072613.GA20347@mail.zuhause> <xmqqa8387khm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aK6GPgxXhov4Fk7JPV15Pwzqe4hIf5jbbGSPBqEf9ABiziUfaoF
 vWv9SJWRAzgw/FxAfZRll04A/ijMCc6fQT+WmnF/GU7vMRU+/M7TiQqFaLqaHMRlJCgulQ5
 zhBTmb7cygcXPYv+ALDb5YcGJFlsvataQf4Z+URTlyg5Ep6svWoI8T6KZTzEkZq4xte4bwF
 bRjlY8XodS+dwtHoi1CSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iJCIH4A1np4=:0PEi6J+Lr8fwnLZ37GS3TA
 vqr/LBvVY/yAWdRJ48Sf7Bjn4HZ/oeRHvJG6ziY4x1SEvUo79sCQ91NTf3caFdfZhHWrGlsi2
 RhTnA7xmOW7fkdHENMqW68Z5vJVZQB+uSB24U9OWjd/IhtFoieSITQY0TUid6mGvVfycybvN/
 rXLGPLsMKvozoL9bgWve9T9y+yO3kFrpzTgE5wfJEC7OPsRtePUUl6fQw0sGuogzsrgo/aHYb
 33UppU1whrsETtFzmytObCTVtiLtFufCqR7PzDaOgGkg7FHyfKEzF1audpMs+okrYGmWsQwwx
 E73h9g1J0LNpGkkoxoVeit7LxMYUQa8AIGAGHEwmdvXI2AY4DH/x8XMg/KRsU5wN7IFFulAmU
 w0Js8+CcOPdQoCG9R+aEtKTRR3HOskGPoDozlTyeVTwME0hvu0i+Jd/IXWJzqF7LbEgVumtv1
 JgCLI1A4pPO1w5IKeMJEeRs+/rBpjbKagx2+Q6OGfyD1qCr61y8KWWLHxo6cKpFGVgvASYhG0
 3B0HV16YQjmI3Z28x9Sv0HNll1ZEYRyYuXdOwp93P2LWx05GMH9TL5AC8mvstSCdyHRA2Gqgx
 TtL6s45tilHcNumn1p5MjqMPmffK3wBZjk9n8El3cqryOQRjwYvPXM7A+Of8qGCPRqjfiobTh
 nW+HeOv2NvD12/r72lmnkaTo3C4pSqV0YAfQFEfnm6kAPsM/VLIqzM2dJttVP9y29UTFjVdYK
 JRJsKCbpsgZyvQxYuEBZzY/0qRKgbquiYKbRQRcis54QjeVNu+eIAkZ8M6PkX/hfm+uKbSZ5e
 DR/19J7jlmGqSyS1R3mc9l+5J+zveT37YbjVty73nuwdxENB9A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Aug 2017, Junio C Hamano wrote:

> Martin Koegler <martin.koegler@chello.at> writes:
> 
> > On Wed, Aug 09, 2017 at 09:19:06AM +0200, Martin Koegler wrote:
> >> On Tue, Aug 08, 2017 at 11:04:20PM -0700, Junio C Hamano wrote:
> >> > As https://travis-ci.org/git/git/jobs/262463159 shows, unfortunately
> >> > it turns out that things are not so simple X-<.  On Linux32, size_t
> >> > is uint, which is the same size as ulong, but "%lu" is not appropriate
> >> > for showing a size_t value.
> >> > 
> >> > So you are correct to say in the comment under three-dashes that
> >> > there is much more to change in the codebase.
> >> 
> >> I'll post a new version fixing the *printf issues.
> >
> > What is the correct format specifier for size_t?
> > Linux has %zu (C99). Is that OK for the GIT codebase?
> 
> I haven't double checked, but IIRC we cast to uintmax_t and use
> PRIuMAX.

That would be my preference, too. This is the patch that I need to make
`pu` compile for me again (note: there is one `unsigned long` -> `size_t`
change hiding between all the `%lu` -> `%PRIuMAX` changes):

-- snipsnap --
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bc19e08a62d..10428cbeb0b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -232,7 +232,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.sizep = &data->size;
 		else
-			strbuf_addf(sb, "%lu", data->size);
+			strbuf_addf(sb, "%" PRIuMAX, (uintmax_t)data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
diff --git a/builtin/grep.c b/builtin/grep.c
index 9be8f817f2f..e3e33f3baab 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -437,7 +437,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		struct object *object;
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base = STRBUF_INIT;
 
 		object = parse_object_or_die(oid, oid_to_hex(oid));
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3ab99c47a0c..b09d9cba7e4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -99,7 +99,7 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 						  "BAD");
 				else
 					xsnprintf(size_text, sizeof(size_text),
-						  "%lu", size);
+						  "%" PRIuMAX, (uintmax_t)size);
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
 			printf("%06o %s %s %7s\t", mode, type,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 126e7097bf6..d94fd170243 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1863,9 +1863,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			die("object %s cannot be read",
 			    oid_to_hex(&trg_entry->idx.oid));
 		if (sz != trg_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
-			    oid_to_hex(&trg_entry->idx.oid), sz,
-			    trg_size);
+			die("object %s inconsistent object length (%" PRIuMAX
+			    " vs %" PRIuMAX ")",
+			    oid_to_hex(&trg_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)trg_size);
 		*mem_usage += sz;
 	}
 	if (!src->data) {
@@ -1891,9 +1892,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			    oid_to_hex(&src_entry->idx.oid));
 		}
 		if (sz != src_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
-			    oid_to_hex(&src_entry->idx.oid), sz,
-			    src_size);
+			die("object %s inconsistent object length (%" PRIuMAX
+			    " vs %" PRIuMAX ")",
+			    oid_to_hex(&src_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)src_size);
 		*mem_usage += sz;
 	}
 	if (!src->index) {
diff --git a/diff.c b/diff.c
index 6084487a2fc..1e815e87acb 100644
--- a/diff.c
+++ b/diff.c
@@ -2971,7 +2971,7 @@ static void emit_binary_diff_body(struct diff_options *o,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		char *s = xstrfmt("%lu", orig_size);
+		char *s = xstrfmt("%" PRIuMAX, (uintmax_t)orig_size);
 		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
 				 s, strlen(s), 0);
 		free(s);
diff --git a/fast-import.c b/fast-import.c
index 011da200cb6..bfde330f215 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2986,8 +2986,8 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		die("Object %s is a %s but a blob was expected.",
 		    oid_to_hex(oid), typename(type));
 	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", oid_to_hex(oid),
-						typename(type), size);
+	strbuf_addf(&line, "%s %s %" PRIuMAX "\n", oid_to_hex(oid),
+		    typename(type), (uintmax_t)size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
diff --git a/http-push.c b/http-push.c
index 676149ceac3..af229428c1c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -356,7 +356,8 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(type), (uintmax_t)len) + 1;
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/sha1_file.c b/sha1_file.c
index c63f478a311..84b9c6b6ec8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -983,7 +983,8 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(obj_type), (uintmax_t)size) + 1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -2794,7 +2795,8 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	buf = read_packed_sha1(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(type), (uintmax_t)len) + 1;
 	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
