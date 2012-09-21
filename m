From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Fri, 21 Sep 2012 14:00:18 -0700
Message-ID: <7vpq5f3xct.fsf@alter.siamese.dyndns.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
 <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
 <20120919203738.GA24383@sigill.intra.peff.net>
 <7v7grn5h1l.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, marius@trolltech.com, namhyung@gmail.com,
	rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net, trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAKt-0003hQ-MT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab2IUVAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:00:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab2IUVAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E467D910D;
	Fri, 21 Sep 2012 17:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kzh821RCHylyRpJ4LWJztEC6emM=; b=Xg0ynt
	bdS5DuyLEJ5nVlhJelJ4fv4JWPL92y75rOIK3z4Zzbx16dxCBzRIrJhM+mSBECC5
	a0goSz6b165mxZAy1p0GDWG3Ga4X7oP1zMe62gMBKqwtipLEsZmdYLWNxLcNiO7A
	VZzlRpYaO2ganHrW9q54ml31NwcWx+htoYuHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YB6nM5GABIyI+M+vINwGdC3T05AaL9Ij
	uR40fGA4jd6J497ywcYQvP1fXHuYvC2ts3XGFfqiHgNf+peS1dkps5fBFdUnbVDi
	N8BQlL1Dw+4F+zJgzyGj8rdokux4NxsOdMb1Yd7uNGYdDoUxn49LGXhWU3eESYlI
	4X3fsK1yLSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF19F910B;
	Fri, 21 Sep 2012 17:00:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED62C910A; Fri, 21 Sep 2012
 17:00:19 -0400 (EDT)
In-Reply-To: <7v7grn5h1l.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 21 Sep 2012 12:09:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A556DB2-042F-11E2-9797-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206165>

Junio C Hamano <gitster@pobox.com> writes:

> Let's do this for now instead.  That would make it clear to people
> who (rightly or wrongly) think the "--follow" option should do
> something that we already do so, and explain the output that they
> see when they do give the "--follow" option to the command.
>
> I may do a "--no-follow" patch as a follow-up, or I may not,
> depending on the mood and workload.

A patch to do so looks like this.

If you know your history did not have any rename, or if you care
only about the history after a large rename that happened some time
ago, "git blame --no-follow $path" can be a way to tell the command
not to bother about them.

When you use -C, the lines that came from the renamed file will
still be found without the whole-file rename detection anyway, and
this is not all that interesting either way, I would think.


diff --git c/builtin/blame.c w/builtin/blame.c
index cad4111..bfa6086 100644
--- c/builtin/blame.c
+++ w/builtin/blame.c
@@ -42,6 +42,7 @@ static int blank_boundary;
 static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
+static int no_whole_file_rename;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1226,7 +1227,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
-	for (pass = 0; pass < 2; pass++) {
+	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
 		struct origin *(*find)(struct scoreboard *,
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
@@ -2344,6 +2345,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
 	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
+	DIFF_OPT_SET(&revs.diffopt, FOLLOW_RENAMES);
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
@@ -2367,6 +2369,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:
+	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
+	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
 	if (0 < abbrev)
diff --git c/diff.c w/diff.c
index f1b0447..32ebcbb 100644
--- c/diff.c
+++ w/diff.c
@@ -3584,6 +3584,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
+	else if (!strcmp(arg, "--no-follow"))
+		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (!prefixcmp(arg, "--color=")) {
