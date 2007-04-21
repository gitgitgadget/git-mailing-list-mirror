From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Sat, 21 Apr 2007 13:00:31 +0200
Message-ID: <20070421110031.GB1670@diana.vm.bytemark.co.uk>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625DDA5.60503@vilain.net> <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk> <200704182219.26410.robin.rosenberg.lists@dewire.com> <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net> <20070419085924.GA21936@diana.vm.bytemark.co.uk> <b0943d9e0704210237k1d91a5a9tc3a5aa54d5a8772e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 13:01:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfDKz-0002cr-Fj
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 13:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030686AbXDULA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 07:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030687AbXDULA7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 07:00:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1975 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030686AbXDULA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 07:00:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HfDKR-0000Wu-00; Sat, 21 Apr 2007 12:00:31 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0704210237k1d91a5a9tc3a5aa54d5a8772e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45167>

On 2007-04-21 09:37:49 +0000, Catalin Marinas wrote:

> On 19/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > (The only problem is that "stg series" prints the stack with the
> > bottom on top and the top at the bottom, but that's old weirdness.
> > :-)
>
> That's coming from quilt, I didn't spend much time on designing the
> user interface (this is something to be done post 1.0). However, on
> the CPUs I work the stack grows downwards but the top/bottom naming
> is the opposite of StGIT one.

Yes, I guessed that might be the origin. Additionally, when printing
the stack on a terminal it's actually best to print the bottom first,
so that at least the topmost patches aren't scrolled off the screen. I
don't really see a problem with this conflicting with all the rest of
StGIT considering the stack to grow from the bottom and upward. It's
just a benign quirk.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
