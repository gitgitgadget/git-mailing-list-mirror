From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Fri, 4 Feb 2011 19:50:28 +0200
Message-ID: <AANLkTimytxjqoCf-LbxQqSgmAW2+FqmSLN5c_8fSJhLy@mail.gmail.com>
References: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
	<20110131225529.GC14419@sigill.intra.peff.net>
	<AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
	<20110201201144.GA16003@sigill.intra.peff.net>
	<AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
	<4D488DCD.3080305@eaglescrag.net>
	<4D4929F4.3020805@snarc.org>
	<4D4A11D7.4040103@eaglescrag.net>
	<20110203174518.GA14871@sigill.intra.peff.net>
	<AANLkTi=qR5xYBg3NKRASuyatnEm1k3fVNc-i5VOwszpM@mail.gmail.com>
	<20110204061622.GB2455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "J.H." <warthog19@eaglescrag.net>, Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 04 18:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlPqZ-0005Zt-Cs
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 18:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab1BDRxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 12:53:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61507 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1BDRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 12:53:21 -0500
Received: by fxm20 with SMTP id 20so2673964fxm.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=33YeE+oi5DoeUNFiTzxotp+m64hYgIfh7Mp8O45uyNY=;
        b=VQKF0Wn44u59Al/uhKGJ/BNrxTfOpuf5TqntAa8CdF+Vvl7mDLjxnllmrt7GtFtWF+
         VcZJ/EsIfWOxhBAAxUsGCU1S5ft8t+z4kV2P3ttP/WlaVgbcutPeORD+jFuAM18SltBW
         9bd4qpGcrGldgs4udo6BtOxHUvUeFqUejgTxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rp0WU41ZFNzSo8aIuXOYwjxdokj6c3M9dCY9CKhC1bSWGXv/yLRoUcTO19NC3x6gIy
         g5WMV2lKbmHolYkepZ8GWvCnrloHLOBiE5JVRCwIALJtnTdCFd7qBMO4UR92JgkfWgc/
         xyYZbuaay03qCP1M++m43cArIKHGNPR9nsOg8=
Received: by 10.223.73.202 with SMTP id r10mr5877964faj.133.1296841828778;
 Fri, 04 Feb 2011 09:50:28 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Fri, 4 Feb 2011 09:50:28 -0800 (PST)
In-Reply-To: <20110204061622.GB2455@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166051>

On Fri, Feb 4, 2011 at 8:16 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 03, 2011 at 10:34:38PM +0200, Felipe Contreras wrote:
>
>> > Forget about a git-backed wiki for a moment, and imagine a regular old
>> > Mediawiki. What are the operations you can perform? You can look at
>> > the current or any past version of a page, you can do diffs between
>> > versions of pages, and you can create a new version of a page. All
>> > through some CGI forms.
>>
>> Howe about these?
>
> I've never really used a wiki in any in-depth way, so be gentle if my
> utter cluelessness about these features shows through.
>
>> 1) Support for discussion; since changes can be controversial.
>
> Doesn't this just happen on special Talk: pages? Couldn't these just be
> pages with special names?

Could be.

>> 2) Support for article move; so everything is kept organized.
>
> Isn't that even simpler in a git-backed wiki? You just move the files.
> Obviously you would want to update links, too, and presumably the wiki
> software helps with that. But that is outside the scope of data storage.
> In a git-backed wiki, you would get one atomic commit with the move and
> link updating.

Yeah.

>> 3) Support for "who is linking here". Also helps reorganization.
>
> Again, is that a fundamental storage issue? It seems like you could
> implement that easily on top of basic storage with a grep (and some
> caching if you are going to let people do it a lot via the web).

I doubt that. That's where you need an SQL database, to make it fast.

>> 4) Support for categories. Ditto.
>
> I have no idea how categories work. Special page naming and/or
> directories?

Each page has a tag [[Category::Tips]], and then the the
Category::Tips page gets a new link automatically. Again, SQL helps.

>> 5) Support for watchlist, e-mail notifications. So that you are
>> up-to-date with the changes.
>
> Post-receive hook?

Yeah, but you need to store the watchers, and their preferences. Again, SQL.

>> 6) Support for contribution backtracking. So that it's easy to know who's who.
>
> git log? git blame? :)

Sure, 'git log' would do it... Very inefficiently.

>> 7) Personal wiki pages (with discussion). So you can put information
>> about yourself, and general notes.
>
> Specially named pages for people?

Right.

> Obviously I'm just filling in these features off the top of my head.
> MediaWiki is a mature system, and I doubt that either ikiwiki or gollum
> has nearly the same featureset. But that was never my point. In the bit
> you quoted, my point was that a git-interface to a wiki was useful and
> feasible. And I stand by that.

It might be possible to implement some functionality of a full blown
wiki such as MediaWiki on a git backed wiki, but my point is that it's
not there _now_, and more likely would never be.

> Even with just the basic functionality of fetch/diff/push, that still
> makes it a useful interface into an existing wiki for a large number of
> users who just want to do simple stuff (or power users who happen to be
> doing simple stuff at the moment).
>
> I also happen to think you could put all of those features into a
> git-backed wiki, and build the web features on _top_ of git access. But
> I'm not volunteering to work on that.

Exactly, and nobody is volunteering for that. MediaWiki is the best,
it has all the features, and it's already there.

Cheers.

-- 
Felipe Contreras
