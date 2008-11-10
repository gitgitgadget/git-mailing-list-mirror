From: Francis Galiegue <fg@one2team.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 22:31:30 +0100
Organization: One2team
Message-ID: <200811102231.31263.fg@one2team.net>
References: <200811101522.13558.fg@one2team.net> <7v63mv5mro.fsf@gitster.siamese.dyndns.org> <20081110205242.GH2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzeNs-0006zp-Hf
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYKJVcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYKJVcD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:32:03 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:48510 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbYKJVcD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 16:32:03 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-64-185.w90-20.abo.wanadoo.fr [90.20.51.185])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 7606B92C003;
	Mon, 10 Nov 2008 22:31:48 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081110205242.GH2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100578>

Le Monday 10 November 2008 21:52:42 Shawn O. Pearce, vous avez =E9crit=A0=
:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Francis Galiegue <fg@one2team.net> writes:
> > > A very nice git feature, without even going as far as merges, is =
the
> > > cherry pick feature.
> >
> > I thought cherry-picking needs to be done in terms of 3-way merge, =
not
> > diff piped to patch, for correctness's sake.
>
> Yea, the 3-way merge cherry-pick is better.  But in a pinch you
> can (usually) get correct results from a "diff | patch" pipeline.
> Of course that doesn't always work, resulting in patches that don't
> apply cleanly, or worse, that apply at the wrong place silently.

Well, in this case, I'd say it's a case of a bottle being "half full" o=
r "half=20
empty".

The availability of even a simple diff|patch in jgit, and its being ava=
ilable=20
in egit, would generally be seen as a "half full" bottle, and would, im=
ho,=20
GREATLY increase the appeal factor of egit, all the more that you have =
plenty=20
of undo/redo ability in Eclipse... And, dare I say it, of git in genera=
l as=20
an SCM to be used in many environments where Eclipse is the de facto ID=
E.

I know, I may sound irritating, but...

--=20
fge
