From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 22:54:57 +0200
Message-ID: <20070724205457.GC6004@steel.home>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com> <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com> <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com> <Pine.LNX.4.64.0707241733370.29908@reaper.quantumfyre.co.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDRPR-0001mk-Hz
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbXGXUzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbXGXUzE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:55:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:20788 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbXGXUzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:55:01 -0400
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (fruni mo42) (RZmta 10.1)
	with ESMTP id J0111bj6OHkjvG ; Tue, 24 Jul 2007 22:54:58 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CF055277BD;
	Tue, 24 Jul 2007 22:54:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 46773BDD0; Tue, 24 Jul 2007 22:54:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707241733370.29908@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggT2BuA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53643>

Julian Phillips, Tue, Jul 24, 2007 18:35:15 +0200:
> On Tue, 24 Jul 2007, Patrick Doyle wrote:
> 
> >>>  ... and I don't commit until I've completed
> >>>  the particular feature I'm working on, I can get a fairly good idea of
> >>>  where I am and what I was doing last (which might be 5-7 days ago,
> >>>  given high priority interrupts on other projects, summer vacations,
> >>>  etc...) just by running a "git status".  I see that there are 7 new
> >>>  files, and 2 modified files.  I know that, when I fork my branch, I
> >>>  can use "git diff master" to see what's different between my branch
> >>>  and the master, but then I get the diff of all of the changes as well,
> >>>  which is too much information.  "git diff --name-only" and "git diff
> >>>  --summary" are closer, but I can't tell what's been added vs. what's
> >>>  been changed.  Any suggestions?
> >>
> >> "git log -p ..master", or even simpler "gitk ..master"
> >I was hoping for something less verbose than a diff or a patch file --
> >something that just listed what has changed -- I'll have to
> >investigate whether your "my_status()" macro provides the information
> >for which I was looking -- thanks for the pointer.
> 
> "git log --stat ..master" perhaps?
> 

yep. Or just use the same options as with diff:

    $ git log -r --name-status -M -C ..master
