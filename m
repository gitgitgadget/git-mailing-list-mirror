From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 19:37:55 -0800
Message-ID: <7vzl48w2jw.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
 <7v3a201lpz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
 <7vljfsz7vx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 04:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXnsJ-0001ib-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 04:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab0AUDiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 22:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969Ab0AUDiN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 22:38:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0AUDiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 22:38:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5EB9927E9;
	Wed, 20 Jan 2010 22:38:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDaBd8emdsMDK+2TkA5k6nDWxoo=; b=QnETnb
	R5PUlPoeKiFwz0lR5XVWBQespGdmDbqkO7PHNc2agr/wt592+QgtRBOeysaQcUR2
	KHrV7kkuHCgcvBcRaKRrH5dqUa7zsyizqhS5f6Mip6W/hXrbfyFzGiZ4cHwtrRxk
	tob9lo1PuwW8Lfy+Bq0bAclPbOoi3XNbsyCuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFF/patMpO2OK2G00TRdpV6i2dAMbeSw
	Aid1ksMjf5W6IiCJkhB/DRNwPxIppB1HBZQ4SfrL7tj4jLUrbB8azXr4Htt4jKrW
	Wq/I7R7bQd1rwopRYDcLgQ1RhOHDyRgI1MQSqdN2teHUt4554yklyK9QY46+r7GY
	sAO676C1e9E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F2BC927E2;
	Wed, 20 Jan 2010 22:38:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2838927DE; Wed, 20 Jan
 2010 22:37:56 -0500 (EST)
In-Reply-To: <7vljfsz7vx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 20 Jan 2010 15\:14\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61D6168C-063E-11DF-9FA5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137623>

Junio C Hamano <gitster@pobox.com> writes:

> Actually I am of two minds regarding --pretty={short,medium} and the
> like.  The "how about this" patch may be the safest for people who are
> used to read "log --pretty=xxx" output with scripts, but it does look
> inconsistent and hard to explain to new people who do not even know that
> there were versions of git that does not know about notes.

Heh, it is not surprising that we have this bug, given that all of us just
missed how bogus my "how about this" patch was ;-)

The check for "if (fmt_pretty)" only kicks in when that thing was read
from the configuration; handling of command line --pretty and --pretty=
options happen long after that, when we call setup_revisions().

So if we really wanted to say "If the user explicitly tells us to run
under a particular --pretty mode, we don't show notes by default.", we
would need a patch like this on top of it.

Another thing to note is that "work differently between no --pretty on the
command line and an explicit --pretty=medium" is more work than "we always
default to show notes if showing in the default verbosity".

This version considers a user supplied "format.pretty" configuration as
"the user told us to use this specific format, and we won't show notes
unless explicitly told".  I personally don't care either way exactly
because I don't use that configuration (nor teach others to use it), but
in a sense the configuration is setting a personal "default", so I think
it could be argued that we should instead show the notes by default in
that case (i.e. remove "rev->pretty_given = 1" in the first hunk).

 builtin-log.c |    9 ++++++---
 revision.c    |    4 ++++
 revision.h    |    2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3bc3919..1e05b0f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -39,10 +39,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
-	if (fmt_pretty)
+	if (fmt_pretty) {
 		get_commit_format(fmt_pretty, rev);
-	else
-		rev->show_notes = 1;
+		rev->pretty_given = 1;
+	}
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
@@ -60,6 +60,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 
+	if (!rev->show_notes_given && !rev->pretty_given)
+		rev->show_notes = 1;
+
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
diff --git a/revision.c b/revision.c
index 7e00a6c..0de78fb 100644
--- a/revision.c
+++ b/revision.c
@@ -1161,14 +1161,18 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
+		revs->pretty_given = 1;
 		get_commit_format(arg+8, revs);
 	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		revs->verbose_header = 1;
+		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
+		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
+		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index 4167c1e..a14deef 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,8 @@ struct rev_info {
 	unsigned int	shown_one:1,
 			show_merge:1,
 			show_notes:1,
+			show_notes_given:1,
+			pretty_given:1,
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
