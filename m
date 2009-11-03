From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Tue, 03 Nov 2009 06:59:18 -0800
Message-ID: <7v3a4vu01l.fsf@alter.siamese.dyndns.org>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net>
 <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
 <4AB78910.7010402@viscovery.net>
 <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
 <4AB7A2E7.5000601@viscovery.net> <874oqvc0n3.fsf@users.sourceforge.net>
 <19129.24056.422939.880134@cargo.ozlabs.ibm.com>
 <7vd45io7da.fsf@alter.siamese.dyndns.org>
 <19183.64129.695745.269570@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy\, John" <john.murphy@bankofamerica.com>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 15:59:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5KrL-00058v-23
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 15:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbZKCO7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 09:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbZKCO7a
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 09:59:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZKCO73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 09:59:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C95E90EB7;
	Tue,  3 Nov 2009 09:59:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHQbMzni3eSoQg0uLhxP3JBi8KA=; b=OBdtTp
	e4paJezKdDpPxGSA0f7mh2K+uKySlknv/lKtCo+WONonylMkbbptGBXzX2Ky3Pao
	L1wYyLvJ4MITJ1R5SJTqHiPxsN/YDXu4tA+d84kPH7ruGnlk/t1U9mpYYSSTUYgv
	QR53K82ZlURkcFfkHoFKf7BpDVnltv+srvjnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O8gP2IrqTXs/hcHQAkAtyBJmqDPg372v
	2uDCu95FIwfkjIItajRLKOnaEcQQ4FhKfYN5mXJUV4PWdqKnMhTeDYHYjtSR1BKF
	2tR01+MP05u8ZYytolMAu49zuBRVyuVn9CaQgw1HgvXbwoDHsSW9djB4UorN2cT7
	HJ4IeMegYbY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5EAC90EB6;
	Tue,  3 Nov 2009 09:59:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6289790EB0; Tue,  3 Nov 2009
 09:59:21 -0500 (EST)
In-Reply-To: <19183.64129.695745.269570@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Tue\, 3 Nov 2009 20\:40\:17 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C35CA06-C889-11DE-BBD3-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131971>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> Even if you could, you would have the same issue giving them from the
>> command line anyway.  The right solution would likely to be to give the
>> same --stdin option as rev-list to "git log", I think.
>
> A --stdin option to git log would be great, but it doesn't seem to be
> implemented yet.  How hard would it be to add?

Fairly trivial.  Only lightly tested with things like:

    $ (echo ^master; echo next) | ./git log --stdin
    $ (echo ^master; echo jc/log-tz) | ./git format-patch --stdin --stdout

I am not signing this off because...

 - I do not want to think about what would happen if you give "-p" option,
   nor if our "pager" infrastructure is set up to allow us to do a
   sensible thing; and

 - This disables --stdin for blame as it wants to read contents from its
   standard input when given "-" as the file argument.  I suspect there
   probably are similar commands that use setup_revisions() and do not use
   a "--stdin" option but still read from the standard input, and they
   need to be fixed similarly, but I want somebody else to do the audit.

At least, not yet.

That is, making it work for "log" is trivial---making sure it won't break
unsuspecting bystanders is much more time-consuming work.

-- >8 --
Subject: teach --stdin to "log" family

Move the logic to read revs from standard input that rev-list knows about
from it to revision machinery, so that all the users of setup_revisions()
can feed the list of revs from the standard input when "--stdin" is used
on the command line.

Allow some users of the revision machinery that want different semantics
from the "--stdin" option to disable it by setting an option in the
rev_info structure.

This also cleans up the kludge made to bundle.c via cut and paste.

---
 builtin-blame.c     |    1 +
 builtin-diff-tree.c |    1 +
 builtin-rev-list.c  |    7 -------
 bundle.c            |    7 -------
 revision.c          |   15 +++++++++++++--
 revision.h          |    4 ++--
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7512773..b0aa530 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2352,6 +2352,7 @@ parse_done:
 			die_errno("cannot stat path '%s'", path);
 	}
 
+	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 79cedb7..2380c21 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -104,6 +104,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt->abbrev = 0;
 	opt->diff = 1;
+	opt->disable_stdin = 1;
 	argc = setup_revisions(argc, argv, opt, NULL);
 
 	while (--argc > 0) {
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 42cc8d8..f6a56f3 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -306,7 +306,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct rev_list_info info;
 	int i;
-	int read_from_stdin = 0;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
@@ -349,12 +348,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--stdin")) {
-			if (read_from_stdin++)
-				die("--stdin given twice?");
-			read_revisions_from_stdin(&revs);
-			continue;
-		}
 		usage(rev_list_usage);
 
 	}
diff --git a/bundle.c b/bundle.c
index df95e15..a7c9987 100644
--- a/bundle.c
+++ b/bundle.c
@@ -204,7 +204,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int i, ref_count = 0;
 	char buffer[1024];
 	struct rev_info revs;
-	int read_from_stdin = 0;
 	struct child_process rls;
 	FILE *rls_fout;
 
@@ -257,12 +256,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--stdin")) {
-			if (read_from_stdin++)
-				die("--stdin given twice?");
-			read_revisions_from_stdin(&revs);
-			continue;
-		}
 		return error("unrecognized argument: %s'", argv[i]);
 	}
 
diff --git a/revision.c b/revision.c
index 9fc4e8d..45c5de8 100644
--- a/revision.c
+++ b/revision.c
@@ -953,7 +953,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-void read_revisions_from_stdin(struct rev_info *revs)
+static void read_revisions_from_stdin(struct rev_info *revs)
 {
 	char line[1000];
 
@@ -1227,7 +1227,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
-	int i, flags, left, seen_dashdash;
+	int i, flags, left, seen_dashdash, read_from_stdin;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1245,6 +1245,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 	/* Second, deal with arguments and options */
 	flags = 0;
+	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg == '-') {
@@ -1283,6 +1284,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->no_walk = 0;
 				continue;
 			}
+			if (!strcmp(arg, "--stdin")) {
+				if (revs->disable_stdin) {
+					argv[left++] = arg;
+					continue;
+				}
+				if (read_from_stdin++)
+					die("--stdin given twice?");
+				read_revisions_from_stdin(revs);
+				continue;
+			}
 
 			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
diff --git a/revision.h b/revision.h
index b6421a6..f64637b 100644
--- a/revision.h
+++ b/revision.h
@@ -83,6 +83,8 @@ struct rev_info {
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1;
+	unsigned int	disable_stdin:1;
+
 	enum date_mode date_mode;
 
 	unsigned int	abbrev;
@@ -128,8 +130,6 @@ struct rev_info {
 #define REV_TREE_DIFFERENT	3	/* Mixed changes */
 
 /* revision.c */
-void read_revisions_from_stdin(struct rev_info *revs);
-
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
 extern volatile show_early_output_fn_t show_early_output;
 
