Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DFFF20281
	for <e@80x24.org>; Tue, 12 Sep 2017 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdILWoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 18:44:24 -0400
Received: from mout.web.de ([212.227.17.11]:64803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdILWoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 18:44:22 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkPj-1dkzcE0lQV-00Ajz2; Wed, 13
 Sep 2017 00:44:01 +0200
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
To:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
 <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
 <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <837ff6fe-a645-97fe-4b21-ec36f662ce19@web.de>
Date:   Wed, 13 Sep 2017 00:43:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0gO4MFchil/wea7JCMKMnkBWGN6mqytveSD9svyufbjljmC6olI
 cxgFiRQCCmV+YOOANTGavnF1XAJ9xi91un/49Q/WTrEEzD0Kih6nUm01pWwChbKCcMa6QqT
 DoFXU/1kbeSXSqA/rLf/QIyif4uczw9ihAiTOthihDWkytxNDLb6m62csB89qmPBMKDzqNZ
 UYxaBcRaw1fSAcvJNPMDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YeoRSDR+XLA=:68KSCSfpw1zKW4cxa5eIb2
 WlaIpQlUQBIhK6OHcIrHP5gPYHlzf/4im6tkWf2dReBmtXI6oBHt/JIgnUPDFH3ZuBz4obtSI
 iZsrgPujAzplPU9vJkdyVsLsAzrMD2HvySeOnIaOvOnhv7FYv38+5y8Gvg+PzUUaXt4SPCmBo
 L3PjdLAqgZU7S2NBcc5f57cHjuZvwRsNHpLktPvY2ndSIm1YF2RxQ1rhPJXa87XhgOcV865nH
 cJxnhI25ebKF7X5M0V5sKDt+NE55MHN2kaFAKC14yAupfeY43+LFs+qiKOXKAP/Yxcs7gsbNU
 LrjLkx8lF1DFOU/aNX8+C/opNINK5IiFBzoX0MLbZUMrmMsnGkcL4LBULW9TZ/3meBOVRQkaV
 /+MwFb0zLLY0hQS40W02hrIklqhNE7fWRQt2yp80v8c30pTC6M4fTTmBHeoC5mVvrTjpYVbnI
 R1CWxD1SDJKvvipiCOzKqz/xF0WLvek4rbDlz75U+q2xwabT8xkX1ILVvwsuWIOfmqezJh6QF
 CbV/aSb2pItIXPE6JlQNL1Egjq57KYqbTK9w9ReqpVV6RbYvl2aCBFbd4TiQCY9ZDtaTwMOxY
 vCZXt54lY9n0ESyBbSsOBj1/8YITuNBrvsFA49+mDUVFaUmkIdESs1X5N/2lT8QSKe00tX3W4
 nAxuAfmIhyiR6oIpZ06jWVaIdrgO4ON5SjNDswYu9tPv/rASEj8IBT4ai0v5wezuTVtemfuyn
 LuzlEuf9NBZkHnoQ2Zh0DjU5RB5nGuU+XE8JvYS54qxbJVwLN56Kap8SCZ8Y3TiNy77He5EU1
 mNpFdSoX64aOqBrtuzkPSNfw+ZGX6fcAkdDFiIVy0Fh7qFwudY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.2017 um 11:06 schrieb Jeff King:
> I actually think it would be reasonable to omit the empty directory in
> t5004. The main thing we care about there is that we produce an archive
> with no files rather than barfing. Checking that the empty directory is
> actually there was mostly "this is what it happens to produce" rather
> than any conscious decision, I think.
> 
> If the new rule is "we omit empty directories", then it would make sense
> for us to follow that, regardless of whether it happened by pathspec
> limiting or if the tree was empty in the first place (and such an
> empty tree is insane anyway; Git tries hard not to create them).

Right.

-- >8 --
Subject: [PATCH] archive: don't add empty directories to archives

While git doesn't track empty directories, git archive can be tricked
into putting some into archives.  One way is to construct an empty tree
object, as t5004 does.  While that is supported by the object database,
it can't be represented in the index and thus it's unlikely to occur in
the wild.

Another way is using the literal name of a directory in an exclude
pathspec -- its contents are are excluded, but the directory stub is
included.  That's inconsistent: exclude pathspecs containing wildcards
don't leave empty directories in the archive.

Yet another way is have a few levels of nested subdirectories (e.g.
d1/d2/d3/file1) and ignoring the entries at the leaved (e.g. file1).
The directories with the ignored content are ignored as well (e.g. d3),
but their empty parents are included (e.g. d2).

As empty directories are not supported by git, they should also not be
written into archives.  If an empty directory is really needed then it
can be tracked and archived by placing an empty .gitignore file in it.

There already is a mechanism in place for suppressing empty directories.
When read_tree_recursive() encounters a directory excluded by a pathspec
then it enters it anyway because it might contain included entries.  It
calls the callback function before it is able to decide if the directory
is actually needed.  For that reason git archive adds directories to a
queue and writes entries for them only when it encounters the first
child item -- but currently only if pathspecs with wildcards are used.

Queue *all* directories, no matter if there even are pathspecs present.
This prevents git archive from writing entries for empty directories in
all cases.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive.c                       | 19 ++-----------------
 t/t5001-archive-attr.sh         |  2 +-
 t/t5002-archive-attr-pattern.sh |  2 +-
 t/t5004-archive-corner-cases.sh |  4 ++--
 4 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/archive.c b/archive.c
index 1ab8d3a1d7..1e41f4bbeb 100644
--- a/archive.c
+++ b/archive.c
@@ -121,11 +121,6 @@ static int check_attr_export_subst(const struct attr_check *check)
 	return check && ATTR_TRUE(check->items[1].value);
 }
 
-static int should_queue_directories(const struct archiver_args *args)
-{
-	return args->pathspec.has_wildcard;
-}
-
 static int write_archive_entry(const unsigned char *sha1, const char *base,
 		int baselen, const char *filename, unsigned mode, int stage,
 		void *context)
@@ -147,7 +142,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	if (!S_ISDIR(mode) || !should_queue_directories(args)) {
+	if (!S_ISDIR(mode)) {
 		const struct attr_check *check;
 		check = get_archive_attrs(path_without_prefix);
 		if (check_attr_export_ignore(check))
@@ -169,14 +164,6 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	return write_entry(args, sha1, path.buf, path.len, mode);
 }
 
-static int write_archive_entry_buf(const unsigned char *sha1, struct strbuf *base,
-		const char *filename, unsigned mode, int stage,
-		void *context)
-{
-	return write_archive_entry(sha1, base->buf, base->len,
-				     filename, mode, stage, context);
-}
-
 static void queue_directory(const unsigned char *sha1,
 		struct strbuf *base, const char *filename,
 		unsigned mode, int stage, struct archiver_context *c)
@@ -290,9 +277,7 @@ int write_archive_entries(struct archiver_args *args,
 	}
 
 	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
-				  should_queue_directories(args) ?
-				  queue_or_write_archive_entry :
-				  write_archive_entry_buf,
+				  queue_or_write_archive_entry,
 				  &context);
 	if (err == READ_TREE_RECURSIVE)
 		err = 0;
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 897f6f06d5..e9aa97117a 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -73,7 +73,7 @@ test_expect_missing	archive-pathspec/ignored-by-tree
 test_expect_missing	archive-pathspec/ignored-by-tree.d
 test_expect_missing	archive-pathspec/ignored-by-tree.d/file
 test_expect_exists	archive-pathspec/ignored-by-worktree
-test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
+test_expect_missing	archive-pathspec/excluded-by-pathspec.d
 test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
 
 test_expect_success 'git archive with wildcard pathspec' '
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 6667d159ab..bda6d7d7e9 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -76,7 +76,7 @@ test_expect_missing	archive/deep/and/slashless/ &&
 test_expect_missing	archive/deep/and/slashless/foo &&
 test_expect_missing	archive/deep/with/wildcard/ &&
 test_expect_missing	archive/deep/with/wildcard/foo &&
-test_expect_exists	archive/one-level-lower/
+test_expect_missing	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
 
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index f6207f42b5..ced44355ca 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -108,14 +108,14 @@ test_expect_success 'archive empty subtree with no pathspec' '
 	git archive --format=tar $root_tree >subtree-all.tar &&
 	make_dir extract &&
 	"$TAR" xf subtree-all.tar -C extract &&
-	check_dir extract sub
+	check_dir extract
 '
 
 test_expect_success 'archive empty subtree by direct pathspec' '
 	git archive --format=tar $root_tree -- sub >subtree-path.tar &&
 	make_dir extract &&
 	"$TAR" xf subtree-path.tar -C extract &&
-	check_dir extract sub
+	check_dir extract
 '
 
 ZIPINFO=zipinfo
-- 
2.14.1
