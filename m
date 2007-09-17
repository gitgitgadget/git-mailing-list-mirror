From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 21:35:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709162126380.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm> <7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm> <7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm> <7v7imp539u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX8Lr-0004zo-TA
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 06:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXIQEgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 00:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXIQEgn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 00:36:43 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:36096
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXIQEgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 00:36:42 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8H4ZLVP026616;
	Sun, 16 Sep 2007 21:35:22 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v7imp539u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58385>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
>
>>> Post-checkout trigger is something I can say I can live with
>>> without looking at the actual patch, but that does not mean it
>>> would be a better approach at all.
>>
>> we agree on this much at least :-)
>>
>>> I would not be able to answer the first question right now; that
>>> needs a patch to prove that it can be done with a well contained
>>> set of changes that results in a maintainable code.
>>
>> you cannot answer the question in the affirmitive, but you could say
>> that any changes in that area would be completely unacceptable to you
>> (and for a while it sounded like you were saying exactly that). in
>> which case any effort put into preparing patches would be a waste of
>> time
>
> I tend to disagree.  It's far from a waste of time.  While, as I
> said, I am skeptical that such a patch would be small impact, if
> it helps people's needs, somebody will pick it up and carry
> forward, even if that somebody is not me.  It can then mature
> out of tree and later could be merged.  We simply do not know
> unless somebody tries.  And I am quite happy that you seem to be
> motivated enough to see how it goes.
>
> On the other hand, the experiment could fail and you may end up
> with a patch that is too messy to be acceptable, in which case
> you might feel it a waste of time, but I do not think it is a
> waste even in such a case.  We would learn what works and what
> doesn't, and we can bury "keeping track of /etc" topic to rest.

this is perfectly acceptable to me. I was trying to make very sure that 
this topic fell in this catagory.

there are other topics that come up repeatedly that do get (and deserve) 
automatic rejections ('patch to explicitly record renames' for example). 
and while I didn't think that 'managing /etc' was in the same catagory, 
sometimes that catagory is defined as much by the opinions and goals of 
the core team as it is by techinical considerations.

there's a huge difference between 'this patch is rejected becouse we think 
the implementation is bad' and 'this patch is rejected becouse we disagree 
with the fundamental goal of the patch' effort spent on a patch rejected 
for the first reason is never a complete waste (if nothing else it can 
serve an an example of how not to do things for future developers ;-) but 
effort spent on a patch that's rejected for the second reason is useually 
a waste, and as such I make it a point to discuss the objective and basic 
approach before spending much effort on somthing.

> I also need to rant here a bit.
>
> Fortunately we haven't had this problem too many times on this
> list, but sometimes people say "Here is my patch.  If this is
> accepted I'll add documentation and tests".  I rarely reply to
> such patches without sugarcoating my response, but my internal
> reaction is, "Don't you, as the person who proposes that change,
> believe in your patch deeply enough to be willing to perfect it,
> in order to make it suitable for consumption by the general
> public, whether it is included in my tree or not?  A change that
> even you do not believe in yourself has very little chance of
> benefitting the general public, so thanks but no thanks, I'll
> pass."
>

I hope that my questions did not seem to fall into this catagory.

David Lang
