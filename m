From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 12:15:40 +0200
Message-ID: <20070521101540.GB32510@diana.vm.bytemark.co.uk>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070520211103.17468.21373.stgit@lathund.dewire.com> <20070521074838.GA32510@diana.vm.bytemark.co.uk> <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 12:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq511-0004rI-3G
	for gcvg-git@gmane.org; Mon, 21 May 2007 12:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762818AbXEUKS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 06:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765476AbXEUKS6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 06:18:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1573 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764287AbXEUKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 06:18:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hq4vU-0000b5-00; Mon, 21 May 2007 11:15:40 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48006>

On 2007-05-21 10:31:09 +0100, Catalin Marinas wrote:

> My plan is to release a 0.13 version pretty soon but without the DAG
> patches as we might have to test them a bit more.

That's reasonable.

> The release after 0.13 I'd like to be a 1.0-rc1 (including the DAG
> patches) unless we have some other major changes pending.

It'd be great to do away with the need to "stg init", but that
shouldn't really be a major change (but I haven't started looking at
it yet). It would be nice if 1.0 had documentation that didn't have to
mention "stg init".

> I don't think we can get much slower than this.

Oh yes we can ... :-)

> I modified stg to only load the modules needed for a given command
> but it still takes around 150ms for a command like 'top'. I don't
> know any other python tricks to make it start faster.

I don't either. We might consider having plumbing written in C or
something, and make sure that the plumbing can be called directly if
there's need, but it's going to complicate things greatly compared to
pure Python.

> BTW, any of you would like to get added as a member to
> gna.org/projects/stgit (there are no advantages, only e-mail updates
> for filed bug reports)?

=46ree bug reports? Sure, I'm in! (I just created a Gna! account: kha)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
