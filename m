Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F841F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 08:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeJLQHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:07:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:36407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLQHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:07:24 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1fX6ZB49GB-013x97; Fri, 12
 Oct 2018 10:35:55 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1fX6ZB49GB-013x97; Fri, 12
 Oct 2018 10:35:55 +0200
Date:   Fri, 12 Oct 2018 10:35:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: introduce the 'break' command
In-Reply-To: <fd14c00f-65d5-f5d6-5f0e-ee0de7593a38@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1810121035190.45@tvgsbejvaqbjf.bet>
References: <pull.43.git.gitgitgadget@gmail.com> <pull.43.v2.git.gitgitgadget@gmail.com> <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com> <fd14c00f-65d5-f5d6-5f0e-ee0de7593a38@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T1YQKOC8xupy1M2AK94ghwt7sEpYHcpq5tTLbEkdiLddZgjYZgG
 +qgr3v9PnaXX5JRLLJgQbZF7aUdm+Tufdp3q9mxRrcYX6ehA4rkgDMN/VZWzm+JH1PBdXpJ
 a4e+p9Nv0D4grJ+WWyYr/+NoQ3dxvueF6tumD5pAdvoZv0RpCefM144rPIXuLHJe6xGQB3L
 PpoFPehOTTnND/hlbD8SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x027xyKDyEs=:MXiy1kaK3gZYVTRwxl/A9a
 0JdiUc2xEMbjg0WXo/t8kL74STo7mnNBCxgJCos4rd5p0DXbxghoF66+sMvn1bqnf/IBtzu0Y
 iJGOsGk+nmtyJ+Y0Sc+Ks0YnWFDFMh7sMTJ8WtYyngRq6+V0ATEGYnh0ZtyqFQmzvyBNFtOk1
 0n7JCHYYvDJJ++O+/nDg+69bKZagNbNgEnvn/6klDJGvwMe5OUnOEaCceFHW8U3XQBdSZuPVF
 5ON2otzKcPwb8xldyPQteUX2R4p7nx8O9+mG0Od4J2eOYrtJt10rVeLaEZh+LDhTosv0Gt0rW
 CJAL16c/vei5I1mfJir0sequfbRtTmT7fasgIOYAK29ZfBwZ5Wr8gTL7JqGaxBsImXDsnVmiV
 BrRz2okGo6U5WYh7L4uk+VhbE675iO/1RAca8RkpZa7Xb47H0bsGc70NMj7Df/0PCGdCTVwdg
 XklRIBuaDg4ZWeTGCmK7e9/ZS1a3LlXLFJjMRlsCOZMkuJj8V/EUZzAAGq+xj78NvQHyNQhhL
 FQKt673Nb53PWBubc+RD4HIfqNxozqyOeq39HlhVG8Lnpn0//PXkGENGhYXYaJbcDpf8ZyWJI
 Mn8iqA27Cv5tpHfjlCZtB2L1PyneWugVMsHCs5403wY2jqb1VvVIs2DQmc9rRkxkePWSImB/O
 imRRcqn+9C8G2pwEXDQ5v/+XGDbNE5oWsqOX+waaWtaAXH1uqjZqv0NtkG40dqDkFTu05o22y
 /tQptyjr6ZumXoPfFGMk9VZzAamcYC4je3Dx33IUQTOijh9qRVbYwsiqAVC9GFoPIfmivlFNO
 y3Krm85rQmmGNdHYTBErkCiQSZeDqC/p0iY5tL13RNho2nnjXg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 11 Oct 2018, Phillip Wood wrote:

> I think this would be a useful addition to rebase, there's one small
> comment below.
> 
> On 10/10/2018 09:53, Johannes Schindelin via GitGitGadget wrote:
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
> > This commit introduces that functionality, as the spanking new 'break'
> > command.
> > 
> > Suggested-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-rebase.txt | 3 +++
> >  rebase-interactive.c         | 1 +
> >  sequencer.c                  | 7 ++++++-
> >  t/lib-rebase.sh              | 2 +-
> >  t/t3418-rebase-continue.sh   | 9 +++++++++
> >  5 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index db2faca73c..5bed1da36b 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -561,6 +561,9 @@ By replacing the command "pick" with the command "edit", you can tell
> >  the files and/or the commit message, amend the commit, and continue
> >  rebasing.
> >  
> > +To interrupt the rebase (just like an "edit" command would do, but without
> > +cherry-picking any commit first), use the "break" command.
> > +
> >  If you just want to edit the commit message for a commit, replace the
> >  command "pick" with the command "reword".
> >  
> > diff --git a/rebase-interactive.c b/rebase-interactive.c
> > index 0f4119cbae..78f3263fc1 100644
> > --- a/rebase-interactive.c
> > +++ b/rebase-interactive.c
> > @@ -14,6 +14,7 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
> >  "s, squash <commit> = use commit, but meld into previous commit\n"
> >  "f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
> >  "x, exec <command> = run command (the rest of the line) using shell\n"
> > +"b, break = stop here (continue rebase later with 'git rebase --continue')\n"
> >  "d, drop <commit> = remove commit\n"
> >  "l, label <label> = label current HEAD with a name\n"
> >  "t, reset <label> = reset HEAD to a label\n"
> > diff --git a/sequencer.c b/sequencer.c
> > index 8dd6db5a01..b209f8af46 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1416,6 +1416,7 @@ enum todo_command {
> >  	TODO_SQUASH,
> >  	/* commands that do something else than handling a single commit */
> >  	TODO_EXEC,
> > +	TODO_BREAK,
> >  	TODO_LABEL,
> >  	TODO_RESET,
> >  	TODO_MERGE,
> > @@ -1437,6 +1438,7 @@ static struct {
> >  	{ 'f', "fixup" },
> >  	{ 's', "squash" },
> >  	{ 'x', "exec" },
> > +	{ 'b', "break" },
> >  	{ 'l', "label" },
> >  	{ 't', "reset" },
> >  	{ 'm', "merge" },
> > @@ -1964,7 +1966,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
> >  	padding = strspn(bol, " \t");
> >  	bol += padding;
> >  
> > -	if (item->command == TODO_NOOP) {
> > +	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
> >  		if (bol != eol)
> >  			return error(_("%s does not accept arguments: '%s'"),
> >  				     command_to_string(item->command), bol);
> > @@ -3293,6 +3295,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  			unlink(rebase_path_stopped_sha());
> >  			unlink(rebase_path_amend());
> >  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> > +
> > +			if (item->command == TODO_BREAK)
> > +				break;
> 
> Normally when rebase stops it prints a message to say where it has got
> to and how to continue, it might be useful to do the same here

That's a very valid point. I'll think of something.

Ciao,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> >  		}
> >  		if (item->command <= TODO_SQUASH) {
> >  			if (is_rebase_i(opts))
> > diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> > index 25a77ee5cb..584604ee63 100644
> > --- a/t/lib-rebase.sh
> > +++ b/t/lib-rebase.sh
> > @@ -49,7 +49,7 @@ set_fake_editor () {
> >  		case $line in
> >  		squash|fixup|edit|reword|drop)
> >  			action="$line";;
> > -		exec*)
> > +		exec*|break)
> >  			echo "$line" | sed 's/_/ /g' >> "$1";;
> >  		"#")
> >  			echo '# comment' >> "$1";;
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index c145dbac38..185a491089 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -239,5 +239,14 @@ test_rerere_autoupdate -m
> >  GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
> >  test_rerere_autoupdate -i
> >  test_rerere_autoupdate --preserve-merges
> > +unset GIT_SEQUENCE_EDITOR
> > +
> > +test_expect_success 'the todo command "break" works' '
> > +	rm -f execed &&
> > +	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
> > +	test_path_is_missing execed &&
> > +	git rebase --continue &&
> > +	test_path_is_file execed
> > +'
> >  
> >  test_done
> > 
> 
> 
