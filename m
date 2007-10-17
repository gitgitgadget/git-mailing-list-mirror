From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 22:22:01 -0700
Organization: Bluelane
Message-ID: <47159BF9.9040400@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <20070709173720.GS29994@genesis.frugalware.org>	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>	 <4713FA4A.5090501@bluelane.com>	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>	 <471433F3.40606@bluelane.com>	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>	 <471454B5.7040802@bluelane.com> <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii1MN-0006A9-55
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 07:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbXJQFWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbXJQFWL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 01:22:11 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56795 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750844AbXJQFWJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 01:22:09 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Oct 2007 01:22:08 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 17 Oct 2007 05:22:08.0570 (UTC) FILETIME=[A9CB79A0:01C8107D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61332>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Costalba wrote:
> On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>> It's not quite a intuitive/familiar as with bitkeeper. I suspect I just
>> need some practice. I selected a huge list if files that we use to
>> filter the release with and double clicked on the file I thought showing
>> to focus on that file. The I pulled down External Diff and it took for
>> ever; like it's confused.
>>
> 
> You shoudl select only _one_ additional revision.
> 
> The currenlty selected revision is the base + select another one
> (only) with CTRL + *RIGHT* click (the file list change background
> color) , then call external diff tool.
> 
>> Often we/I want to see the rev history for a particular file.
>> How would you do that with Qgit?
>>
> 
> Select the file from the file list (right bottom pane) or from the
> tree view (use key 't' to toggle treev view) double click on it or use
> context menu (right click on the file name) and that's all.

't' worked fine but still can see how to diff do of the list of
changes for a file. Viewing diffs of files based on change sets
worked fine but I think with BitKeeper I found it helpful to be
able to do a full 'kompare' type diff the file only; often I'm
not interested in which change set it went into.

Something for a future version or am I lucky and you have
it covered already?

> 
>> Can I see just the revs for a particular file?
>>
> 
> See above.
> 
> 
> I know I'm going to tell you a very _unpopular_ thing, but, in case
> you have 5 minutes of spare time (yes, it doesn't take longer), open
> qgit then please press a nice key called 'F1', a nice handbook will
> appear...

Good Idea, thought it's brought up a few questions:

	1. When I do the <control-minis> to Decrease the font size
	   I can't undo it with the <control-plus>. Also <control-plus>
	   doesn't seem to do anything.

	2. When displaying the "Lane info" why can't I see the
           branch names?

>
> I really suggest to look at it. To keep UI 'clean' a lot of features
> are not immediatly visible, so reading the handbook (at least the
> chapter's titiles) would give you a better idea of what qgit could do
> for you.

I'll read it a few more times. I seem to sometimes get into a state
where I'm locked onto the current change set and can't get back to
the other change sets without starting another qgit.

> 
>> I'll get the latest and greatest. Thinks. Often the problem is
>> having the current version of Qt3. My workstation is Mandrake
>> 1005 Limited Edition (X11 Xinerama works on this release).
>> Looks like I have Qt3 on my workstation. Would it be worthwhile
>> to install Qt4 from src and try to use qgit-2.0?
>>
> 
> Yes it is. There are a lot of new featrures, is almost as stable as
> the previous and if you are interested in file history (annotations)
> in qgit-2.0 this feature has been greatly speeded up.

Do you know if it's a lot of work to install Qt4?

- -piet

> 
> 
> Have fun
> Marco

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFZv5JICwm/rv3hoRAky6AJ47DFL/pWa8CCHv0ezw0wdkLLmbIQCeJqZN
cNHuMINv2/7fmnwczWcowhs=
=VSZN
-----END PGP SIGNATURE-----
