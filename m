Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EB71F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfJLVbp (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 17:31:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:41595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfJLVbo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 17:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570915899;
        bh=cF3miRXlvlyMwXEB853uLTA0AOq9TnngAIFY9iIkJ3g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FnppRp91qzS+LupRYMO4k408u7gIZoVdrza1DyuSSXKKCn1mjuoRnSrtGw636yCm4
         8ijlNQ2Ix2mwVaQd1bDnScXa9/tC5t0MRpMFZ6HkwHESm2fZ+vYhy8jP0HJmtMzv45
         Day+C/RscGTgBBpBd+HxWA3HxFS5xxLTnvgcSRaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1hfRSC35e6-00n64l; Sat, 12
 Oct 2019 23:31:38 +0200
Date:   Sat, 12 Oct 2019 23:31:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019, #03;
 Fri, 11)
In-Reply-To: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ViZ90nZK/uw1aak7QO1N2wzhDXUnOJbtQihWESqZ662xORwa9HF
 LaxB1HJG+sRtppd8MRtsu+FbqQhHWNs8j69jmU4xiUr37kBnPDwI/Xol9rqwJQuClKY3gzW
 efFrW22jhXg7+EJ2xSeYX6C2kAGSlyoMlYLyWfFpZbl/qRR84BeRiOhup6ucSAer7tQKaJY
 BaDPNvoVCZrByrkC99S7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5BoaBetdtSc=:PhyMVBS4CNr4U5+9sCFfbt
 GO6+bFn38/QWqJxqHdovjhk1w44qfRrShhZ7/EfDb9/bGkgtu0TEwu8dxdXekLc6XwNA95kgv
 tqJidOjwgfbFBfmD0KdWHpf6gp48UrmCEQRgolH0aN7ffiQirje1jvwWgDuzwpxsKlMtbQ0hq
 WQMBxO+byVe3jneVlSeRnMCWgWkO0hNXkMbja6liWO+WuCTvm3vmLELcPmxT0DjbBmddsXack
 isj1XhO8/vq50oTghqFdYsXfrqHxOHK893mILAOm4mcRH+4TIZLOCk51y2MXr1m6L85qYi5zx
 YYBwM8nZGOZ+5DhgXxJGWXPvvZs4VbNqcsuTbMB3VTpCQEgGTSLiJvHkJzeTtCA7nuTLYWDwN
 GymyEZMGR1b9JL9jqCX6ekfPeDtEeKwn7hiqQyRRfLxbG/+CXLIstc4EbeX7Jy3SYbjLXSMNQ
 G+LzyUuFZ30OdDkhbxvJZzuuPoE5VqSFKdYNZA8M47eH7gQ+BS/KK2nCUlxbq9RnEUEY0ZUo1
 Lw7KTbyZWeZH4LHUaS5S9uFUqk9W3DiQC8S5lZB/r9XkORg8qLVaRfywmLMOnr5tek9mDBG71
 fFkpreGHaROI2biZAiV20kwiXOdFE0Khku25/7Euly8p6L2YMwf9tWhH4nqwRQWIVlBF36Ab6
 5HLt1x2FlIeSOmMOFoqBaeY7yr89h8cBxBj5UOsB5s5+LXQCMTN3AYYpsBTv2Vemc9M3qcS89
 hdsyc6vs0dGJu6UUqk5wk2Lm+wSWtKnWWPBkfoRXKr7BBycKAyU+0fNTecXBMPhgmgQsveD+m
 nR0w2hyAp6QfyIEGYKYNqqNKPmdynCDlQVrfgeBCLDwBOL/YvKIozh4kFPEF+fl5SMHTUoIZn
 mUqEPzPGHYyHiDb0vDk0EJynK8Q/yLDqMZUPZmw5jcooxXTAnvzdOH6Zvo2jBK5i3rlGNvwHw
 HStOcA6P0jXXlEtfljP3VdYE8V3a9j5gAzylkTKjde3fWFQKZVoWUa62W6xsuX58FzprB0AiZ
 2R//V797RjT2baCZYGGs45xtg9TkoVHoxX9oYjmlMttJpIxV2K/1dj2OiNI6qjAx2x7lq43h0
 BEyVlUsZp653VVE8UvxcB2LTgnV4wFZ9P1eO9hYVCQJs/ZnLtFIxnUnsveQX2brlJUBstmW7y
 fxVDyVwkRsllpUiaa01kHOWgX/wJjz8LF9/D+JH8nBFWP0HgmC7fCCImSdDw9+T8Lx3kEA+Om
 NI4ADKD946fVvPp64NTAhd2lMT8zNq2TRodhy4pRpM/ii7zlTcNa07sRPog0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 11 Oct 2019, Junio C Hamano wrote:

> * ds/sparse-cone (2019-10-08) 17 commits
>  - sparse-checkout: cone mode should not interact with .gitignore
>  - sparse-checkout: write using lockfile
>  - sparse-checkout: update working directory in-process
>  - sparse-checkout: sanitize for nested folders
>  - read-tree: show progress by default
>  - unpack-trees: add progress to clear_ce_flags()
>  - unpack-trees: hash less in cone mode
>  - sparse-checkout: init and set in cone mode
>  - sparse-checkout: use hashmaps for cone patterns
>  - sparse-checkout: add 'cone' mode
>  - trace2: add region in clear_ce_flags
>  - sparse-checkout: create 'disable' subcommand
>  - sparse-checkout: add '--stdin' option to set subcommand
>  - sparse-checkout: 'set' subcommand
>  - clone: add --sparse mode
>  - sparse-checkout: create 'init' subcommand
>  - sparse-checkout: create builtin with 'list' subcommand
>
>  Management of sparsely checked-out working tree has gained a
>  dedicated "sparse-checkout" command.
>
>  Seems not to play well with the hashmap updates.

Hrm. I had sent out links to the three fixups needed to make the build
green:

https://public-inbox.org/git/nycvar.QRO.7.76.6.1910081055210.46@tvgsbejvaq=
bjf.bet/

In particular, the patches to squash were:

https://github.com/git-for-windows/git/commit/f74259754971b427a14e6290681e=
18950824b99d
https://github.com/git-for-windows/git/commit/124c8bc08e974e76ca7d956dc07e=
b288e71d639e
https://github.com/git-for-windows/git/commit/45948433d1b48ff513fbd37f134c=
0f1491c78192

For your convenience:

=2D- snip --
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 160afb2fd7f..fb21d6f8780 100644
=2D-- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -229,9 +229,9 @@ static void insert_recursive_pattern(struct pattern_li=
st *pl, struct strbuf *pat

 	e->patternlen =3D path->len;
 	e->pattern =3D strbuf_detach(path, NULL);
-	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));

-	hashmap_add(&pl->recursive_hashmap, e);
+	hashmap_add(&pl->recursive_hashmap, &e->ent);

 	while (e->patternlen) {
 		char *slash =3D strrchr(e->pattern, '/');
@@ -245,24 +245,26 @@ static void insert_recursive_pattern(struct pattern_=
list *pl, struct strbuf *pat
 		e =3D xmalloc(sizeof(struct pattern_entry));
 		e->patternlen =3D newlen;
 		e->pattern =3D xstrndup(oldpattern, newlen);
-		hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));

-		if (!hashmap_get(&pl->parent_hashmap, e, NULL))
-			hashmap_add(&pl->parent_hashmap, e);
+		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
+			hashmap_add(&pl->parent_hashmap, &e->ent);
 	}
 }

 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
-	struct pattern_entry *entry;
+	struct hashmap_entry *e;
 	struct hashmap_iter iter;
 	struct string_list sl =3D STRING_LIST_INIT_DUP;
 	struct strbuf parent_pattern =3D STRBUF_INIT;

 	hashmap_iter_init(&pl->parent_hashmap, &iter);
-	while ((entry =3D hashmap_iter_next(&iter))) {
-		if (hashmap_get(&pl->recursive_hashmap, entry, NULL))
+	while ((e =3D hashmap_iter_next(&iter))) {
+		struct pattern_entry *entry =3D
+			container_of(e, struct pattern_entry, ent);
+		if (hashmap_get_entry(&pl->recursive_hashmap, entry, ent, NULL))
 			continue;

 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
@@ -286,7 +288,9 @@ static void write_cone_to_file(FILE *fp, struct patter=
n_list *pl)
 	string_list_clear(&sl, 0);

 	hashmap_iter_init(&pl->recursive_hashmap, &iter);
-	while ((entry =3D hashmap_iter_next(&iter))) {
+	while ((e =3D hashmap_iter_next(&iter))) {
+		struct pattern_entry *entry =3D
+			container_of(e, struct pattern_entry, ent);
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     entry->pattern,
 					     &parent_pattern))
diff --git a/dir.c b/dir.c
index 0135f9e2180..9efcdc9aacd 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -612,10 +612,13 @@ void parse_path_pattern(const char **pattern,
 }

 int pl_hashmap_cmp(const void *unused_cmp_data,
-		   const void *a, const void *b, const void *key)
+		   const struct hashmap_entry *a, const struct hashmap_entry *b,
+		   const void *key)
 {
-	const struct pattern_entry *ee1 =3D (const struct pattern_entry *)a;
-	const struct pattern_entry *ee2 =3D (const struct pattern_entry *)b;
+	const struct pattern_entry *ee1 =3D
+		container_of(a, struct pattern_entry, ent);
+	const struct pattern_entry *ee2 =3D
+		container_of(b, struct pattern_entry, ent);

 	size_t min_len =3D ee1->patternlen <=3D ee2->patternlen
 			 ? ee1->patternlen
@@ -660,10 +663,11 @@ static void add_pattern_to_hashsets(struct pattern_l=
ist *pl, struct path_pattern
 		translated =3D xmalloc(sizeof(struct pattern_entry));
 		translated->pattern =3D truncated;
 		translated->patternlen =3D given->patternlen - 2;
-		hashmap_entry_init(translated,
+		hashmap_entry_init(&translated->ent,
 				   memhash(translated->pattern, translated->patternlen));

-		if (!hashmap_get(&pl->recursive_hashmap, translated, NULL)) {
+		if (!hashmap_get_entry(&pl->recursive_hashmap,
+				       translated, ent, NULL)) {
 			/* We did not see the "parent" included */
 			warning(_("unrecognized negative pattern: '%s'"),
 				given->pattern);
@@ -672,8 +676,8 @@ static void add_pattern_to_hashsets(struct pattern_lis=
t *pl, struct path_pattern
 			goto clear_hashmaps;
 		}

-		hashmap_add(&pl->parent_hashmap, translated);
-		hashmap_remove(&pl->recursive_hashmap, translated, &data);
+		hashmap_add(&pl->parent_hashmap, &translated->ent);
+		hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
 		free(data);
 		return;
 	}
@@ -688,16 +692,16 @@ static void add_pattern_to_hashsets(struct pattern_l=
ist *pl, struct path_pattern

 	translated->pattern =3D xstrdup(given->pattern);
 	translated->patternlen =3D given->patternlen;
-	hashmap_entry_init(translated,
+	hashmap_entry_init(&translated->ent,
 			   memhash(translated->pattern, translated->patternlen));

-	hashmap_add(&pl->recursive_hashmap, translated);
+	hashmap_add(&pl->recursive_hashmap, &translated->ent);

-	if (hashmap_get(&pl->parent_hashmap, translated, NULL)) {
+	if (hashmap_get_entry(&pl->parent_hashmap, translated, ent, NULL)) {
 		/* we already included this at the parent level */
 		warning(_("your sparse-checkout file may have issues: pattern '%s' is r=
epeated"),
 			given->pattern);
-		hashmap_remove(&pl->parent_hashmap, translated, &data);
+		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
 		free(data);
 		free(translated);
 	}
@@ -706,8 +710,8 @@ static void add_pattern_to_hashsets(struct pattern_lis=
t *pl, struct path_pattern

 clear_hashmaps:
 	warning(_("disabling cone pattern matching"));
-	hashmap_free(&pl->parent_hashmap, 1);
-	hashmap_free(&pl->recursive_hashmap, 1);
+	hashmap_free(&pl->parent_hashmap);
+	hashmap_free(&pl->recursive_hashmap);
 	pl->use_cone_patterns =3D 0;
 }

@@ -719,8 +723,8 @@ static int hashmap_contains_path(struct hashmap *map,
 	/* Check straight mapping */
 	p.pattern =3D pattern->buf;
 	p.patternlen =3D pattern->len;
-	hashmap_entry_init(&p, memhash(p.pattern, p.patternlen));
-	return !!hashmap_get(map, &p, NULL);
+	hashmap_entry_init(&p.ent, memhash(p.pattern, p.patternlen));
+	return !!hashmap_get_entry(map, &p, ent, NULL);
 }

 int hashmap_contains_parent(struct hashmap *map,
diff --git a/dir.h b/dir.h
index 09b7c4c44be..81d9f1b0a4e 100644
=2D-- a/dir.h
+++ b/dir.h
@@ -301,7 +301,8 @@ int is_excluded(struct dir_struct *dir,
 		const char *name, int *dtype);

 int pl_hashmap_cmp(const void *unused_cmp_data,
-		   const void *a, const void *b, const void *key);
+		   const struct hashmap_entry *a, const struct hashmap_entry *b,
+		   const void *key);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
=2D- snap --

Why not pick it up and squash it into the merge commit?

Ciao,
Dscho
