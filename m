From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 18:19:43 -0600
Message-ID: <47BF669F.4070803@nrlssc.navy.mil>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <7v8x1fymei.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802211024200.17164@racer.site> <47BF18DF.6050100@nrlssc.navy.mil> <7vhcg07hmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSi8m-0005j6-FF
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbYBWAU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760902AbYBWAUZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:20:25 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41070 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764556AbYBWAUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:20:22 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1N0JhVl032308;
	Fri, 22 Feb 2008 18:19:44 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 18:19:43 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vhcg07hmd.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Feb 2008 00:19:43.0077 (UTC) FILETIME=[C986B950:01C875B1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--15.554400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDQyNTctNzA1MTc4LTcwMDE5NC03?=
	=?us-ascii?B?MDk1ODQtNzAxMjk4LTcwMzQ5MS03MDc0NTEtNzAyNTY4LTcwNTg2?=
	=?us-ascii?B?MS0xMTMyMzAtNzA2NjQ5LTcwMjAyMC0xODcwNjctNzA1MTAyLTcw?=
	=?us-ascii?B?MjkyMC03MDA5OTQtNzA1MDYxLTcwMzI4My03MDU5MDEtMTA1MDQw?=
	=?us-ascii?B?LTcwMTQ1NS03MDI3MjYtNzA0NjkyLTEyMTYyNC0xMDUyNTAtNzAy?=
	=?us-ascii?B?NzM3LTcwMzc4OC03MDU5NzQtNzAwOTcxLTcwMjYzNi03MDI2MDkt?=
	=?us-ascii?B?NzAzNzEyLTcwMDcyNi0xMDY0MjAtNzA0NDIxLTcwNzc1MC03MDU5?=
	=?us-ascii?B?NjktNzAyMDQ0LTcwNzgwMC03MDAxNjMtMTA2NDcwLTcwOTE4NS03?=
	=?us-ascii?B?MDgxNzktNzAyMzU4LTE0ODAzOS0xNDgwNTAtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74769>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Wed, 20 Feb 2008, Junio C Hamano wrote:
>>>> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>>>>  + builtin-reflog.c: fix typo that accesses an unset variable
>>>>  + Teach "git reflog" a subcommand to delete single entries
>>>>
>>>> There was a patch that uses this to implement "git-stash drop",
>>>> which I didn't queue, as the command name and the UI was
>>>> undecided yet.  Dscho was in favor of "pop" without "drop".
>>> Maybe it is time to "drop" this topic?
>> The issue with drop or pop (for me) was that deleting a reflog
>> entry was causing error messages to be printed.
> 
> I agree with your analysis, and I am tempted to suggest just the
> simplest option.
> 
> The thing is, unless it is a reflog used to implement stash,
> removing an entry in the middle and adjusting an entry before
> and after it, just to fool and squelch the consistency mechanism
> we explicitly have for safety, feels quite wrong.  Especially
> given that the whole point of the reflog is to allow you to
> recover your branch to a particular point in time safely.

Just to clarify, only the entry _after_ has to be adjusted.

If the primary reason for the old sha1 field is to be able to check
the reflog for consistency, then maybe it makes sense to adjust this
field. It's not used when resetting to a particular reflog entry is it?

We do lose something. The reflog entry conveys a transition _from_
a state _to_ a state. If the reflog entry is adjusted, the _from_
state is modified. But I think you would have to manually read the
reflog file to see this information right? The fact that this
information is lost is why I didn't feel comfortable adjusting the
reflog entries by default. In the case of stash, this information
is uninteresting.

> So I'd rather see us remove "reflog delete" and add "reflog pop"
> which resets the ref itself to the previous point and deletes
> the last reflog entry.  Then "stash pop" would become simply
> "stash apply" followed by "reflog pop".

The patch series I sent would allow this with

    git reflog delete --updateref stash@{0}

I don't think that satisfies the requests though. People wanted to
be able to delete any entries in the stash list.

Is any of this currently useful outside of stash? I don't know
enough to know why someone would want to modify the ref without
resetting at least the index and that is what git-reset is for.
Also, outside of stash, I don't know why someone would want to
delete individual reflog entries.

> We might need to introduce "stash push" which would be a synonym
> for "stash pop" for symmetry.

I like "stash push" if you mean _antonym_ and not _synonym_.

"stash pop" and "stash push" would be antonyms (opposite meaning).
"stash push" and "stash save" would be synonyms (same meaning).

>  Also we may want to introduce a stash per branch if we do this.

This isn't necessary for how I use stash.

-brandon
