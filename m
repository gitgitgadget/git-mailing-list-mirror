From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 16:53:11 +0200
Message-ID: <20070508145311.GA31152@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org> <464023A1.6618BC0A@eudaptics.com> <20070508102836.GB27119@diana.vm.bytemark.co.uk> <20070508124027.GA14366@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue May 08 16:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlR47-0003is-Vr
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968160AbXEHOxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 10:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968104AbXEHOxT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:53:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3358 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968160AbXEHOxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 10:53:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlR3v-00089s-00; Tue, 08 May 2007 15:53:11 +0100
Content-Disposition: inline
In-Reply-To: <20070508124027.GA14366@fieldses.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46583>

On 2007-05-08 08:40:27 -0400, J. Bruce Fields wrote:

> On Tue, May 08, 2007 at 12:28:36PM +0200, Karl Hasselstr=F6m wrote:
>
> > I think it would be worth introducing git-gui as a commit tool in
> > the tutorial(s) and the manual. It gives a very nice graphical
> > representation of the dirty state you're going to commit, and the
> > dirty state you aren't going to commit because you haven't staged
> > it yet. The only drawback is that it's a lot of work to make
> > documentation with screenshots ...
>
> For the tutorial and user manual, could git-gui be treated similar
> gitk, with just a one- or two- line mention here and there? I
> haven't used it, so don't know where it would most logically fit
> in....

I would introduce it with a paragraph or two right where committing is
covered the first time. Explain that the empty file list box to the
left contains the changes that will be committed when you press the
commit button, and that the file list box on the right contains the
changes that won't be committed. By clicking on a file name you get to
see the diff to the file, and by clicking on the icon you move it to
the other file list box -- that is, you stage/unstage it.

And now comes the clever part: Introduce the index, by explaining that
it essentially _is_ the left file list box. Explain that git-add is
the command-line equivalent of moving changes to the left box, and
that git-commit without arguments simply commits what's in the index
-- exactly like git-gui's Commit button.

I think it could work. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
