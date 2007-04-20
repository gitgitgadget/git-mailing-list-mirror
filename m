From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 03:39:43 -0700
Message-ID: <7vr6qf1g9c.fsf@assigned-by-dhcp.cox.net>
References: <200704171818.28256.andyparkins@gmail.com>
	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
	<200704181426.29969.andyparkins@gmail.com>
	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
	<4626C4B9.1040707@midwinter.com>
	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>
	<7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
	<4627B292.6080202@midwinter.com>
	<7vd52054e3.fsf@assigned-by-dhcp.cox.net>
	<20070420101801.GA13560@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Grimm <koreth@midwinter.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeqWs-0005G8-N7
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 12:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423046AbXDTKjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 06:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767049AbXDTKjq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 06:39:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37819 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423046AbXDTKjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 06:39:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420103945.BBCU1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 06:39:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pNfk1W00Q1kojtg0000000; Fri, 20 Apr 2007 06:39:45 -0400
In-Reply-To: <20070420101801.GA13560@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 20 Apr 2007 12:18:01
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45081>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> This is the main selling point of StGIT, in my opinion. It keeps trac=
k
> of stuff for you when you rebase, so you won't accidentally forget
> things. The extra help isn't needed much when everything goes
> smoothly, but as soon as you get a conflict or three in the middle of
> rebasing a largish stack, it's invaluable to just be able to say "stg
> series" to see which patches have been applied to HEAD, and which are
> still floating in limbo.

I do not think we are talking about the same thing.  In your
example, you perfectly well remember that you were in the middle
of StGIT operation.  The problem I described is that sometimes I
do not even recall if I was rebasing or merging after resolving
conflicts.  If I *knew* I was in the middle of a rebase, I know
where to look (.dotest/ has all the necessary "state" for
rebase/am to continue) to remind me where I was.
