From: Scott Haneda <talklists@newgeo.com>
Subject: Re: Is this an appropriate list for general git questions
Date: Sat, 27 Mar 2010 01:07:09 -0700
Message-ID: <0D0DD5C5-B535-49AC-B0A9-403C4FA5E193@newgeo.com>
References: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com> <32541b131003211736t823ea8cye7ab4075fa8ccdd5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 09:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvR3e-0001gF-Hl
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 09:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012Ab0C0IHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 04:07:16 -0400
Received: from moses.hostwizard.com ([64.84.37.6]:59656 "EHLO
	gonepostal.hostwizard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab0C0IHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 04:07:11 -0400
Received: from [192.168.1.103] (173.164.173.161) by 
 gonepostal.hostwizard.com with ESMTP (EIMS X
 3.3.9); Sat, 27 Mar 2010 01:07:10 -0700
In-Reply-To: <32541b131003211736t823ea8cye7ab4075fa8ccdd5@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143319>

On Mar 21, 2010, at 5:36 PM, Avery Pennarun wrote:

> On Sun, Mar 21, 2010 at 6:59 PM, Scott Haneda <talklists@newgeo.com> wrote:
> 
>> I have seen there are a lot of patches, diffs, and what appear to be
>> development related posts on this list.  Am I in the correct place?
>>  If not, can someone point me in the right direction?
> 
> There's only one official git mailing list, so that's what you get.  I
> think the rule of thumb for mailing lists is: if you can't answer your
> questions in ten seconds using a Google search, then you're pretty
> safe asking on a mailing list.  It looks like you're safe.

Phew :)

> By the way, this mailing list accepts posts from non-subscribers, and
> it's the policy on the list to always cc: everyone who has replied to
> a message in that thread so far, including the original poster.  The
> idea is that you can ask a question about git without *having* to
> subscribe to read all the other stuff.  But of course, reading some of
> the other stuff will make you a more competent git user pretty fast,
> so it might be worth it anyway.

Interesting, I have never once in 15+ years of mailing lists, seen a list work this way.  Pretty nice to not have to subscribe.  Amazing that there is not spam all over this list.

>> I am thinking github is going to be where I put all this stuff, but I am
>> completely lost on where to even begin with all this.  I watched a few
>> of the videos on the kernel.org website, and will continue with the
>> git tutorials and documentation.
> 
> You should probably look at getting a good book on version control.
> You can find *these* using Google, including free online ones, now
> that you know this is what you should do :)

Ok, I will look into it.  I am really hoping there is a "4 command to using git" type of thing.  I think I even heard that Joel Spoolsky guy state something along those lines; that he has gotten by with version control on 4 commands.  I can not remember if it was git he was referring to though.

My needs are so simple, I was hoping to not have to dig too deep, and conquer the complicated things as they come up.  Sort of like using a new text editor for the first time, there really is no learning curve to get started, you just start typing.  When you want syntax highlightig, you solve that and move on.

Can git not be treated in that way?  Is git a little steeper in the "get going" phase post installation?  I was hoping compiling it for OS X to be installed where I want it would be the hardest part :)

>> The second reason I came to this list is that I am a Mac user,
>> and some of the tools I have created are resource fork dependent.
>> If they are ftp'd they will be broken.  Rsync is the only tool I know
>> of that can accurately transfer the files without destroying them.
>> However, this requires a custom patched version of rsync, and
>> must be equal on both ends.  I am not sure git hub is going to
>> have that patch applied.  I may be getting into git hub specifics
>> here, and going outside of the lists scope being focussed on git,
>> if I am, plesae let me know and I can find a git hub resource.
> 
> github just does what git does, only with a friendly web interface.
> git doesn't support fancy xattrs or resource forks, at least without
> using add-on tools.  This is because source code almost never *needs*
> these resource forks: only finished products do, and those are usually
> built *from* the source code.  As part of the build process, you add
> the resource forks and xattrs onto the completed files.

Yes, very true, except in the case of AppleScripts and Automator actions.  Which can be "compiled" and finished apps, but also can be raw source files.  However, I believe that even those, being that they run in their own development environment, have resources and other attributes that have to be maintained.

> Also, your repository wouldn't work on non-Mac computers if git stored
> that kind of stuff internally.

In my case, I have no intention of using my repo on anything but Mac.  But I can get past just not putting AppleScript and Automator actions into my repo.  Who knows, it may work. I will ftp a source automator action and see if when I pull it back down, it is broken, or if it works.

> Your best bet is to have a simple Makefile or build script that does
> everything that's necessary.  There are a couple of tools out there
> that claim to support attrs and xattrs (for example, metastore), but
> at least in metastore's case I don't see any evidence that it supports
> resource forks.

I will take a look, thank you very much.
-- 
Scott * If you contact me off list replace talklists@ with scott@ * 
