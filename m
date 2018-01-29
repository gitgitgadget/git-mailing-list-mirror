Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69891F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeA2WP5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:15:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:50156 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeA2WP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:15:56 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lzsf1-1esbq84Bn9-014xTn; Mon, 29 Jan 2018 23:15:52 +0100
Date:   Mon, 29 Jan 2018 23:15:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
In-Reply-To: <xmqqpo61lezj.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292306510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de> <xmqqpo61lezj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HntHDHzlscRKeRenaZhK4+eHxR3nHuNXisVcGMYAzw4SoHR5GP+
 hZnolfX76vFI+E2cObAH0qQDJDRftN272agxS1zE4rtm1OyeNxeUldxMKTegoZ3tKAIY14E
 r9uK+jgSyYXAh9Hbgg8KS104+jT1OLzimbxeTjNDIy+YwsMTEfZkj1eN2Gtuo7BDh1XG/Ak
 MK9cMeSbQkg3Bwag9iOkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:msZ1A9xfrPA=:abkv/eecaVsgk2AwB2HIs6
 SrKB5ie9geC9FXSv7kp10uCuWlrPRxPI3v7pkFBoTHWFqJlZ31LOr90ZneHzA4QNPLkGUZVsQ
 QKF36uh4m0wEGGxYNEEQWZ/rrzWjNJ43JIzMta2sg+2MHRQEW+kgRyowkDPYkA0lDpSdZ/eQH
 dlQuvfiOVQTEbLFpjOL8GzvX6etncfzM+VcQKtRzX52OT2E2UmTdr6JRkQq2TBhwqJMmVthxe
 bdIHIHBdxC0QjcDXzQjLvjJqusHB5hsfVzeGquBUsLka1z6g5sNu/nPTSn3q7G/MkQy0KLpUb
 z6aIFAC8SLaibas2D1vekhERB/wdzZpqePl1VWOUC5xUBIl2ipR5qd3/Ge6Y7MzHOfbxhTvMU
 Ggh5nXG4OQjPaKc2foHcTL82q/eahy5JrwnukkXLY7MZmAPe6lHcJ0+v9nqK1FNiSpU8A6mG3
 bNO7Opwyhd7rDNgQRUSfH1njx9rCg3w8W8MrYfNlThep8IPIk24Pn/5+oB040M+bm54vf/nC8
 ITiUMLdIyYNQ6OLGUHJcTPw4mahatwhnfi/mkQrZ1D0NfYM9C5zq6GYd/Wl+KDmNAfVybc5cP
 HgDsDECuxUj2vURlEIM0fHGSXqOJal4imSl5LHlLYcpnVqxTr4eunzBOsaslxecg5xVwXJIek
 BB81/unPLvAAIg16E1/3LMfi4KTcrgDdiAfiqz/Cuw36W5BoSSclUzx9euXPhN+u8zr1EMLKH
 x3zVNwvMB+g2FLWGb7mM2ymbY3g71Rzy5+cFYQ658vbzxqA3bf/15jR47FzvkC9zZWICESrJB
 DmVYOKQu/dgZi66x0V52hnkwt3+Daf7EM+VXdXo5aDI5spwPAo18oMR8Lec7tnS1ZTyGLl2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
> > +	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> > +	item->arg_len = (int)(eol - item->arg);
> > +
> >  	saved = *end_of_object_name;
> > +	if (item->command == TODO_MERGE && *bol == '-' &&
> > +	    bol + 1 == end_of_object_name) {
> > +		item->commit = NULL;
> > +		return 0;
> > +	}
> > +
> >  	*end_of_object_name = '\0';
> >  	status = get_oid(bol, &commit_oid);
> >  	*end_of_object_name = saved;
> >  
> > -	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> > -	item->arg_len = (int)(eol - item->arg);
> > -
> 
> Assigning to "saved" before the added "if we are doing merge and see
> '-', do this special thing" is not only unnecessary, but makes the
> logic in the non-special case harder to read.  The four things
> "saved = *eol; *eol = 0; do_thing_using(bol); *eol = saved;" is a
> single logical unit; keep them together.

True. This was a sloppily resolved merge conflict in one of the many
rewrites, I guess.

> > +		if (*p)
> > +			len = strlen(p);
> > +		else {
> > +			strbuf_addf(&buf, "Merge branch '%.*s'",
> > +				    merge_arg_len, arg);
> > +			p = buf.buf;
> > +			len = buf.len;
> > +		}
> 
> So... "arg" received by this function can be a single non-whitespace
> token, which is taken as the name of the branch being merged (in
> this else clause).  Or it can also be followed by a single liner
> message for the merge commit.  Presumably, this is for creating a
> new merge (i.e. "commit==NULL" case), and preparing a proper log
> message in the todo list is unrealistic, so this would be a
> reasonable compromise.  Those users who want to write proper log
> message could presumably follow such "merge" insn with a "x git
> commit --amend" or something, I presume, if they really wanted to.

Precisely.

> > +		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
> > +			error_errno(_("Could not write '%s'"),
> > +				    git_path_merge_msg());
> > +			strbuf_release(&buf);
> > +			rollback_lock_file(&lock);
> > +			return -1;
> > +		}
> > +		strbuf_release(&buf);
> > +	}
> 
> OK.  Now we have prepared the MERGE_MSG file and are ready to commit.
> 
> > +	head_commit = lookup_commit_reference_by_name("HEAD");
> > +	if (!head_commit) {
> > +		rollback_lock_file(&lock);
> > +		return error(_("Cannot merge without a current revision"));
> > +	}
> 
> Hmph, I would have expected to see this a lot earlier, before
> dealing with the log message.  Leftover MERGE_MSG file after an
> error will cause unexpected fallout to the end-user experience
> (including what is shown by the shell prompt scripts), but if we do
> this before the MERGE_MSG thing, we do not have to worry about
> error codepath having to remove it.

Fixed.

> > +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
> > +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> > +	if (!merge_commit) {
> > +		/* fall back to non-rewritten ref or commit */
> > +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
> > +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> > +	}
> 
> OK, so "abc" in the example in the log message is looked up first as
> a label and then we take a fallback to interpret as an object name.

Yes. And auto-generated labels are guaranteed not to be full hex hashes
for that reason.

> Hopefully allowed names in "label" would be documented clearly in
> later steps (I am guessing that "a name that can be used as a branch
> name can be used as a label name and vice versa" or something like
> that).

Well, I thought that it would suffice to say that these labels are
available as refs/rewritten/<label>. It kind of goes without saying that
those need to be valid ref names, then?

> > +	if (!merge_commit) {
> > +		error(_("could not resolve '%s'"), ref_name.buf);
> > +		strbuf_release(&ref_name);
> > +		rollback_lock_file(&lock);
> > +		return -1;
> > +	}
> > +	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
> > +		      git_path_merge_head(), 0);
> > +	write_message("no-ff", 5, git_path_merge_mode(), 0);
> 
> These two calls gave me a "Huh?" moment; write_message() sounds like
> it is allowed to be later updated with frills suitable for *_MSG
> files we place in .git/ directory (iow, it is in principle OK if
> commented out instructions common to these files are added to the
> output by the function), but these want exact bytes passed in the
> result, for which wrapper.c::write_file() is more appropriate.

I agree that write_message() is not a good name, but write_file() was
already taken. I do not think wrapper.c:write_file() is more appropriate,
as it has *also* misnamed: it *always completes the line*. In other words,
it is not write_file(), it is write_line_to_file(). And not even that, as
it takes a printf()-type format.

No, write_message(), even if not named appropriately, is the functionality
I want.

> Alternatively, perhaps write_message() can be dropped and its
> callers can call wrapper.c::write_file() instead?  Such a clean-up
> may require teaching the append-eol thing that write_message() wants
> to wrapper.c::write_file(), but it shouldn't be a rocket science.

write_file() does different things than write_message(). I think this
suggestion to congeal them into one is quite overzealous.

And would also lead us astray.

> > +	common = get_merge_bases(head_commit, merge_commit);
> > +	for (j = common; j; j = j->next)
> > +		commit_list_insert(j->item, &reversed);
> > +	free_commit_list(common);
> 
> I know this is copy&pasted code from "builtin/merge.c", but is there
> a reason to reverse the common ancestor list here?

Yes. You explained the reason yourself: this is `git merge`'s behavior. To
recreate it in the sequencer, the list of common ancestors has to be
reversed here, too.

Ciao,
Dscho
