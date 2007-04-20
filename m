From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 12:18:01 +0200
Message-ID: <20070420101801.GA13560@diana.vm.bytemark.co.uk>
References: <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com> <462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com> <7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net> <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net> <4627B292.6080202@midwinter.com> <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Grimm <koreth@midwinter.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeqBz-0004XX-N4
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 12:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992821AbXDTKSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 06:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992824AbXDTKSL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 06:18:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3213 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992821AbXDTKSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 06:18:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HeqBl-0003f9-00; Fri, 20 Apr 2007 11:18:01 +0100
Content-Disposition: inline
In-Reply-To: <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45079>

On 2007-04-19 16:30:12 -0700, Junio C Hamano wrote:

> But in practice, after 'git rebase' stops on a conflicting merge, I
> spend many braincycles to come up with a sensible merge and then
> many CPU cycles to run test, and by the time I do the final "git
> diff" to make sure everything look right and "update-index" them, I
> often end up getting confused and find me asking this question: what
> was I doing? Was I resolving the merge because I merged, or was I in
> the middle of a rebase, or was I applying from a mailbox?

This is the main selling point of StGIT, in my opinion. It keeps track
of stuff for you when you rebase, so you won't accidentally forget
things. The extra help isn't needed much when everything goes
smoothly, but as soon as you get a conflict or three in the middle of
rebasing a largish stack, it's invaluable to just be able to say "stg
series" to see which patches have been applied to HEAD, and which are
still floating in limbo.

The usability increase is very palpable; without it, I wouldn't even
attempt many of the rebasings I do, even though they are technically
perfectly possible to do with just git.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
