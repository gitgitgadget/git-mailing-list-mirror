Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AA41F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 10:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392368AbfJPKXK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 06:23:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60956 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfJPKXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 06:23:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GAJwbC082637;
        Wed, 16 Oct 2019 10:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : mime-version : content-type;
 s=corp-2019-08-05; bh=bP71Jercn0jtqLQP34G5bHEJFeSFx6q6RVC+OHImBp0=;
 b=sdPy0xOzYWZU7hswjX+JWcAy4rg1SRPFRPAxpxXlEIn+CQliyd+S/B124cWu4eij/jCx
 d1AgGezqgke6K6y/9EnmTbGBEBKNGOHrBfPOxKRt/Up4QoQP0gdoblxmYfz0La2shB+J
 jKMs4O5z4J7nEqbu7KhgBdtOlf5ow/vKISV27p21xEFEFqDbZ2hP12A3soj0royXFjND
 lb29hLengW/VCLAsAftgYKrrkwgfoYdtFlET5MJUz+s8aT6qc0eSlS4Z5SC//6uNMOsB
 6h1DjVd2G/ZvjTVtJdOZdTC7biyeWxlcQKH1jz+O/aNq3dc9ZYr3HhD/j5Dw7gyImpc1 eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vk7frdq0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 10:23:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GAMlgW148766;
        Wed, 16 Oct 2019 10:23:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vn8eqeetq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 10:22:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GAMwem001404;
        Wed, 16 Oct 2019 10:22:58 GMT
Received: from [10.175.50.235] (/10.175.50.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 10:22:58 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: email as a bona fide git transport
Message-ID: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
Date:   Wed, 16 Oct 2019 12:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8457B549DA2D505D3C75C377"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------8457B549DA2D505D3C75C377
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

(cross-posted to git, LKML, and the kernel workflows mailing lists.)

Hi all,

I've been following Konstantin Ryabitsev's quest for better development
and communication tools for the kernel [1][2][3], and I would like to
propose a relatively straightforward idea which I think could bring a
lot to the table.

Step 1:

* git send-email needs to include parent SHA1s and generally all the
   information needed to perfectly recreate the commit when applied so
   that all the SHA1s remain the same

* git am (or an alternative command) needs to recreate the commit
   perfectly when applied, including applying it to the correct parent

Having these two will allow a perfect mapping between email and git;
essentially email just becomes a transport for git. There are a lot of
advantages to this, particularly that you have a stable way to refer to
a patch or commit (despite it appearing on a mailing list), and there
is no need for "changeset IDs" or whatever, since you can just use the
git SHA1 which is unique, unambiguous, and stable.

As a rough proof of concept I've attached 3 git patches which implement
this. There are issues to work out like exact format, encodings, mail
mangling, error handling, etc., but hopefully the git community can
help out here. (Improvement suggestions are welcome!)

Step 2:

* A bot that follows LKML (and other lists) and imports patchsets into
   a git repository hosted on git.kernel.org

* The bot can add git notes with URLs to lore (and/or other mailing
   list archives) and store them in e.g. refs/notes/lore,
   refs/notes/lkml, etc.

   (For those who don't use git notes yet: they are essentially small
   bits of information you can add to a commit without changing its SHA1,
   and you can configure tools like 'git log' to show these at the bottom
   of a commit. Notes can also exist in a repo completely separate from
   the commits they attach data to, so there is _zero_ overhead for those
   who don't want to use this.)

* Maintainers can either pull patchsets directly from this bot-
   maintained repo OR they can continue to apply patches from their inbox
   (the result should be the same either way) OR they can continue in the
   old-style process (at least for a while) and just not have the
   benefits of the new process.

Step 3:

* Instead of describing a patchset in a separate introduction email, we
   can create a merge commit between the parent of the first commit in
   the series and the last and put the patchset description in the merge
   commit [5]. This means the patchset description also gets to be part
   of git history.

   (This would require support for git send-email/am to be able to send
   and apply merge commits -- at least those which have the same tree as
   one of the parents. This is _not_ yet supported in my proposed git
   patches.)

* stable SHA1s means we can refer to previous versions of a patchset by
   SHA1 rather than archive links. I propose a new changelog tag for
   this, maybe "Previous:" or maybe even a full list of "v1:", "v2:",
   etc. with a SHA1 or ref. Note that these SHA1s do *not* need to exist
   in Linus's repo, but those who want can pull those branches from the
   bot-maintained repo on git.kernel.org.

Advantages:

- we can keep using email to post patches/patchsets

- the process is opt-in (but should be encouraged) for both authors and
   maintainers, and the transition can happen over time

- there is a central repo for convenience, but it is not necessary for
   development to happen and is not a single point of failure -- it's
   more like Linus's repo and can be moved or even replicated from
   scratch by somebody else simply by having mailing list archives

- allows quick lookup of patch/patchset <-> email discussion within git

- allows diffing between versions of a single logical patchset

- patchset descriptions naturally become part of the changelog that ends
   up in Linus's tree

Disadvantages:

- requires patching git

- requires a bot to continuously create branches for patchsets sent to
   mailing lists

- increased storage/bandwidth for git.kernel.org (?)

- may need a couple of new wrapper scripts to automate patchset
   construction/versioning

Thoughts?


Vegard

PS: Eric Wong described something that comes quite close to this idea, 
but AFAICT without actually recreating commits exactly. I've included 
the link for completeness. [4]


[1]: https://lwn.net/Articles/793037/ "Ryabitsev: Patches carved into
developer sigchains"

[2]: https://lwn.net/Articles/799134/ "Defragmenting the kernel
development process"

[3]: 
https://lore.kernel.org/workflows/20190924182536.GC6041@hmswarspite.think-freely.org/

[4]: https://lore.kernel.org/workflows/20191008003931.y4rc2dp64gbhv5ju@dcvr/

[5]: To create this merge commit one could use something like this (bash):

# usage: patchset BASE [PREVIOUS_VERSION]
patchset () {
     start=$1
     prev=$2

     # construct tentative commit message
     commit_editmsg="$(git rev-parse --git-dir)/COMMIT_EDITMSG"
     (
         if [ -z "$prev" ]
         then
             echo 'Patchset title'
             echo
             echo Commits:
             echo
             git log --oneline $start..HEAD
         else
             git show --format=format:%B --no-patch $prev
             echo Previous-version: $(git rev-parse $prev)
         fi
     ) > "${commit_editmsg}"

     ${EDITOR} "${commit_editmsg}"

     merge=$(git commit-tree -p $start -p HEAD -F "${commit_editmsg}" 
$(git rev-parse HEAD^{tree}))
     echo $merge
}

This will open the editor to edit the patchset description and create a
merge commit that encompasses the patches in the patchset (use sha1^- to
view the patches in it).

--------------8457B549DA2D505D3C75C377
Content-Type: text/x-patch;
 name="0001-format-patch-add-complete.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-format-patch-add-complete.patch"

From 622a0469a4970c5daac0c0323e2d6a77b3bebbdb Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sat, 5 Oct 2019 16:15:59 +0200
Subject: [PATCH 1/3] format-patch: add --complete

Include the raw commit data between the changelog and the diffstat.
This will allow 'git am' to reconstruct the commit exactly to the point
where the sha1 will be the same.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
commit 622a0469a4970c5daac0c0323e2d6a77b3bebbdb
tree 8f09d9d6ed78f8617b2fe54fe9712990ba808546
parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571219301 +0200

---
 builtin/log.c | 12 ++++++++++++
 log-tree.c    | 17 +++++++++++++++++
 revision.h    |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c4b35fdaf9..81c1164ae5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1545,6 +1545,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
+	int complete = 0;
 	int show_progress = 0;
 	struct progress *progress = NULL;
 	struct oid_array idiff_prev = OID_ARRAY_INIT;
@@ -1622,6 +1623,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("add a signature")),
 		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
 			   N_("add prerequisite tree info to the patch series")),
+		OPT_BOOL(0, "complete", &complete,
+			 N_("include all the information necessary to reconstruct commit exactly")),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1905,6 +1908,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		prepare_bases(&bases, base, list, nr);
 	}
 
+	if (complete) {
+		/*
+		 * We need the commit buffer so that we can output the exact
+		 * sequence of bytes that gets hashed as part of a commit.
+		 */
+		save_commit_buffer = 1;
+		rev.show_raw_buffer = 1;
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
diff --git a/log-tree.c b/log-tree.c
index 923a299e70..2c9788b25a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -774,6 +774,22 @@ void show_log(struct rev_info *opt)
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
+
+	if (opt->show_raw_buffer) {
+		const char *buffer = get_commit_buffer(commit, NULL);
+		const char *subject;
+
+		fprintf(opt->diffopt.file, "---\n");
+		fprintf(opt->diffopt.file, "commit %s\n", oid_to_hex(&commit->object.oid));
+
+		/*
+		 * TODO: hex-encode to avoid mailer mangling?
+		 */
+		if (find_commit_subject(buffer, &subject))
+			fprintf(opt->diffopt.file, "%.*s", (int) (subject - buffer), buffer);
+		else
+			fprintf(opt->diffopt.file, "%s", buffer);
+	}
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
@@ -791,6 +807,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 	if (opt->loginfo && !opt->no_commit_id) {
 		show_log(opt);
+
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE &&
diff --git a/revision.h b/revision.h
index 4134dc6029..5297dc9f3c 100644
--- a/revision.h
+++ b/revision.h
@@ -190,7 +190,8 @@ struct rev_info {
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
-			preserve_subject:1;
+			preserve_subject:1,
+			show_raw_buffer:1;
 	unsigned int	disable_stdin:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
-- 
2.23.0.718.g3120370db8


--------------8457B549DA2D505D3C75C377
Content-Type: text/x-patch;
 name="0002-mailinfo-collect-commit-metadata-from-mail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-mailinfo-collect-commit-metadata-from-mail.patch"

From 51bb531eb57320caf3761680ebf77c25b89b3719 Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 16 Oct 2019 02:04:08 +0200
Subject: [PATCH 2/3] mailinfo: collect commit metadata from mail

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
commit 51bb531eb57320caf3761680ebf77c25b89b3719
tree f3a3141f7d3f706d8ca60cdc1e1cde5aa2cc927a
parent 622a0469a4970c5daac0c0323e2d6a77b3bebbdb
author Vegard Nossum <vegard.nossum@oracle.com> 1571184248 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571219301 +0200

---
 builtin/am.c       |  2 +-
 builtin/mailinfo.c | 11 +++++++---
 mailinfo.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 mailinfo.h         |  4 +++-
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..4190383bba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1159,7 +1159,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	mi.input = xfopen(mail, "r");
 	mi.output = xfopen(am_path(state, "info"), "w");
-	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
+	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch"), am_path(state, "meta")))
 		die("could not parse patch");
 
 	fclose(mi.input);
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cfb667a594..f3f9aabd97 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -16,7 +16,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	const char *def_charset;
 	struct mailinfo mi;
 	int status;
-	char *msgfile, *patchfile;
+	char *msgfile, *patchfile, *metafile;
 
 	setup_mailinfo(&mi);
 
@@ -47,7 +47,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		argc--; argv++;
 	}
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		usage(mailinfo_usage);
 
 	mi.input = stdin;
@@ -56,10 +56,15 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	msgfile = prefix_filename(prefix, argv[1]);
 	patchfile = prefix_filename(prefix, argv[2]);
 
-	status = !!mailinfo(&mi, msgfile, patchfile);
+	metafile = NULL;
+	if (argc == 4)
+		metafile = prefix_filename(prefix, argv[3]);
+
+	status = !!mailinfo(&mi, msgfile, patchfile, metafile);
 	clear_mailinfo(&mi);
 
 	free(msgfile);
 	free(patchfile);
+	free(metafile);
 	return status;
 }
diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..50e2c685df 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -825,6 +825,40 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
+/*
+ * returns non-0 when we're done handling metadata
+ */
+static int handle_meta(struct mailinfo *mi, const struct strbuf *line)
+{
+	if (mi->meta_stage == 0) {
+		/*
+		 * Swallow the first patch break and continue handling meta
+		 */
+		if (patchbreak(line)) {
+			++mi->meta_stage;
+			return 0;
+		}
+
+		return 1;
+	}
+
+	if (mi->meta_stage == 1) {
+		/*
+		 * Check that the first line is "commit ", punt if not
+		 */
+		if (!starts_with(line->buf, "commit "))
+			return 1;
+
+		++mi->meta_stage;
+	}
+
+	if (patchbreak(line))
+		return 1;
+
+	strbuf_addbuf(&mi->meta_text, line);
+	return 0;
+}
+
 static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 {
 	fwrite(line->buf, 1, line->len, mi->patchfile);
@@ -840,6 +874,11 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 		mi->filter_stage++;
 		/* fallthrough */
 	case 1:
+		if (!handle_meta(mi, line))
+			break;
+		mi->filter_stage++;
+		/* fallthrough */
+	case 2:
 		handle_patch(mi, line);
 		break;
 	}
@@ -1145,9 +1184,10 @@ static void handle_info(struct mailinfo *mi)
 	fprintf(mi->output, "\n");
 }
 
-int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
+int mailinfo(struct mailinfo *mi, const char *msg, const char *patch, const char *meta)
 {
 	FILE *cmitmsg;
+	FILE *metafile;
 	int peek;
 	struct strbuf line = STRBUF_INIT;
 
@@ -1163,6 +1203,14 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
+	metafile = fopen(meta, "w");
+	if (!metafile) {
+		perror(meta);
+		fclose(mi->patchfile);
+		fclose(cmitmsg);
+		return -1;
+	}
+
 	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 
@@ -1184,6 +1232,9 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	fclose(cmitmsg);
 	fclose(mi->patchfile);
 
+	fwrite(mi->meta_text.buf, 1, mi->meta_text.len, metafile);
+	fclose(metafile);
+
 	handle_info(mi);
 	strbuf_release(&line);
 	return mi->input_error;
@@ -1210,8 +1261,10 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
+	strbuf_init(&mi->meta_text, 0);
 	strbuf_init(&mi->inbody_header_accum, 0);
 	mi->header_stage = 1;
+	mi->meta_stage = 0;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
 	git_config(git_mailinfo_config, mi);
diff --git a/mailinfo.h b/mailinfo.h
index 79b1d6774e..89386103bd 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -31,16 +31,18 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	int meta_stage;
 	struct strbuf inbody_header_accum;
 	struct strbuf **p_hdr_data;
 	struct strbuf **s_hdr_data;
 
 	struct strbuf log_message;
+	struct strbuf meta_text;
 	int input_error;
 };
 
 void setup_mailinfo(struct mailinfo *);
-int mailinfo(struct mailinfo *, const char *msg, const char *patch);
+int mailinfo(struct mailinfo *, const char *msg, const char *patch, const char *meta);
 void clear_mailinfo(struct mailinfo *);
 
 #endif /* MAILINFO_H */
-- 
2.23.0.718.g3120370db8


--------------8457B549DA2D505D3C75C377
Content-Type: text/x-patch;
 name="0003-am-add-exact.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-am-add-exact.patch"

From 3120370db888889f32e07a082edb4722db8feef1 Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 16 Oct 2019 02:36:18 +0200
Subject: [PATCH 3/3] am: add --exact

This uses exact metadata when creating the commit object, hopefully
reconstructing the commit with the exact same SHA1.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
commit 3120370db888889f32e07a082edb4722db8feef1
tree 61b7556f06fd6fcb0f4a43940ec0cbc29ccf1bcc
parent 51bb531eb57320caf3761680ebf77c25b89b3719
author Vegard Nossum <vegard.nossum@oracle.com> 1571186178 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571219301 +0200

---
 builtin/am.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4190383bba..069a625895 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -118,6 +118,7 @@ struct am_state {
 	int allow_rerere_autoupdate;
 	const char *sign_commit;
 	int rebasing;
+	int exact;
 };
 
 /**
@@ -399,6 +400,8 @@ static void am_load(struct am_state *state)
 
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
+	state->exact = read_state_file(&sb, state, "exact", 1);
+
 	strbuf_release(&sb);
 }
 
@@ -1005,6 +1008,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	else
 		write_state_text(state, "applying", "");
 
+	write_state_bool(state, "exact", state->exact);
+
 	if (!get_oid("HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
@@ -1548,19 +1553,88 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  */
 static void do_commit(const struct am_state *state)
 {
+	struct object_id meta_commit = {};
+	struct object_id meta_tree = {};
+
 	struct object_id tree, parent, commit;
 	const struct object_id *old_oid;
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (state->exact) {
+		/*
+		 * Scan meta file for parents + other data
+		 */
+
+		struct strbuf line = STRBUF_INIT;
+		FILE *fp = xfopen(am_path(state, "meta"), "r");
+
+		while (!strbuf_getline_lf(&line, fp)) {
+			const char *rest;
+
+			if (skip_prefix(line.buf, "commit ", &rest)) {
+				if (get_oid_hex(rest, &meta_commit))
+					die("invalid exact metadata (commit)");
+			} else if (skip_prefix(line.buf, "tree ", &rest)) {
+				if (get_oid_hex(rest, &meta_tree))
+					die("invalid exact metadata (tree)");
+			} else if (skip_prefix(line.buf, "parent ", &rest)) {
+				if (get_oid_hex(rest, &parent))
+					die("invalid exact metadata (parent)");
+
+				commit_list_insert(lookup_commit(the_repository, &parent), &parents);
+			} else if (skip_prefix(line.buf, "author ", &rest)) {
+				author = strdup(rest);
+			} else if (skip_prefix(line.buf, "committer ", &rest)) {
+				char *name_copy;
+				char *email;
+				char *email_copy;
+				char *date;
+
+				email = strstr(rest, " <");
+				if (!email)
+					die("invalid exact metadata (committer name)");
+
+				name_copy = xstrndup(rest, email - rest);
+				email += 2;
+				setenv("GIT_COMMITTER_NAME", name_copy, 1);
+				free(name_copy);
+
+				date = strstr(email, "> ");
+				if (!date)
+					die("invalid exact metadata (committer email)");
+
+				email_copy = xstrndup(email, date - email);
+				date += 2;
+				setenv("GIT_COMMITTER_EMAIL", email_copy, 1);
+				free(email_copy);
+
+				setenv("GIT_COMMITTER_DATE", date, 1);
+			} else if (line.len == 0) {
+				break;
+			} else {
+				die("unknown exact metadata: %.*s", line.len, line.buf);
+			}
+		}
+
+		fclose(fp);
+	}
+
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-	if (!get_oid_commit("HEAD", &parent)) {
+	if (state->exact && !oideq(&tree, &meta_tree))
+		die("tree mismatch");
+
+	if (state->exact) {
+		/*
+		 * Already got parents above.
+		 */
+	} else if (!get_oid_commit("HEAD", &parent)) {
 		old_oid = &parent;
 		commit_list_insert(lookup_commit(the_repository, &parent),
 				   &parents);
@@ -1569,19 +1643,28 @@ static void do_commit(const struct am_state *state)
 		say(state, stderr, _("applying to an empty history"));
 	}
 
-	author = fmt_ident(state->author_name, state->author_email,
-		WANT_AUTHOR_IDENT,
-			state->ignore_date ? NULL : state->author_date,
-			IDENT_STRICT);
-
-	if (state->committer_date_is_author_date)
-		setenv("GIT_COMMITTER_DATE",
-			state->ignore_date ? "" : state->author_date, 1);
+	if (state->exact) {
+		/*
+		 * Already got author above.
+		 */
+	} else {
+		author = fmt_ident(state->author_name, state->author_email,
+			WANT_AUTHOR_IDENT,
+				state->ignore_date ? NULL : state->author_date,
+				IDENT_STRICT);
+
+		if (state->committer_date_is_author_date)
+			setenv("GIT_COMMITTER_DATE",
+				state->ignore_date ? "" : state->author_date, 1);
+	}
 
 	if (commit_tree(state->msg, state->msg_len, &tree, parents, &commit,
 			author, state->sign_commit))
 		die(_("failed to write commit object"));
 
+	if (state->exact && !oideq(&commit, &meta_commit))
+		die("sha1 mismatch");
+
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
 		reflog_msg = "am";
@@ -2182,6 +2265,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_BOOL('e', "exact", &state.exact,
+			N_("preserve exact metadata, including sha1")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
 			0),
-- 
2.23.0.718.g3120370db8


--------------8457B549DA2D505D3C75C377--
