From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Sat, 21 Apr 2007 12:15:17 +0200
Message-ID: <20070421101517.GL8507@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625DDA5.60503@vilain.net> <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk> <200704182219.26410.robin.rosenberg.lists@dewire.com> <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net> <20070419085924.GA21936@diana.vm.bytemark.co.uk> <b0943d9e0704210237k1d91a5a9tc3a5aa54d5a8772e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 12:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfCeF-0004uJ-5h
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbXDUKQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 06:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbXDUKQl
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:16:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39317 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030468AbXDUKQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:16:40 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1DCBB5C7F6;
	Sat, 21 Apr 2007 12:16:38 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 44D461F06B; Sat, 21 Apr 2007 12:15:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0704210237k1d91a5a9tc3a5aa54d5a8772e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45161>

On Sat, Apr 21, 2007 at 09:37:49AM +0000, Catalin Marinas wrote:
> On 19/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >On 2007-04-18 22:35:02 +0200, Yann Dirson wrote:
> >
> >> But if the consensus is that "sink" or something else sounds bette=
r,
> >> I have myself no objection to bury "bury" :)
> >
> >I think that "sink" is by far the best word for it, especially when
> >paired with "float". (The only problem is that "stg series" prints t=
he
> >stack with the bottom on top and the top at the bottom, but that's o=
ld
> >weirdness. :-)
>=20
> That's coming from quilt, I didn't spend much time on designing the
> user interface (this is something to be done post 1.0). However, on
> the CPUs I work the stack grows downwards but the top/bottom naming i=
s
> the opposite of StGIT one.

Anyway, it's been customary to have computer display coordinates to
"grow" from top to bottom, with "0" being the 1st line :)
