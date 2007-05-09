From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 23:45:57 -0400
Message-ID: <20070509034556.GC27980@fieldses.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org> <464023A1.6618BC0A@eudaptics.com> <20070508102836.GB27119@diana.vm.bytemark.co.uk> <20070508124027.GA14366@fieldses.org> <20070508145311.GA31152@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 09 05:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hld7x-0001Qg-TE
	for gcvg-git@gmane.org; Wed, 09 May 2007 05:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965724AbXEIDqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 23:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967607AbXEIDqE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 23:46:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37898 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965724AbXEIDqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 23:46:02 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hld7l-0003XR-1o; Tue, 08 May 2007 23:45:57 -0400
Content-Disposition: inline
In-Reply-To: <20070508145311.GA31152@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46654>

On Tue, May 08, 2007 at 04:53:11PM +0200, Karl Hasselstr=F6m wrote:
> I would introduce it with a paragraph or two right where committing i=
s
> covered the first time. Explain that the empty file list box to the
> left contains the changes that will be committed when you press the
> commit button, and that the file list box on the right contains the
> changes that won't be committed. By clicking on a file name you get t=
o
> see the diff to the file, and by clicking on the icon you move it to
> the other file list box -- that is, you stage/unstage it.
>=20
> And now comes the clever part: Introduce the index, by explaining tha=
t
> it essentially _is_ the left file list box. Explain that git-add is
> the command-line equivalent of moving changes to the left box, and
> that git-commit without arguments simply commits what's in the index
> -- exactly like git-gui's Commit button.
>=20
> I think it could work. :-)

Definitely, sounds fun.

=46or the in-tree documentation, maybe I'm just my crusty text-centric
commandline point of view, but I'd rather have the primary explanation
continue to depend only on text and commandline examples, and then add =
a
note telling people that playing with git-gui may help develop their
intuition for the way the index works.

But I think it'd be interesting to try out the above approach with
screenshots, etc., on a web page someplace.  It might also make a good
visual aid for a talk.

--b.
