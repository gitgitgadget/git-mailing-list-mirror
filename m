Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDE01FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 08:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbdFOITo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 04:19:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33259 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdFOITm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 04:19:42 -0400
Received: by mail-it0-f68.google.com with SMTP id l6so1223728iti.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=jVIrJ2cQmSqm64EhUkcmPd14sY1cwkr0apX9gnola/o=;
        b=hes0pYd9phAQIoAGnu7H1WeBpJ8rb5b/BOeLUPXNcVhA0rs31SwDwIY0QgK2mjKQqm
         SyYIp48PY73VZgMnKZ22PmRgl4AtBqN7BTSqFEcGWuR7FyVptvzoW9VOZBnTyn3QbJ83
         fuQHLqa6et1HgGVWK6ko4Rysb9KHFvCg0OI4JAcKzgQhNZjqcrFENqMmSigE3ZRwdqha
         lyWvoMFVhBo98oWTjDWDfitfIh/MpYglAk8gqQDOe1lwT/6mwIUH8WbvPQin2LvUsurV
         9dr1WQtgF8zc5+vaYG2GQM4OlBcmJT31rfcJPuo99Rh4XOL71OYHzjeuoRR9ZedCCz8q
         r3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=jVIrJ2cQmSqm64EhUkcmPd14sY1cwkr0apX9gnola/o=;
        b=d1QxP5nE+tpyyeCTPZgnH7LHYd0kS2YCTSpXHfkgag1yYM3vj/5cVF8k2h6LSZ0llh
         TT4lnwwPaR8u8e/tRlVvIkNK9TLk3O7sblmz26u+O4gUO2/2hYgcpFBNYBMt+9JQsv12
         JoPaKOSQg2hi0Rr++h93kv5Ao4AEqlUf4Y8jg7Pz+vm6BMijShGx0ldSRwAYrEZFqDzg
         48lxdIcj6+Mq7C7JH1AlQL6FJC/4iOyJajro8Ia0V34NHCnxdPKEHQIPbHK0z+lS7LM9
         xPcnJveBpUaPxV+XKwu+4unN6IGxHt2430Qd7NqUMA4BW0Ev6kGPBKmKusLYyZbWCFBn
         bnMg==
X-Gm-Message-State: AKS2vOxsCg1OrpyN67kPvCvVb19WCLwiSwm3dKKm+CQbC1b+XwTN1HGv
        cPt/MPaoWE8NgA==
X-Received: by 10.36.190.11 with SMTP id i11mr3877851itf.109.1497514781556;
        Thu, 15 Jun 2017 01:19:41 -0700 (PDT)
Received: from unique-pc ([157.50.10.250])
        by smtp.googlemail.com with ESMTPSA id u63sm1429842ita.16.2017.06.15.01.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Jun 2017 01:19:41 -0700 (PDT)
Message-ID: <1497514760.2394.6.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Date:   Thu, 15 Jun 2017 13:49:20 +0530
In-Reply-To: <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
         <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
         <1497084241.8531.2.camel@gmail.com>
         <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
         <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
         <1497255003.1718.1.camel@gmail.com>
         <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
         <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
         <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
         <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-12 at 17:37 -0400, Jeff King wrote:
> On Mon, Jun 12, 2017 at 02:31:25PM -0700, Junio C Hamano wrote:
> > > I think "staged for commit" still makes perfect sense even when
> > > we are
> > > just asking "what's the current status" and not "what would it
> > > look like
> > > if I were to commit".
> > > 
> > > And avoiding the word "index" is worth-while here, I think. I am
> > > not in
> > > general of the "let's hide the index" camp" but it is a technical
> > > term.
> > > If we can say the same thing in a way that is understood both by
> > > people
> > > who know what the index is and people who do not, that seems like
> > > a win.
> > 
> > I do not mind "Changes not staged yet:".  The point was not about
> > getting rid of "stage" but about not mentioning "commit", because
> > stepping back a bit, if the readers are prepared to accept these
> > messages in the mindset that they are guiding them toward their
> > next
> > commit, "I find 'Initial commit' confusing" would not have been an
> > issue in the first place.
> 
> I think the difference is that "Initial commit" is talking about a
> _specific_ commit. If we're not working on one, it doesn't make much
> sense. But "staged for commit" is not necessarily talking about a
> specific commit; we are talking about the purpose of staging
> something
> in general. You could equally well say "staged for committing"
> (though I
> think the shorter word sounds more natural).
> 
> Likewise with "to be committed".
> 
> > If we can get rid of 'yet' and 'already' from the above two, that
> > would be even better.  The point of the exercise is to be
> > understood
> > by those who do not think in terms of 'preparing for the next
> > commit',
> > so 'yet', 'already', 'to be committed' are all counter-productive
> > for that goal.  Those who accept the 'description of the current
> > state in the context of preparing for the next commit' are not the
> > ones we are trying to help with the suggested three changes.
> 
> I agree that is the goal. My point was that the existing messages are
> OK
> even if you aren't thinking of preparing for the next commit. Saying
> "this is in the index" and "this is staged" are synonyms. Saying
> "this
> is staged for commit" is likewise a synonym, unless there is some
> other
> reason we stage things.
> 
> -Peff
What about, "not making any assumptions" about what the user would
think when he views the output of `git status` ? Why not try some
general messages like, 

* Staged changes
* Unstaged changes

instead of the messages such as 

* Changes to be committed, Changes already in the index
* Changes not staged for commit, Changes not yet in the index

which seem to make assumptions about the user who view the output ?

A typical patch could be found below,

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..3ed8e40bc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1364,6 +1364,7 @@ int cmd_status(int argc, const char **argv, const
char *prefix)
 		usage_with_options(builtin_status_usage,
builtin_status_options);
 
 	status_init_config(&s, git_status_config);
+	s.commit_template = 1;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
diff --git a/wt-status.c b/wt-status.c
index 037548496..55a7bd757 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -196,9 +196,14 @@ static void
wt_longstatus_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	status_printf_ln(s, c, _("Changes to be committed:"));
+	if (s->commit_template)
+		status_printf_ln(s, c, _("Changes to be committed:"));
+	else
+		status_printf_ln(s, c, _("Staged changes:"));
+
 	if (!s->hints)
 		return;
+
 	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
@@ -214,7 +219,11 @@ static void
wt_longstatus_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	status_printf_ln(s, c, _("Changes not staged for commit:"));
+	if (s->commit_template)
+		status_printf_ln(s, c, _("Changes not staged for
commit:"));
+	else
+		status_printf_ln(s, c, _("Unstaged changes:"));
+
 	if (!s->hints)
 		return;
 	if (!has_deleted)
@@ -1576,7 +1585,10 @@ static void wt_longstatus_print(struct wt_status
*s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s),
_("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet on the branch"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 6018c627b..38bb24ef3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,6 +77,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int commit_template;
 	int hints;
 
 	enum wt_status_format status_format;
