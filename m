From: david@lang.hm
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 10:35:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0706031031520.6705@asgard.lang.hm>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org>
 <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net>
 <20070603151921.GB30347@artemis> <vpq1wgtnith.fsf@bauges.imag.fr>
 <20070603160736.GC30347@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 19:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hutym-0001R9-KZ
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbXFCRew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 13:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbXFCRew
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 13:34:52 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:56203
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbXFCRew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 13:34:52 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l53HYeuH019489;
	Sun, 3 Jun 2007 10:34:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070603160736.GC30347@artemis>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49015>

On Sun, 3 Jun 2007, Pierre Habouzit wrote:

> On Sun, Jun 03, 2007 at 05:44:58PM +0200, Matthieu Moy wrote:
>> Pierre Habouzit <madcoder@debian.org> writes:
>>
>>>   Yeah, now that I read that thread, well yeah, I think notes are a hell
>>> of a good concept for my ideas. I mean, a bug report would be basically
>>> a collection of notes:
>>>   * the bug has been found at this commit ;
>>>   * the bug has been not-found at this commit ;
>>>   * this commit is a fix for that bug ;
>>
>> That's my feeling too. "Commiting" bug information in the tree is only
>> half of a good idea. You want to be able to say, after the fact, "This
>> commit had bug XYZ". OTOH, the idea (followed by bugs everywhere) that
>> merging a branch would automatically close bugs fixed by this branch
>> is a really cool thing.
>
>  That would work with notes, as while merging you'll get the notes of
> the commit in your branch, *and* the note about the fixing patch. So
> there is no loss of "concept" here. In fact that was the thing that I
> looked for. Notes are good. They just may not be enough to write an
> in-git bugtracking tool, as a bug needs the "notes collection" concepts,
> and maybe a few other.

how would you identify bugs in such a way that they will match up when you 
merge different trees?

if you can manage to do this it sounds like a great idea. but I'm not 
seeing a good way to do it at the moment. the answer may be a combination 
of a number of factors.

1. bug number doesn't work well in a distributed environment

2. something based on indentifying the cause of the bug (commit id + file 
+ line????) will only work after you know the real cause of the bug

3. description is worthless, too many ways to describe things that have 
the same underlying cause

David Lang
