From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/4] Add 2 new contrib scripts.
Date: Sun, 3 Jun 2007 14:40:18 +0200
Message-ID: <20070603124018.GD6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth> <20070531223423.6005.59088.stgit@gandelf.nowhere.earth> <87fy5cqbaz.fsf@morpheus.local> <20070603123254.GB6507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HupNi-0004fh-PY
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 14:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760413AbXFCMkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760333AbXFCMkU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 08:40:20 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39360 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760213AbXFCMkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 08:40:19 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 079B95A238;
	Sun,  3 Jun 2007 14:40:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8FD521F01B; Sun,  3 Jun 2007 14:40:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603123254.GB6507@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48985>

On Sun, Jun 03, 2007 at 02:32:54PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-06-01 11:22:12 +0200, David K=E5gedal wrote:
>=20
> > This is something I've been missing.
>=20
> I believe this is useful, too.
>=20
> > But I'd call it "stg merge" or something, since what it does is tha=
t
> > it merges the top patch into the patch below it. But since "merge"
> > means something else to git, it might not be the best choice.
>=20
> Maybe "coalesce"? I recall using that word when turning several
> consecutive memory blocks into a single larger block in a malloc
> implementation, and this sitiation is very similar.

Hm, maybe, but the idea is not necessarily to merge this patch into
the former one (I have written contrib/stg-swallow for this use), but
really to turn the patch into just local changes (eg. to restore local
changes after a complex operation, like in stg-k).

> It would be nice if it was possible to specify an arbitrary series of
> patches, and get them coalesced into one. (StGIT would have to push
> and pop to place them consecutively and topmost.) With a parameter to
> control the name of the new large patch, and the comment being the
> concatenation of the comments of the component patches (easily
> editable in the editor window that pops up).

stg-swallow would be quite easy to extend for this usage.

Best regards,
--=20
Yann.
