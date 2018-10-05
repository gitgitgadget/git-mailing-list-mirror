Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9AC11F453
	for <e@80x24.org>; Fri,  5 Oct 2018 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJEWgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 18:36:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:47461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEWgO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 18:36:14 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1gANy83Oyv-002aqi; Fri, 05
 Oct 2018 17:36:53 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1gANy83Oyv-002aqi; Fri, 05
 Oct 2018 17:36:53 +0200
Date:   Fri, 5 Oct 2018 17:36:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/1] rebase -i: introduce the 'break' command
In-Reply-To: <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810051409220.2034@tvgsbejvaqbjf.bet>
References: <pull.43.git.gitgitgadget@gmail.com> <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com> <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nDRGzRdh7yq/XyYJTGwAGqw+cqot2/xZiE901/lgEgm+vvI8ZtK
 6l3JskO0tfatkot1pAJmS5sFQoM6YEp1XCFOmBlQZXzhEBBX0ZmMQLZL20MoML6o06QcTrh
 s7GrZoeYNYkR2vMPVhILGZ1pSRlrgGmtEDAW5ElhVPjbaU3JAaVFZjQdN/Ibhu4cn5mtXcC
 GTQAj80ayDUgcfpdVexFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tPOFWEwpZxI=:/75lM0EPyRqPq86QvIiC2N
 JpYA/VgFwcQdd3rJrryV7kyGNpNFw4P2+Oe42phBWtKfPgisChOzuIc3IXLdkiVXmfjXzlRdH
 mTACsVrWwGyYcV3rqH5blAvo3bcjmJ3/gUMZSnjMuvdgPA8+GWZcqEcCaOfG5cqH9GmHoy0B6
 IdemE0DYta6IlMIYFls/jY6sNXiNB8GSzSyGXhzPJyiGFzviR/RUcK4+xx83YguRTeFhitCBp
 osWbgVQT6yiarC0eSXSzXkwbMrVz/V6/wP4xOCG1pSQTUangz9ILVc01NnHxyE40rtFM/oZkw
 PIcQ3RcPVNXRtE5C0BFez1NVFKF5tsmQkMwFT+XfYNm5Q+YlSf44eMQg+7rSxMetGGZYyCfsD
 lHOTL9JZlnqPJXK8r0za51tqKg2U136FWhbje/Ar/D85fqZWyafiT3NEsWYpYqja8ZCGeZ6RO
 xkw2y2gv2Mn/hFBGu0F//O0Bzw32O4j9h3LS7GLSWEyo8ckXY6WvC9uE8A2I2T/GufyMYoa24
 vWqbiJbm/5mOs0GJHERkQ8U7b+DHrKpV8a+Z6l7ybR8mDKpeQq/xvZFGM2ZuvC3kWtFZXJR1p
 keho6tpOYTa2qkLOiAxlX+o4CmcLTdclcRja261AMVKOLAp/cpVUudfJmBqVkHgELFIpj+Gtp
 F7uIX4efQfqwix9Yb6s9pts0uIFmF1jWguPQh/CT45EYvmbjvzz1j/XH3RGQJH3/jmRGrj1FK
 ipNvBpiLsPlXoQsH4+f8+jJ1Ck7IDFslsfziGg+mWry8D/o7tzbpRT/KXayTNdLJJgfLWuJ4n
 pecoyeW75iz6s4aYVpCiQOnUzLJ6rSBraJBL9EzL+Ag80DPUK8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 5 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The 'edit' command can be used to cherry-pick a commit and then
> > immediately drop out of the interactive rebase, with exit code 0, to let
> > the user amend the commit, or test it, or look around.
> >
> > Sometimes this functionality would come in handy *without*
> > cherry-picking a commit, e.g. to interrupt the interactive rebase even
> > before cherry-picking a commit, or immediately after an 'exec' or a
> > 'merge'.
> >
> > This commit introduces that functionality, as the spanking new 'break' command.
> >
> > Suggested-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> If one wants to emulate this with the versions of Git that are
> currently deployed, would it be sufficient to insert "exec false"
> instead of "break"?

There is one crucial difference: the exit code.

If you are scripting around `git rebase -i` (and I do, heavily), then that
is quite a difference: who's to say that the rebase "failed" because of
that `exec false`, or if it failed another `exec` unexpectedly?

> The reason I am asking is *not* to imply that we do not need this
> new feature.  It is because I vaguely recall seeing a request to add
> 'pause' to the insn set and "exec false" was mentioned as a more
> general alternative long time ago.  I am trying to see if this is a
> recurring request/wish, because it would reinforce that this new
> feature would be a good addition if that is the case.
> 
> I suspect that "exec false" would give a message that looks like a
> complaint ("'false' failed so we are giving you control back to fix
> things" or something like that), and having a dedicated way to pause
> the execution without alarming the user is a good idea.
> 
> I think the earlier request asked for 'pause' (I didn't dig the list
> archive very carefully, though),

No need to: I mentioned it in the cover letter. Here is the link again,
for your convenience:
https://public-inbox.org/git/20180118183618.39853-3-sbeller@google.com/

> and 'stop' may also be a possible verb, but I tend to agree with this
> patch that 'break' is probably the best choice, simply because it begins
> with 'b' in the abbreviated form, a letter that is not yet used by
> others (unlike 'pause' or 'stop' that would want 'p' and 's' that are
> already taken)..
> 
> Here is a tangent, but I think the description of "-x <cmd>" in "git
> rebase --continue" should mention that a failing command would
> interrupt the sequencer.  That fact about "exec" command is given
> much later in the last part of the "interactive mode" section of the
> manual, so technically our docs are not being incomplete, but the
> current description is not helpful to those who are looking for
> substring "exec" from the beginning of the documentation to find out
> if the exit status of the command affects the way commits are
> replayed (which is what I was doing when imagining how users would
> emulate this feature with deployed versions of Git).
> 
> Perhaps something as simple as this...
> 
>  Documentation/git-rebase.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0e20a66e73..0fc5a851b5 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
>  --exec <cmd>::
>  	Append "exec <cmd>" after each line creating a commit in the
>  	final history. <cmd> will be interpreted as one or more shell
> -	commands.
> +	commands, and interrupts the rebase session when it exits with
> +	non-zero status.

Good initial version. I would like it to be a bit more precise about who
exits with what status. How about this:

+	commands. Any command that fails will interrupt the rebase,
+	with exit code 1.

>  +
>  You may execute several commands by either using one instance of `--exec`
>  with several commands:
> 
> 
> Also, it seems that this has some interaction with the topics in
> flight; the added test does pass when queued on top of 'master', but
> fails when merged to 'pu'.  I didn't look into the details as I am
> not fully online yet.

I had a similar issue in a preliminary revision, and had to unset
GIT_EDITOR to fix it. Probably the culprit here is the same; I could
imagine that core.editor was set by another topic.

[... clicketiclick, debug debug debug, 1.5h later...]

Actually, this is not the problem. The problem is that the interactive
rebase exits with status 0 but does not leave a `stopped-sha` file behind,
and the builtin rebase mistakes that for a sign that it can clean up the
state dir.

However, we definitely do not want to leave that file, because it
indicates a fixup or squash with merge conflicts was left behind.

Taking a step back, it appears that we do a whole lot of work for nothing
in the case of the interactive rebase: it cleans up the state directory
itself already, and takes care of the autostash support, too.

So I will apply this fixup js/rebase-in-c-5.5-work-with-rebase-i-in-c:

-- snip --
fixup! builtin rebase: prepare for builtin rebase -i

The original patch worked, but overlooked the fact that `git
rebase--interactive` really wants to take care of finishing the rebase
itself.

While it was not harmful to try again, there was no directory to work
with, so no harm was done. Except in the case that an `edit` command was
processed, in which case we used the `stopped-sha` file as tell-tale
that we should not remove the state directory.

However, with the `break` command we do not have such a tell-tale. But
then, we don't really need one: the built-in `rebase--interactive` takes
care of clean-up itself. So we can just skip it in the built-in rebase.

While at it, remove the `case` arm for the interactive rebase that is
now skipped in favor of the short-cut to the built-in rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 99fd5d4017..2ca5fa1d74 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -410,6 +410,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 			argv_array_push(&child.args, "--signoff");
 
 		status = run_command(&child);
+
 		goto finished_rebase;
 	}
 
@@ -475,10 +476,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 		backend = "git-rebase--am";
 		backend_func = "git_rebase__am";
 		break;
-	case REBASE_INTERACTIVE:
-		backend = "git-rebase--interactive";
-		backend_func = "git_rebase__interactive";
-		break;
 	case REBASE_MERGE:
 		backend = "git-rebase--merge";
 		backend_func = "git_rebase__merge";
@@ -501,6 +498,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
+	else if (opts->type == REBASE_INTERACTIVE)
+		; /* interactive rebase cleans up after itself */
 	else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
-- snap --

This fix-up seems to unbreak the `break` test case (pun intended)...

Ciao,
Dscho

-- 
2.19.0.windows.1.30.g502e856705

> 
> Thanks.
> 
