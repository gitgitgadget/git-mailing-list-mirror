From: Andreas Ericsson <ae@op5.se>
Subject: Re: [DRAFT] Branching and merging with git
Date: Tue, 09 Jan 2007 09:46:06 +0100
Message-ID: <45A3564E.7080003@op5.se>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org> <20070108140305.GE32756@thunk.org> <20070109024125.GD1686@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 09:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4CcX-0001U8-Oe
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXAIIqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXAIIqK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:46:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:40549 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXAIIqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 03:46:09 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 20D2A6BCC7; Tue,  9 Jan 2007 09:46:07 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070109024125.GD1686@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36331>

J. Bruce Fields wrote:
> On Mon, Jan 08, 2007 at 09:03:05AM -0500, Theodore Tso wrote:
>> I would add a QuickStart Chapter before you start going into the
>> "read-only" oeperations.  It would show how to create a completely
>> empty repository, and add a few commits.  It would also demonstrate
>> how to clone an example repository (with a fixed set of contents,
>> stored at git://git.kernel.org/pub/scm/git/example and add a commit
>> using "git commit -a".
>>
>> The basic idea is to show the user that git really isn't that hard,
>> *before* you start diving into a lot of details.  If you don't tell a
>> user how to make a commit until Chapter 3, he/she will assume it's
>> because it's Really Hard, and you may end up losing them before that.
> 
> Yeah, I agree.  I just haven't been able to decide quite what to choose
> for that purpose.  Some choices:
> 
> 	- We could just pare down the tutorial a bit and drag it in as
> 	  chapter one.
> 
> 	- I tried writing something modeled loosely on the hg quick
> 	  start.  It's a little out of date now, but that could be
> 	  fixed:
> 
> 		http://www.fieldses.org/~bfields/git-quick-start.html
> 

I like this, although fetch should probably have "--force" instead of 
the "+branch" notation. --force stands out more and users are familiar 
with --force possibly destroying things (rm -rf, anyone?).

> 	- Or maybe a revised everyday.txt would do the job?
> 
> Any opinions?
> 

I think the document is fine as it is, but could probably start off with 
a link to the tutorial, quickstart or a revised version of everyday.txt, 
stating that "here's something you might want to read if you prefer to 
experiment. If you think something goes wrong, come back here and find 
out why".

>> At least some discussions of branches needs to happen here;
> 
> The basic nuts-and-bolts (how to create and delete branches, etc.)
> should all be covered, of course, but....
> 

I found it quite sufficient. Perhaps it would be nice to include some 
more advanced examples, like octopus merges and things like that, 
although I feel such things could well live in an appendix to keep all 
the easy operations up front. Most people I know will most likely 
*never* use octopus merges. 90% of the merges we do here at work result 
in fast-forwards, so a real merge is already considered a bit odd.

>> it's really important to talk about different workflows, and how you
>> use branches as part of your read-write operations.  Some folks might
>> or might not use topic branches, but the concept of using temporary
>> branches to try things out is critical.
> 
> .... Maybe it'd be fun to have a section called just "examples" at the
> end of each chapter.  The sort of thing you're describing could fit in
> well there.  I'd need some help collecting interesting examples.
> 

Indeed. I for one like examples that tell me

# type this
# this will happen
# you can see what you just did with this, this, and this command
# this is because...

Not only is it good for learning the how and the why, but it also trains 
the fingers right from the start. Hopefully the UI is stabilized enough 
by now that we can reliably tell users how to accomplish a certain 
thing. UI changes must almost certainly be listed at whatever official 
site git has. As Junio has already pointed out, the members of the git 
mailing list are now in minority among the git users, so some other 
place has to hold the user-visible changes as well and the location of 
that site must probably be published along with the tools.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
