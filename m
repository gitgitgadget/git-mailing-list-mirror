Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF081F462
	for <e@80x24.org>; Tue, 28 May 2019 23:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfE1Xeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 19:34:50 -0400
Received: from mout.web.de ([212.227.15.14]:36619 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfE1Xeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 19:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559086482;
        bh=zlGw7iuJT9+CIZpOlcv74SUf/oVaXX4S4dKV44nsLsA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rq0KVNa9tU+O4hPzIwuI9dTiKnbJnksDQT+1hI/xIU1P10inPCQ+iEZqv3JIbhTzs
         WpTf9oWE1l9BLXmTqamaI3HizLpC2AlO5Rl9iF/YextphxYe/hZFjxwGwdVYcd/Fbx
         iEHMLvujrD7GBvX81RrP+LMGK1MyX1DzQkTlK3LU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGiLB-1hR8ux2ICH-00DUgz; Wed, 29
 May 2019 01:34:42 +0200
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
Date:   Wed, 29 May 2019 01:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528190815.GA20499@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FP+9ZoAU0w7kcHG/D/H5cZ9bNOcM+waT6Qtcelt7qHOI21NLucM
 v0hQofa/HbP2QTTDOjUARKBw5YRz3cnbye2Urlaqa1Ld5tmuN1lS0O2sau71GK8WwGnnzk+
 QYD78XIn8do1eDIG/llnqpOtiUaxktJu6T36bZuVZXu/H7MxEtb1GK8POvBqXzQ4fhpIlYc
 FlrFCg05U4p2CHMR1cldA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jko9RZwzAN0=:Wg7i4EU4yyPxH79ZO9ffhY
 RTs0parumffN9L6hm/EO6q6dwZ/xcUJtpdhgjeIwX/MXuggr7G/n7t2T32uBa8sbheDJmVlPZ
 OIXZecUlNbBnhh49ottk6V5C2zDW29T+uFw8lMa6hl+f8VG1TO2yAjE0kZGqPyjW7S9Hdt5AI
 080pR9wyvqcqjzmo/sFun6BOQCFr7bYVD+a9hOyvfn+ecVqvE+v3dcQaf+hgaeCT2BEwY3bV6
 qG1aoFDOmnvZt5YivesLAxrv2qEXvYtv1AtZ1PnVJE5ZSCIcawKZWcpHwan5VhqNBfb4anfs1
 hJIDP2pS4k+w9o6Q4styPq05z/C1pUfxfOdFmGFN6sNZCgoVd23Bx+ObAiu8ZuENBFM29fDlB
 wSF0NiBCGWdPsiDo5Ti5UKHFckkvF9ojvDDgQzBFqAkp/NKMK5f5sZCxcFFHslzYs0Gnw2CXx
 VDIauYrz4ihBm0rraKhzKgalGcg67KB9dJT3byQFOx8My9gGGH1Blt8O4p527ZlB5io6nVJOv
 2ctP2B0p0vX3/BYD+TczmT94m6kxLmXUdZev9/OIBut99TINxpH1Mh+XososnRXteCHNzdjrh
 MUIwDl4P6ONR9ofAQVovSrlH6emP0sH9QNszHz5CdJqmWKgeZeJ86QouVeCkfdLpZ5bB5FcRw
 1PDEkTEoDFPv/uUTBKx6mBW2DoxR2i/c95tHJu1lFOif7+HgYq0se9B+8zqcgp1RkXfdDh3uh
 e7i6glk5cMnPt16rZJhdD9UMuqALVgbt0Rb6wecZ6HrXtK/CxKJgs9utkwFNtbQdw912r3PX8
 YLWEsISUNhxWiC2o5c+8FHdRBJJNcZaZffhf34BAGNzU5hbqqzXKXu5C99awwB1BIg2WQc7m6
 EcuCN6Gfxu7RwkHL0Am6AiIEMKO/YNLv0Wvum77TRjC05yub0ZMdSZAuXoO2yYiu74EKmi/md
 cM34pGCaHc1J7t6tAN0ILEPhyiQsNsNk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.19 um 21:08 schrieb Jeff King:
> On Tue, May 28, 2019 at 08:01:43PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 28.05.19 um 07:58 schrieb Jeff King:
>>> On Sat, May 25, 2019 at 03:26:53PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> We could
>>>> make git fsck report such symlinks.
>>>
>>> This is a little tricky, because fsck generally looks at individual
>>> objects, and the bad pattern is a combination of a tree and a blob
>>> together. I think you could make it work by reusing some of the code a=
nd
>>> patterns from 9e84a6d758 (Merge branch 'jk/submodule-fsck-loose' into
>>> maint, 2018-05-22).
>>
>> Actually it's super easy, barely an inconvenience (SCNR, watched a lot
>> of those rants recently)..  Did I miss something?
>
> Yes. You cannot rely on calling read_object_file() in real-time when the
> fsck is being done by index-pack. The blob in question may be in the
> pack you are indexing.

It figures.

So something like the patch below?

Parsing trees with symlinks twice is not ideal, but keeps the set
structure simple -- a standard oidset suffices.

The global variables are ugly.  Moving them into struct fsck_option
would be possible, but not much better, as they aren't really
options.

FSCK_MSG_MISSING_TREE_OBJECT has never been used before, it seems.

=2D--
 fsck.c          | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh | 13 +++++++++++
 2 files changed, 71 insertions(+)

diff --git a/fsck.c b/fsck.c
index 4703f55561..a6e7d0b03f 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -19,6 +19,7 @@

 static struct oidset gitmodules_found =3D OIDSET_INIT;
 static struct oidset gitmodules_done =3D OIDSET_INIT;
+static struct oidset trees_with_symlinks =3D OIDSET_INIT;

 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -49,6 +50,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(MISSING_PARENT, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_SYMLINK_OBJECT, ERROR) \
 	FUNC(MISSING_TAG, ERROR) \
 	FUNC(MISSING_TAG_ENTRY, ERROR) \
 	FUNC(MISSING_TAG_OBJECT, ERROR) \
@@ -58,6 +60,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
+	FUNC(SYMLINK_OBJECT_NOT_BLOB, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
@@ -78,6 +81,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
+	FUNC(NUL_IN_SYMLINK_TARGET, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
@@ -578,6 +582,33 @@ static int verify_ordered(unsigned mode1, const char =
*name1, unsigned mode2, con
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }

+static int fsck_symlink(struct tree *tree, const char *name,
+			const struct object_id *oid,
+			struct fsck_options *options)
+{
+	int ret =3D 0;
+	enum object_type type;
+	unsigned long size;
+	void *buffer =3D read_object_file(oid, &type, &size);
+
+	if (!buffer)
+		ret =3D report(options, &tree->object,
+			     FSCK_MSG_MISSING_SYMLINK_OBJECT,
+			     "cannot read blob object for symlink %s", name);
+	else if (type !=3D OBJ_BLOB)
+		ret =3D report(options, &tree->object,
+			     FSCK_MSG_SYMLINK_OBJECT_NOT_BLOB,
+			     "expected blob got %s for symlink %s",
+			     type_name(type), name);
+	else if (memchr(buffer, '\0', size))
+		ret =3D report(options, &tree->object,
+			     FSCK_MSG_NUL_IN_SYMLINK_TARGET,
+			     "NUL in target of symlink %s", name);
+
+	free(buffer);
+	return ret;
+}
+
 static int fsck_tree(struct tree *item, struct fsck_options *options)
 {
 	int retval =3D 0;
@@ -626,6 +657,8 @@ static int fsck_tree(struct tree *item, struct fsck_op=
tions *options)
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
+		if (S_ISLNK(mode))
+			oidset_insert(&trees_with_symlinks, &item->object.oid);

 		if (update_tree_entry_gently(&desc)) {
 			retval +=3D report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot =
be parsed as a tree");
@@ -1118,8 +1151,33 @@ int fsck_finish(struct fsck_options *options)
 		free(buf);
 	}

+	oidset_iter_init(&trees_with_symlinks, &iter);
+	while ((oid =3D oidset_iter_next(&iter))) {
+		struct tree *tree;
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		tree =3D lookup_tree(the_repository, oid);
+		if (!tree) {
+			struct object *obj =3D lookup_unknown_object(oid->hash);
+			ret |=3D report(options, obj,
+				      FSCK_MSG_MISSING_TREE_OBJECT,
+				      "tree %s not found", oid_to_hex(oid));
+			continue;
+		}
+		if (parse_tree(tree))
+			continue;
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+			continue;
+		while (tree_entry_gently(&desc, &entry)) {
+			if (S_ISLNK(entry.mode))
+				ret |=3D fsck_symlink(tree, entry.path,
+						    &entry.oid, options);
+		}
+	}

 	oidset_clear(&gitmodules_found);
 	oidset_clear(&gitmodules_done);
+	oidset_clear(&trees_with_symlinks);
 	return ret;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f268a3664..ce9501d063 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -822,4 +822,17 @@ test_expect_success 'detect corrupt index file in fsc=
k' '
 	test_i18ngrep "bad index file" errors
 '

+test_expect_success 'detect NUL in symlink target' '
+	test_when_finished "git update-ref -d refs/heads/nul_in_symlink" &&
+	test_when_finished "remove_object \$commit" &&
+	test_when_finished "remove_object \$tree" &&
+	test_when_finished "remove_object \$blob" &&
+	blob=3D$(echo fooQbar | q_to_nul | git hash-object -w --stdin) &&
+	tree=3D$(echo "120000 blob $blob	symlink" | git mktree) &&
+	commit=3D$(git commit-tree $tree) &&
+	git update-ref refs/heads/nul_in_symlink $commit &&
+	git fsck 2>out &&
+	test_i18ngrep "NUL in target of symlink" out
+'
+
 test_done
=2D-
2.21.0
