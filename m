From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Wed, 17 Oct 2007 14:47:14 -0700
Organization: Bluelane
Message-ID: <471682E2.1070202@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <20070709173720.GS29994@genesis.frugalware.org>	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>	 <4713FA4A.5090501@bluelane.com>	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>	 <471433F3.40606@bluelane.com>	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>	 <471454B5.7040802@bluelane.com>	 <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>	 <47159BF9.9040400@bluelane.com> <e5bfff550710170014m395d5b8cld87a5c2c9f7d71a@mail.gmail.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 23:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiGjj-0002hI-GN
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 23:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbXJQVrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 17:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756486AbXJQVrU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 17:47:20 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:1185 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756220AbXJQVrU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 17:47:20 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Oct 2007 17:47:18 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550710170014m395d5b8cld87a5c2c9f7d71a@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 17 Oct 2007 21:47:18.0611 (UTC) FILETIME=[4A1FF230:01C81107]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61429>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Costalba wrote:
> On 10/17/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>> 't' worked fine but still can see how to diff do of the list of
>> changes for a file. Viewing diffs of files based on change sets
>> worked fine but I think with BitKeeper I found it helpful to be
>> able to do a full 'kompare' type diff the file only; often I'm
>> not interested in which change set it went into.
>>
> 
> Well, open tree view ('t'), select the file you are interested of,
> then click the magic wand button on the tool bar, now revisions you
> see are filtered by that file, if you browse the revisions the
> patch/diff you see will always point to your file (also if you can see
> the whole patch).

I take it the "magic wand button" is the check mark on the upper right
that says "Pin View (Alt-V)".  When I pin the view the view of the file
in Qgit locks to the selected file but the External diff seems to stay
the same. The External diff appears to show my last change to the file;
changing the change-set selection doesn't seem to change anything with
the view pinned.


> 
>> Something for a future version or am I lucky and you have
>> it covered already?
>>
> 
> Don't know, depends on how you answer to the above point ;-)

How'd I do?

> 
>> Good Idea, thought it's brought up a few questions:
>>
>>         1. When I do the <control-minis> to Decrease the font size
>>            I can't undo it with the <control-plus>. Also <control-plus>
>>            doesn't seem to do anything.
>>
>>         2. When displaying the "Lane info" why can't I see the
>>            branch names?
>>
> 
> Thanks for the reports, I will investigate as soon as I have a bit of
> spare time.

ok, I suspect that's an easy one.

> 
>> I'll read it a few more times. I seem to sometimes get into a state
>> where I'm locked onto the current change set and can't get back to
>> the other change sets without starting another qgit.
>>
> 
> Please, could you be so kind to better explain me the above point.
> Seems interesting, but I didn't get how to reproduce.

I'm not sure how I get into this state either, I'll try to recall
how I get into this state the next time it occurs.



> 
>>> Yes it is. There are a lot of new featrures, is almost as stable as
>>> the previous and if you are interested in file history (annotations)
>>> in qgit-2.0 this feature has been greatly speeded up.
>> Do you know if it's a lot of work to install Qt4?
>>
> 
> With Mandriva you are just at an uprmi away.
> 
> Try something like
> 
> urpmi libqt4-devel

    /nethome/piet$ su
    /nethome/piet$ /usr/sbin/urpmi libqt4-devel
                   no package named libqt4-devel
    /nethome/piet$

/urpmi libqt4 also didn't work.

> 
> It worked for me ;-)

I'm running 2005 Limited Edition; I wonder if QT4 even existed then.
Think it's worth messing with QT4 just to upgrade to you latest version?
Some of these graphics libs can be bear to install from src.

- -piet

> 
> Marco

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFoLhJICwm/rv3hoRAt73AJ9kWv8EhuaAH/69HqG0+FZOAD8LlgCdH6uU
2PJDFOuZENrKJBA66MOdANc=
=yd6t
-----END PGP SIGNATURE-----
