Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6E2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 09:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeHFL7R (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 07:59:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:35975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeHFL7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 07:59:17 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVeCF-1fQQIV1LPb-00Ywg8; Mon, 06
 Aug 2018 11:50:52 +0200
Date:   Mon, 6 Aug 2018 11:50:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
In-Reply-To: <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808061136180.71@tvgsbejvaqbjf.bet>
References: <pull.13.git.gitgitgadget@gmail.com> <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com> <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YLcO8chQtxLTbWPBsHNw6AWX2O/KXVURB/gN3UdbLRELnV/e5PQ
 0EteB3zd3uBTBy6JhzZ8i3BkEzCWHmx1P1R/LPJ2oGIP8mHwOh4D9JwB0Cj3GR8JqPedwOv
 PzRpJTo9SNuSp7k0AJueYlve8J22r32/EtjnqXpK6Jwx0hWyIyzAYc55Q7AcN5Y2Ei4FJZY
 oYpYfSf1eZivnV5SVrvgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xoauaFlHoo0=:CK4cJWQt0vtgMKlnLznii4
 EprEyTrIMK+Dx9QABjB3nTcX7cWP+lNn/MmNTiI9YW5AM3SasQljfRqJiylwQqRZA0kk2HO2e
 na8cbqjtnM8xUmjTGPh63d1fOkdkzsT9dtXPvarmaPTYFunBteu22oyWdFbqr173FL1rqY50X
 Nqgx64r1IZIZH+5kq//QZ+8jI6nX1Bdv3PVWmaITuXCwEyHffCP3LgNX3rMj/V/Ku2zwwuiGi
 ewqgfgmVjNpury7ZTGi3ULpptUlS4jXjc/57MhfHFSkORAOgLci3RbCeMPpoCZuiPH86Z2LsR
 XAKH+I4MAkT4HO1czJOUOqNcxzqMgTVUZSQ2v66U2HiZLBuhRO6Z2f8Yjm5PLooCeebCZKK74
 I883/d8LiE7SWbBPSLCuU3SFq5cT/EB8y99svswj4Zc345xU/7ihVIk9jRvwI6evPv+C8eEr+
 Wpum/jnHw0NstGONf4dJV+DCprefbHTn8AmtCT2G6T/hSkWihnth8pQ6PTjTTL310alVFoS6t
 D1mN75O6aLoJ8gjo6oXg3o2Asmbw0xBdkBYpmu4a+sgnUxhpASUIzIa8kdA080W4kb+T0mv5F
 IrXUaOg2HIelx+timhszFVc/ffPJ+CBuI1P32clhKG/fVa5eas/32knLTwrdL9PfBZ1A9fuHP
 BPXsA27ddsZRM+kss0y8r1ppEQq6SW5xbmdSoXK7zL6nJdz6ibhHrsqIoxJnVU26DT7RMALX5
 eq3Qux73pf2QARJsiUtHexEwjWKF5YlUP2my2C9oFZUme4ueAi/dxJWyUb32ao8sBeQJvGCUo
 p0YKSuWG4OHozTxxEGPh9B4oJBJ7sEn8jWvKlw6XXbFf1YWddXzmrC9s7J58N1sZFUgK92ZMd
 t6V9wDPHBIKjEdbQOds6UcimBijRETR0nrz/0ll5CyJour0WZv8viKte/OstlEZIzEAiGlGdA
 UE/QojmJRu0f5c3AAuMyMJCRPJ/iRQBA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 31038472f..dda5cdbba 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4244,10 +4244,9 @@ int sequencer_add_exec_commands(const char *commands)
> >  {
> >  	const char *todo_file = rebase_path_todo();
> >  	struct todo_list todo_list = TODO_LIST_INIT;
> > -	struct todo_item *item;
> >  	struct strbuf *buf = &todo_list.buf;
> >  	size_t offset = 0, commands_len = strlen(commands);
> > -	int i, first;
> > +	int i, insert_final_commands;
> >  
> >  	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> >  		return error(_("could not read '%s'."), todo_file);
> > @@ -4257,19 +4256,57 @@ int sequencer_add_exec_commands(const char *commands)
> >  		return error(_("unusable todo list: '%s'"), todo_file);
> >  	}
> >  
> > -	first = 1;
> > -	/* insert <commands> before every pick except the first one */
> > -	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
> > -		if (item->command == TODO_PICK && !first) {
> > -			strbuf_insert(buf, item->offset_in_buf + offset,
> > -				      commands, commands_len);
> > -			offset += commands_len;
> > +	/*
> > +	 * Insert <commands> after every pick. Here, fixup/squash chains
> > +	 * are considered part of the pick, so we insert the commands *after*
> > +	 * those chains if there are any.
> > +	 */
> 
> This is a tangent, but can a merge be amended with fixup/squash?  I
> am hoping that I can use this machinery to augment Meta/Reintegrate
> logic someday, and amending merges to resolve semantic conflicts
> between topiocs in flight is what needs to happen constantly.
> 
> It appears the code treats TODO_PICK and TODO_MERGE the same way, so
> the answer to the question apparently is "yes", which is good.

When I rewrote `rearrange_squash()` in C, I tried to be the kind of clever
that anticipates future features and accommodates for them:

		if (!item->commit || item->command == TODO_DROP) {
			subjects[i] = NULL;
			continue;
		}

This is the snippet of code that will skip entries in the todo list from
being eligible to be fixed up. As you can see, the code is not 100%
future-proof: if somebody wants to introduce another command like `drop`
(i.e. a command that takes a commit as parameter, but does not create a
commit), the clause will have to be extended.

Technically, I could have changed the logic in `add_exec_commands()` to
use the same heuristic. But that would change the behavior, and this patch
series is about fixing a bug, not about changing behavior.

> "after every pick" needs to become "after every pick and merge", or
> if you prefer "after creating every new commit (i.e. pick and merge)".
> 
> > +	insert_final_commands = 1;
> 
> We assume, before entering the loop, that we'd need to append
> another exec at the end.

Right. This is what the current code does, and I am not willing to change
that in this bug fix.

(This smells like the exact suggestions I was too happy in the past to
consider, causing regressions like that vexing one where the rock solid,
battle tested hideDotGit support was broken as a consequence of the code
review on this list. It is totally my fault, I should learn from such
experiences and be very wary of potentially-breaking suggestions.)

> > +	for (i = 0; i < todo_list.nr; ) {
> > +		enum todo_command command = todo_list.items[i].command;
> > +		int j = 0;
> > +
> > +		if (command != TODO_PICK && command != TODO_MERGE) {
> > +			i++;
> > +			continue;
> 
> If we ever see a todo-list without any pick/merge, then insert_final
> is still 1 when we leave the loop and we will add one single exec at
> the end.  Which may or may not make sense---I dunno, as I do not
> offhand think of a reason why the user would give us such a sequence
> in the first place, so it probably may not matter in practice.

Think of the `noop` command. It was introduced specifically to allow
rebasing patches interactively to an upstream that already applied the
local patches. In that case, an `--exec` should still run at least once,
to avoid negative surprises.

> > +		}
> > +
> > +		/* skip fixup/squash chain, if any */
> > +		for (i++; i < todo_list.nr; i++, j = 0) {
> > +			command = todo_list.items[i].command;
> > +
> > +			if (is_fixup(command))
> > +				continue;
> > +
> > +			if (command != TODO_COMMENT)
> > +				break;
> > +
> > +			/* skip comment if followed by any fixup/squash */
> > +			for (j = i + 1; j < todo_list.nr; j++)
> > +				if (todo_list.items[j].command != TODO_COMMENT)
> > +					break;
> > +			if (j < todo_list.nr &&
> > +			    is_fixup(todo_list.items[j].command)) {
> > +				i = j;
> > +				continue;
> > +			}
> > +			break;
> >  		}
> > -		first = 0;
> > +
> > +		if (i >= todo_list.nr) {
> > +			insert_final_commands = 1;
> > +			break;
> 
> We saw pick or merge and then skipped zero or more fixups.  If we
> reached the end, then we need to append one more to run the command
> after this last group.  Makes sense.
> 
> > +		}
> > +
> > +		strbuf_insert(buf, todo_list.items[i].offset_in_buf + offset,
> > +			      commands, commands_len);
> > +		offset += commands_len;
> > +		insert_final_commands = 0;
> 
> Otherwise, we finished a group so we insert an exec and move on,
> after saying that we do not need one more, unless we see pick/merge
> 
> >  	}
> >  
> >  	/* append final <commands> */
> > -	strbuf_add(buf, commands, commands_len);
> > +	if (insert_final_commands)
> > +		strbuf_add(buf, commands, commands_len);
> 
> When we leave the loop without adding exec to a group we saw, we
> want to add one more exec, which is done here.
> 
> I am not exectly sure if the above loop is what you really want,
> though.  I would have found the flow of the logic simpler to follow
> if the loop were structured like this:
> 
> 	append_exec = false
> 	for each command:
> 		if append_exec:
> 			add command to execute after the previous block
> 			append_exec = false
> 		if command is neither pick or merge:
> 			continue
> 		skip fixup or squash
> 		# at this point we know we are at the end
> 		append_exec = true
> 	if append_exec:
> 		add command to execute after the last block

ETOOMUCHPYTHON

> essentially, the loop uses the flag not to keep track of the need to
> emit only the final command, but the need to emit a command before
> processing any command in the event stream (or the end of stream).
> 
> The above assumes that we do not want any exec if there is no
> pick/merge, though.  As I said already, I am assuming that it does
> not matter either way in practice, but if it mattered, I'd find it
> more natural not to run any command if we did not create any commit.

My original reasoning for not doing it that way was to keep the final
commands even in the case that there is no pick.

And that is a hard requirement: it would possibly cause regressions, and I
do not have the time to take care of regressions caused by review these
days.

Another thing your suggestion completely misses is that I went out of my
way to treat comments in the way that "pick, fixup, comment, pick" would
see the "exec" inserted *before* the comment, i.e. comments at the end of
fixup/squash chains would not be considered part of the chain.

But your comments made me look at it again, and I think your idea can be
salvaged. We just have to use an index instead of a Boolean, and extend
the index upon seeing a fixup, and delaying the decision if we see a
comment.

I asked GitGitGadget to submit the second iteration of this patch series.

Ciao,
Dscho
