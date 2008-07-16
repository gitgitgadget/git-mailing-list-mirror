From: david@lang.hm
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 14:16:07 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0807161414590.17859@asgard.lang.hm>
References: <alpine.DEB.1.00.0807161804400.8950@racer>  <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>  <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEMl-00072D-O4
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbYGPVPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754979AbYGPVPx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:15:53 -0400
Received: from mail.lang.hm ([64.81.33.126]:54589 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187AbYGPVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:15:52 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m6GLEtUB027167;
	Wed, 16 Jul 2008 14:14:55 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88760>

On Wed, 16 Jul 2008, Avery Pennarun wrote:

> On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Avery Pennarun" <apenwarr@gmail.com> writes:
>> >        git diff :{1,3}:path/to/filename
>> >
>> > Which is a great command, but svn definitely makes it easier to do the
>> > same thing.
>>
>> I've never seen anybody who finds "diff :{1,3}:path" *useful*.
>
> Dunno.  I use it frequently, and it works great for me.  Perhaps my
> brain is just poisoned by svn.

this is exactly the point that Johannes was trying to make, by teaching 
people these low-level things they get confused and scared. So he is 
suggesting that everyone make an effort to avoid these (at least 
initially)

David Lang

> I've never tried "git log -p --merge".  I'll try it next time.  This
> is certainly not common knowledge, however.  (But to save Dscho the
> trouble: git usability in general is not the subject of this thread.)
>
>> > Even if you have a repo with widespread push access, git's log looks
>> > annoying compared to svn because of all the merge commits.  That's a
>> > primary reason why rebase was invented, of course.
>>
>> Please don't talk nonsense if you do not know history.  I invented rebase
>>  primarily because I wanted to help e-mail based contributors.  There is
>>  nothing about merge avoidance to it.
>
> Sorry, I mixed up git-rerere and git-rebase.  From git-rerere's man page:
>
>       When your topic branch is long-lived, however, your topic branch would
>       end up having many such "Merge from master" commits on it, which would
>       unnecessarily clutter the development history. Readers of the Linux
>       kernel mailing list may remember that Linus complained about such too
>       frequent test merges when a subsystem maintainer asked to pull from a
>       branch full of "useless merges".
>
> Nowadays, I'm pretty sure people use git-rebase to avoid this sort of
> problem (or "git pull --rebase" presumably wouldn't have appeared),
> but I can now see how git-rebase was not written *for* this problem.
>
> Anyway, my point was that git-rebase (or at least git-rerere and
> git-reset) are needed if you want to avoid a lot of merge commits.
> And, to relate it back to this thread, git-rebase cannot possibly be
> understood without understanding git internals, and git internals are
> easiest to understand by learning the plumbing.
>
> svn avoids these excess merges by default, albeit because it puts your
> working copy at risk every time you do "svn update".
>
>>  You can skip merges with "git log --no-merges", just in case you didn't
>>  know.
>
> Perhaps this is mostly a user education or documentation issue.  I
> know about --no-merges, but it's unclear that this is really a safe
> thing to use, particularly if some of your merges have conflicts.
> Leaving them out leaves out an important part of history.  Do you use
> this option yourself?
>
> Have fun,
>
> Avery
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
