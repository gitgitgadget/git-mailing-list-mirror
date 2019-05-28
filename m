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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0781D1F462
	for <e@80x24.org>; Tue, 28 May 2019 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfE1SBu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:01:50 -0400
Received: from mout.web.de ([212.227.15.3]:36523 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1SBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559066504;
        bh=X9JYgepoyIoyJepd42atPMYhEXdhMC1VAhljryUu7/o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kVNfw2Y/xT2iPK+w2tK75rXl1qy9Syk6+A4FpzpybHr7lDA0/K8sXvzY0gsFbTMof
         9+YaWJi23zNw78W91hGHDBPc+IqKvNNMg5PkDyBR6sBGofg8gv3oJdS/iSbBZYPZgU
         flJhV9p1utmFNwcXJvk+PpSmcBeqgVAJRGDeL5gI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYO5B-1h9HxW3aWv-00V4ov; Tue, 28
 May 2019 20:01:43 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
Date:   Tue, 28 May 2019 20:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528055805.GB7946@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:23muck4TF1CQG7RgYVqf66VvnaHfRLjKKumJ8uGhOvTdZVgNyhO
 eEY6O8e1n84wiomMlAtqCqvbi0DdfRkJN53gw+JUD/BcrxQOu7OjBPNSJ3Ek4zyMPEPHJEj
 a9M/kicImSOibtaCm+2J5MDHN4zhiKZXZZkRKwsvtNyVJ50TSp1MqyMwt4NI4SnR0IrVW5a
 0ir8FSdlqvEA/sOQLnlZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sqG18thUfiM=:fF6BqjILwZorU6bEA8I58W
 4lMWddAUvoBtQ5MwQ0PNI6M3El52YwoUU+9ecMwXbBhtOi7ribi7ufQri6Ny2B7mwqAwNvjFL
 csPkcpuhWgg2mBVhww+rHJHpgnQVlPQoqLS7y4mXUzarm8TvJkNOBMYu8oIRohBl0w69c+IfB
 86GxRAudGdGh9S8mro/xGNyywMNEaXiOHbSbZQaMisvWgd5hLobHclq5N9dYzi+udyc2qzZAx
 lKH2d+zDZSb+cvY7/D5jklai51cd8gbewXsLsdo9MWv9d+dZJQO9BN1ELrzwH7oVy1gwB1GW8
 rdfWHoMZSHZvVFbwAsicAv9FhJ0LAD7YjP+dSSiIdesP4JYW8W7dr7k6MNfHakFtu6P8yQub/
 +HRkTHeSyHdKfHDU+puariNklCesvyn3pKHIjCRgdCZMA+xTeUGPSjJfBX139dzi9ZEN8FjGn
 rehRNiCRpzmC6Q0QIzf9E6Itf1H9h8ENlFBniRPZinYSfEnZMeSMSbEE+EsnRpO7Sd4nLVopK
 WNeQp6GSD4YUHoCSbmQlinan7nRClpttkQgy7X8WOMiQ6xisvrfBLMt8MMoBuMfKBLfyJ6kvZ
 G4ZIZH7E24DYG0UHwP5quEc2sJR68rz3MyQigag73SWPzoQ5Z/dIV6mChIZjgoZ8hYkaQSHQb
 c+GrtIbti8AudyeG3FAihlXT1Trf7LlhKWm/fcrpCYtJbA8/WYTunvOO8hvyNmdpLJZz/ib87
 RrpwVYX0kRkvL/IakvOcktctHNpwp1B4UoZ9Gm0/2KBxTQYnYjGapNZvnCbAVEOsY7lIUPE6w
 s3KgLe81pIdBAMLjDSbuDxn5QT10A0UoXW+WwOCdiqpxIsNmJ7oMzbTVTbik9jRxdYW7qig6x
 qX+Ak0slcIpjODeuSUQSSr1Wg522UCtaYeqfP8nuQShfV1Ajqm+PNWBMa9KVhJFnvUKeXgeLX
 IHyHtMR08ggVY8zDz/e8vJLFhAYyShWM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.19 um 07:58 schrieb Jeff King:
> On Sat, May 25, 2019 at 03:26:53PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> We could
>> make git fsck report such symlinks.
>
> This is a little tricky, because fsck generally looks at individual
> objects, and the bad pattern is a combination of a tree and a blob
> together. I think you could make it work by reusing some of the code and
> patterns from 9e84a6d758 (Merge branch 'jk/submodule-fsck-loose' into
> maint, 2018-05-22).

Actually it's super easy, barely an inconvenience (SCNR, watched a lot
of those rants recently)..  Did I miss something?

=2D- >8 --
Subject: [PATCH] fsck: warn about symlink targets containing NUL

Symlink targets are kept as blob objects in Git repositories and can
thus contain arbitrary characters.  They are truncated silently at the
first NUL by symlink(2) during checkout, though.  Make git fsck warn
about such tree entries.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 fsck.c          | 32 ++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh | 13 +++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/fsck.c b/fsck.c
index 4703f55561..d434f5d75c 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -49,6 +49,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(MISSING_PARENT, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_SYMLINK_OBJECT, ERROR) \
 	FUNC(MISSING_TAG, ERROR) \
 	FUNC(MISSING_TAG_ENTRY, ERROR) \
 	FUNC(MISSING_TAG_OBJECT, ERROR) \
@@ -58,6 +59,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
+	FUNC(SYMLINK_OBJECT_NOT_BLOB, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
@@ -78,6 +80,7 @@ static struct oidset gitmodules_done =3D OIDSET_INIT;
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
+	FUNC(NUL_IN_SYMLINK_TARGET, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
@@ -578,6 +581,33 @@ static int verify_ordered(unsigned mode1, const char =
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
@@ -626,6 +656,8 @@ static int fsck_tree(struct tree *item, struct fsck_op=
tions *options)
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
+		if (S_ISLNK(mode))
+			retval +=3D fsck_symlink(item, name, oid, options);

 		if (update_tree_entry_gently(&desc)) {
 			retval +=3D report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot =
be parsed as a tree");
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
