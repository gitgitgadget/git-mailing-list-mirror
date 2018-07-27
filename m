Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1E81F597
	for <e@80x24.org>; Fri, 27 Jul 2018 12:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeG0N7L (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 09:59:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:41393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbeG0N7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 09:59:11 -0400
Received: from [192.168.0.129] ([37.201.193.59]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVKy-1fRV6n1rQe-00HfjS; Fri, 27
 Jul 2018 14:37:13 +0200
Date:   Fri, 27 Jul 2018 14:37:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>
Subject: Re: [RFC PATCH] sequencer: fix quoting in write_author_script
In-Reply-To: <dae25f9d-5fde-a9c5-2178-9e06f3150885@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1807271415410.10478@tvgsbejvaqbjf.bet>
References: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net> <20180718155518.1025-1-phillip.wood@talktalk.net> <nycvar.QRO.7.76.6.1807261332130.71@tvgsbejvaqbjf.bet> <dae25f9d-5fde-a9c5-2178-9e06f3150885@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:quqYRT++5v8/ubDMXhVeKAs6a+Hqun6oqDwJ72byRSN2NoA8xWe
 N5jRmWz2/UIQLIcCiKsUrwLY6sPPgfix5iKzZQourVJvAkKGYrkIH9MSoSDGAVtcHdFI5Lc
 mc07NZjwpHCG82lXlOnEzipg8uQ9LYSHcT+1BlbAqTMCt4CyGsOxhOQv/Q0pU8+sflPHyAI
 1mcX8OVYxDr+6rmeekSHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JQpS3ipLnsQ=:A+/J3Izj7cQK5C49OdrGAc
 obpTfd8KkombUpZuwUmIoPhgIvnEKGc9qFr7yPOj9LZ3xusxzjITdTIadZJcw83qPU3Hh1VID
 bW3Do8iTTDLWaECUNU9yUKABrtsfSPv+HhtPIvyGPjrYT2SK/fzvIC2FcfIZ4YfmhTaGtZUuq
 ajlpvPKCwsNjV1rjvxuU0YXMzEk8MxpUAJHwzN4REoaZRJ/xTl3ENqoEbDjERvy6B8ceFUOSQ
 YMqCrOXYxRBwjlq41EdCEUR/xknixAnxz+bSPKrMY8ndgxKK4hQcCRnUgcvRG5NVDhGczi4oW
 rf99DnuM9rYBtBYj4GX9UyPRDx17o8+FRSQSEWIKnnFz6nfQG5ynwqjgxt8iDMI/mRG+MF0qR
 FNMf9UPRybk87u6bGTfoilEMjync0BYqgSbjQo6+5JwSu95idQK/7WAEsowhvt1E0dsXf0Dgx
 GCHP76MfYXKTyji8PO95WP+9A1ZRncc31hTkBUepdtluBdwLJ6Mm7aIhzZDqs5uzph79OM5/6
 gdopMCrIngfdA8RUIv+enc2/YTOlt3HUbBfPJVH75eixj41K3joBIWfdcYXLlVmMAXOZdEZI/
 FdNuiBlsIv5Kv/rYCDfumcb4adJRBav7MhxBpyr8kh0YFn6vXcDcMAR2lH3bUTZu3erBqw+L0
 JQpV3Ib8Gra/4gzbxMVSThai8g4vM/KyjqFvcMVYd8N7soI1rz9xYbenlXTtqkHhux8O327hB
 8LAORFzu5S1C9uKpzQClrm6XPP9uIif5s6wnr3w6jyGKbXId1fo6Wi7C9HECStfJm2tYGj+uY
 5vdjRP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip, Junio and Akinori,

I just noticed that t3404 is broken without my patches (but with Junio's
fixup), on Windows, macOS and Linux. (See log at the end.)

On Fri, 27 Jul 2018, Phillip Wood wrote:

> On 26/07/18 13:33, Johannes Schindelin wrote:
> > 
> > On Wed, 18 Jul 2018, Phillip Wood wrote:
> > 
> >> Single quotes should be escaped as \' not \\'. Note that this only
> >> affects authors that contain a single quote and then only external
> >> scripts that read the author script and users whose git is upgraded from
> >> the shell version of rebase -i while rebase was stopped. This is because
> >> the parsing in read_env_script() expected the broken version and for
> >> some reason sq_dequote() called by read_author_ident() seems to handle
> >> the broken quoting correctly.
> >>
> >> Ideally write_author_script() would be rewritten to use
> >> split_ident_line() and sq_quote_buf() but this commit just fixes the
> >> immediate bug.
> > 
> >> This is untested, unfortuantely I don't have really have time to write a test or
> >> follow this up at the moment, if someone else want to run with it then please
> >> do.
> > 
> > I modified the test that was added by Akinori. As it was added very early,
> > and as there is still a test case *after* Akinori's that compares a
> > hard-coded SHA-1, I refrained from using `test_commit` (which would change
> > that SHA-1). See below.
> 
> Thanks for adding a test, that sounds like sensible approach, however
> having thought about it I wonder if we should just be writing a plain
> text file (e.g rebase-merge/author-data) and fixing the reader to read
> that if it exists and only then fall back to reading the legacy
> rebase-merge/author-script with a fix to correctly handle the script
> written by the shell version - what do you think? The author-script
> really should be just an implementation detail. If anyone really wants
> to read it they can still do 'read -r l' and split the lines with
> ${l%%=*} and ${l#*=}

In contrast to `git am`, there *is* a use case where power users might
have come to rely on the presence of the .git/rebase-merge/author-script
file *and* its nature as a shell script snippet: we purposefully allow
scripting `rebase -i`.

So I don't think that we can declare the file and its format as
implementation detail, even if the idea is very, very tempting.

> >> diff --git a/sequencer.c b/sequencer.c
> >> index 5354d4d51e..0b78d1f100 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -638,21 +638,21 @@ static int write_author_script(const char *message)
> >>  		else if (*message != '\'')
> >>  			strbuf_addch(&buf, *(message++));
> >>  		else
> >> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> >> +			strbuf_addf(&buf, "'\\%c'", *(message++));
> >>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
> >>  	while (*message && *message != '\n' && *message != '\r')
> >>  		if (skip_prefix(message, "> ", &message))
> >>  			break;
> >>  		else if (*message != '\'')
> >>  			strbuf_addch(&buf, *(message++));
> >>  		else
> >> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> >> +			strbuf_addf(&buf, "'\\%c'", *(message++));
> >>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
> >>  	while (*message && *message != '\n' && *message != '\r')
> >>  		if (*message != '\'')
> >>  			strbuf_addch(&buf, *(message++));
> >>  		else
> >> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> >> +			strbuf_addf(&buf, "'\\%c'", *(message++));
> >>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
> > 
> > I resolved the merge conflict with Akinori's patch. FWIW I pushed all of
> > this, including the fixup to Junio's fixup to the
> > `fix-t3404-author-script-test` branch at https://github.com/dscho/git.
> > 
> >>  	strbuf_release(&buf);
> >>  	return res;
> >> @@ -666,13 +666,21 @@ static int read_env_script(struct argv_array *env)
> >>  {
> >>  	struct strbuf script = STRBUF_INIT;
> >>  	int i, count = 0;
> >> -	char *p, *p2;
> >> +	const char *p2;
> >> +	char *p;
> >>  
> >>  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> >>  		return -1;
> >>  
> >>  	for (p = script.buf; *p; p++)
> >> -		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> >> +		/*
> >> +		 * write_author_script() used to escape "'" incorrectly as
> >> +		 * "'\\\\''" rather than "'\\''" so we check for the correct
> >> +		 * version the incorrect version in case git was upgraded while
> >> +		 * rebase was stopped.
> >> +		 */
> >> +		if (skip_prefix(p, "'\\''", &p2) ||
> >> +		    skip_prefix(p, "'\\\\''", &p2))
> > 
> > I think in this form, it is possibly unsafe because it assumes that the
> > new code cannot generate output that would trigger that same code path.
> > Although I have to admit that I did not give this a great deal of thought.
> 
> Hm, I not sure that it can. If the Author begins \\' then this will be
> written as the C string "'\\\\'\\''...". If \\' comes at the end then I
> think this will be written as "\\\\'\\'''", in the middle of the name it
> will be "\\\\'\\''..."

Yes, that matches my gut feeling... but...

> > In any case, if you have to think long and hard about some fix, it might
> > be better to go with something that is easier to reason about. So how
> > about this: we already know that the code is buggy, Akinori fixed the bug,
> > where the author-script missed its trailing single-quote. We can use this
> > as a tell-tale for *this* bug. Assuming that Junio will advance both your
> > and Akinori's fix in close proximity.
> 
> That sounds like a good approach

I am glad that you agree to this.

I am a big fan of this age-old wisdom
that goes somewhat like this: some code is so simple that there is no
space for obvious bugs, and some code is so complicated that there is no
space for obvious bugs. In this context, I would use the modified
version: some code is so easy to reason about that there is no obvious
flaw, and some other code is so difficult to reason about that there is
no obvious flaw.

Besides, using the sq_bug version can serve as a reminder to "pay down
the technical debt" in the future.

> > Again, this is pushed to the `fix-t3404-author-script-test` branch at
> > https://github.com/dscho/git; My fixup on top of your patch looks like
> > this (feel free to drop the sq_bug part and only keep the test part):
> > 
> > -- snipsnap --
> > diff --git a/sequencer.c b/sequencer.c
> > index 46c0b3e720f..7abe78dc78e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -573,13 +573,14 @@ static int write_author_script(const char *message)
> >  static int read_env_script(struct argv_array *env)
> >  {
> >  	struct strbuf script = STRBUF_INIT;
> > -	int i, count = 0;
> > +	int i, count = 0, sq_bug;
> >  	const char *p2;
> >  	char *p;
> >  
> >  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> >  		return -1;
> >  
> > +	sq_bug = script.len && script.buf[script.len - 1] != '\'';
> >  	for (p = script.buf; *p; p++)
> >  		/*
> >  		 * write_author_script() used to escape "'" incorrectly as
> > @@ -587,8 +588,9 @@ static int read_env_script(struct argv_array *env)
> >  		 * version the incorrect version in case git was upgraded while
> >  		 * rebase was stopped.
> >  		 */
> 
> We probably want the change the comment slightly to explain sq_bug

True. Can you give it a shot? If not, I will try to remember some time mid
next week.

Here the promised log of t3404 with -i -v -x (on macOS, but Linux and
Windows shows equivalent failures, and the way I read it, the problem is
simply that the test was introduced in the middle of t3404 and
subsequent test cases' assumptions are no longer met):

-- snipsnap --
2018-07-27T11:53:04.2450890Z ok 2 - rebase --keep-empty
2018-07-27T11:53:04.2464690Z 
2018-07-27T11:53:04.2489730Z expecting success: 
2018-07-27T11:53:04.2513840Z 	test_when_finished "git rebase --abort ||:" &&
2018-07-27T11:53:04.2536980Z 	git checkout master &&
2018-07-27T11:53:04.2563050Z 	set_fake_editor &&
2018-07-27T11:53:04.2590300Z 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
2018-07-27T11:53:04.2614900Z 	test -f .git/rebase-merge/author-script &&
2018-07-27T11:53:04.2639740Z 	(
2018-07-27T11:53:04.2665320Z 		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
2018-07-27T11:53:04.2688410Z 		eval "$(cat .git/rebase-merge/author-script)" &&
2018-07-27T11:53:04.2710930Z 		test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
2018-07-27T11:53:04.2734740Z 		test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
2018-07-27T11:53:04.2756700Z 		test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
2018-07-27T11:53:04.2778060Z 	)
2018-07-27T11:53:04.2788910Z 
2018-07-27T11:53:04.2810410Z ++ test_when_finished 'git rebase --abort ||:'
2018-07-27T11:53:04.2831430Z ++ test 0 = 0
2018-07-27T11:53:04.2852830Z ++ test_cleanup='{ git rebase --abort ||:
2018-07-27T11:53:04.2874430Z 		} && (exit "$eval_ret"); eval_ret=$?; :'
2018-07-27T11:53:04.2892720Z ++ git checkout master
2018-07-27T11:53:04.2911560Z Switched to branch 'master'
2018-07-27T11:53:04.2929490Z ++ set_fake_editor
2018-07-27T11:53:04.2947690Z ++ write_script fake-editor.sh
2018-07-27T11:53:04.2966040Z ++ echo '#!/bin/sh'
2018-07-27T11:53:04.2983780Z ++ cat
2018-07-27T11:53:04.3001950Z ++ chmod +x fake-editor.sh
2018-07-27T11:53:04.3019770Z +++ pwd
2018-07-27T11:53:04.3038530Z ++ test_set_editor '/Users/vsts/agent/2.138.3/work/1/s/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
2018-07-27T11:53:04.3057950Z ++ FAKE_EDITOR='/Users/vsts/agent/2.138.3/work/1/s/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
2018-07-27T11:53:04.3076510Z ++ export FAKE_EDITOR
2018-07-27T11:53:04.3094750Z ++ EDITOR='"$FAKE_EDITOR"'
2018-07-27T11:53:04.3112610Z ++ export EDITOR
2018-07-27T11:53:04.3130670Z ++ FAKE_LINES='edit 1'
2018-07-27T11:53:04.3153990Z ++ git rebase -i 'HEAD^'
2018-07-27T11:53:04.4674460Z rebase -i script before editing:
2018-07-27T11:53:04.4698420Z pick 8f99a4f E
2018-07-27T11:53:04.4710290Z 
2018-07-27T11:53:04.4792780Z rebase -i script after editing:
2018-07-27T11:53:04.4817630Z edit 8f99a4f E
2018-07-27T11:53:04.5025190Z Rebasing (1/1)
2018-07-27T11:53:04.5046400Z Stopped at 8f99a4f...  E
2018-07-27T11:53:04.5065680Z You can amend the commit now, with
2018-07-27T11:53:04.5074810Z 
2018-07-27T11:53:04.5092850Z   git commit --amend 
2018-07-27T11:53:04.5101800Z 
2018-07-27T11:53:04.5119900Z Once you are satisfied with your changes, run
2018-07-27T11:53:04.5129030Z 
2018-07-27T11:53:04.5147390Z   git rebase --continue
2018-07-27T11:53:04.5165610Z ++ test -f .git/rebase-merge/author-script
2018-07-27T11:53:04.5183820Z ++ sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
2018-07-27T11:53:04.5201610Z ++ unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
2018-07-27T11:53:04.5220730Z ++ return 0
2018-07-27T11:53:04.5244590Z +++ cat .git/rebase-merge/author-script
2018-07-27T11:53:04.5269130Z ++ eval 'GIT_AUTHOR_NAME='\''A U Thor'\''
2018-07-27T11:53:04.5294440Z GIT_AUTHOR_EMAIL='\''author@example.com'\''
2018-07-27T11:53:04.5319550Z GIT_AUTHOR_DATE='\''@1112912233 -0700'\'''
2018-07-27T11:53:04.5345580Z +++ GIT_AUTHOR_NAME='A U Thor'
2018-07-27T11:53:04.5365960Z +++ GIT_AUTHOR_EMAIL=author@example.com
2018-07-27T11:53:04.5384150Z +++ GIT_AUTHOR_DATE='@1112912233 -0700'
2018-07-27T11:53:04.5402250Z +++ git show --quiet --pretty=format:%an
2018-07-27T11:53:04.5420400Z ++ test 'A U Thor' = 'A U Thor'
2018-07-27T11:53:04.5438410Z +++ git show --quiet --pretty=format:%ae
2018-07-27T11:53:04.5459570Z ++ test author@example.com = author@example.com
2018-07-27T11:53:04.5477950Z +++ git show --quiet --date=raw --pretty=format:@%ad
2018-07-27T11:53:04.5496180Z ++ test '@1112912233 -0700' = '@1112912233 -0700'
2018-07-27T11:53:04.5514390Z ++ git rebase --abort
2018-07-27T11:53:04.6924920Z ++ exit 0
2018-07-27T11:53:04.6950890Z ++ eval_ret=0
2018-07-27T11:53:04.6973900Z ++ :
2018-07-27T11:53:04.6998480Z ok 3 - rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse
2018-07-27T11:53:04.7009400Z 
2018-07-27T11:53:04.7030290Z expecting success: 
2018-07-27T11:53:04.7050880Z 	set_fake_editor &&
2018-07-27T11:53:04.7072520Z 	test_must_fail env FAKE_LINES="1 exec_true" git rebase -i HEAD^ >actual 2>&1 &&
2018-07-27T11:53:04.7092910Z 	test_i18ncmp expect actual
2018-07-27T11:53:04.7102960Z 
2018-07-27T11:53:04.7123150Z ++ set_fake_editor
2018-07-27T11:53:04.7144080Z ++ write_script fake-editor.sh
2018-07-27T11:53:04.7164970Z ++ echo '#!/bin/sh'
2018-07-27T11:53:04.7185360Z ++ cat
2018-07-27T11:53:04.7212950Z ++ chmod +x fake-editor.sh
2018-07-27T11:53:04.7236720Z +++ pwd
2018-07-27T11:53:04.7263500Z ++ test_set_editor '/Users/vsts/agent/2.138.3/work/1/s/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
2018-07-27T11:53:04.7291390Z ++ FAKE_EDITOR='/Users/vsts/agent/2.138.3/work/1/s/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
2018-07-27T11:53:04.7314090Z ++ export FAKE_EDITOR
2018-07-27T11:53:04.7338290Z ++ EDITOR='"$FAKE_EDITOR"'
2018-07-27T11:53:04.7362710Z ++ export EDITOR
2018-07-27T11:53:04.7386370Z ++ test_must_fail env 'FAKE_LINES=1 exec_true' git rebase -i 'HEAD^'
2018-07-27T11:53:04.7412410Z ++ case "$1" in
2018-07-27T11:53:04.7436170Z ++ _test_ok=
2018-07-27T11:53:04.7455340Z ++ env 'FAKE_LINES=1 exec_true' git rebase -i 'HEAD^'
2018-07-27T11:53:04.9560670Z ++ exit_code=0
2018-07-27T11:53:04.9581700Z ++ test 0 -eq 0
2018-07-27T11:53:04.9603200Z ++ list_contains '' success
2018-07-27T11:53:04.9628730Z ++ case ",$1," in
2018-07-27T11:53:04.9652120Z ++ return 1
2018-07-27T11:53:04.9677740Z ++ echo 'test_must_fail: command succeeded: env FAKE_LINES=1 exec_true git rebase -i HEAD^'
2018-07-27T11:53:04.9704590Z test_must_fail: command succeeded: env FAKE_LINES=1 exec_true git rebase -i HEAD^
2018-07-27T11:53:04.9730750Z ++ return 1
2018-07-27T11:53:04.9754580Z error: last command exited with $?=1
2018-07-27T11:53:04.9779100Z not ok 4 - rebase -i with empty HEAD
2018-07-27T11:53:04.9802670Z #	
2018-07-27T11:53:04.9826330Z #		set_fake_editor &&
2018-07-27T11:53:04.9851320Z #		test_must_fail env FAKE_LINES="1 exec_true" git rebase -i HEAD^ >actual 2>&1 &&
2018-07-27T11:53:04.9875680Z #		test_i18ncmp expect actual
2018-07-27T11:53:04.9899170Z #	
2018-07-27T11:53:04.9923310Z make[1]: *** [t3404-rebase-interactive.sh] Error 1
