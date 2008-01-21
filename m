From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 23:38:11 +0100
Message-ID: <85zluy4xf0.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	<alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
	<C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	<20080121195703.GE29792@mit.edu>
	<998717B0-0165-4383-AAB8-33BD2A49954E@sb.org>
	<20080121201530.GF29792@mit.edu>
	<8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
	<20080121204614.GG29792@mit.edu>
	<6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
	<20080121211802.GH29792@mit.edu>
	<45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7al-0001g9-LX
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbYAVBFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYAVBFs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:05:48 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:59451 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753449AbYAVBFk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:05:40 -0500
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 70CE217F93B;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 54D441143F1;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-102-235.pools.arcor-ip.net [84.61.102.235])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 14879108A6;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9E0061C39507; Mon, 21 Jan 2008 23:38:11 +0100 (CET)
In-Reply-To: <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org> (Kevin Ballard's
	message of "Mon, 21 Jan 2008 16:43:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5515/Tue Jan 22 00:03:56 2008 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71388>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 21, 2008, at 4:18 PM, Theodore Tso wrote:
>
>> Your faith in the HFS+ designers is touching.
>
> And your arrogance is troubling. Do you really believe you are so
> smart you can claim the HFS+ designers had no reason for this
> decision?

No reason?  Don't say where he says that.  No sane reason?  Certainly.
If the visibility of the upsides is not in the same order of magnitude
as that of the downsides (and your "I trust they must have had good
reason" is implicating exactly that), then yes, this appears like a
misdesign, however well-intended.  Because its cleverness hinges on an
what amounts to an arbitrary historic point of stability with only
fleeting convenience.

It reminds me of the self-defeatingproblem haunting the MIPS
(microprocessor without interlocked pipeline stages) architecture: for
pipelined processors, one has to add logic that prevents one command
from working before the results from other commands arrive.  Now the
ingenious idea of the MIPS architecture was to move that logic into the
compiler instead of the hardware.  But then the implications of that
idea got intermingled with binary compatibility and the result was that
the advantages lasted for one processor generation, and afterwards, the
m-stage pipelines needed logic that simulated the n-stage pipeline of
the first MIPS processor rather then a comparatively simple 1-stage
pipeline of a conceptual sequential processor.  Rendering the whole
original idea completely absurd and requiring rather more complicated
rather than simpler hardware as originally envisioned.

The road to hell is paved with good intentions.

>>> The reason may not be valid anymore, but if it was valid back in
>>> 1998, then I can accept it without complaining.

There is no shortage in short-sighted decisions to repeat.  Some
political parties bank on it.

> Again, I'm not saying that they necessarily did the "correct" thing,
> as I can't evaluate that without knowing their reason. I'm just saying
> there must have been a reason.

Jumping to blind faith-based conclusions is never a good move.  You
don't end up improving the work of your predecessors that way.

> And why do you believe MacOS is going to adopt ZFS? Sure, they might,
> but assuming stuff about the future is just as bad as assuming stuff
> about the past. And git should "pervert" itself because of the simple
> fact that git has a problem on HFS+. Keeping your code "pure" is all
> well and good, except it's not particularly practical. If the git
> project has any interest in being a viable system on OS X, it really
> should behave properly.

If OS X has any interest in being a viable system, perios, it really
should behave properly.

> How many times must I say I never suggested actually changing git's
> hashing algorithm? And if you want me to suggest a fix to git that
> works, first you have to wait for me to learn how git's internals
> work, and frankly, I have too much work on my plate right now to
> devote the time necessary to learning git's internals well enough to
> fix this problem.

Then please understand that you have too much work on your plate right
now to devote the time necessary to provide any constructive criticism.
A smart person in this situation would shut up until he has the time.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
