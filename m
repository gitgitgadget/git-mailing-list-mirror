From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Better diagnostic for wrong branch configuration.
Date: Sun, 7 Oct 2007 16:17:44 +0200
Message-ID: <20071007141744.GY26436@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth> <20071007131417.GA28492@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 16:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeX02-0000SA-K7
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbXJGOUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 10:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbXJGOUp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:20:45 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60662 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbXJGOUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:20:44 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D659C17B53E;
	Sun,  7 Oct 2007 16:20:42 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AD9A517B531;
	Sun,  7 Oct 2007 16:20:42 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3E12E1F051; Sun,  7 Oct 2007 16:17:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071007131417.GA28492@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60178>

On Sun, Oct 07, 2007 at 03:14:17PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-10-05 22:44:52 +0200, Yann Dirson wrote:
>=20
> > If the branch.*.merge parameter does not name a valid remote head,
> > stgit would not rebase after a fetch, and would write instead
> > 'Rebasing to "None" ... done'.
> >
> > This patch makes this situation an error and tells the user what to
> > fix in his repo configuration.
>=20
> Good. Sign-off?

Oops, sorry - "Signed-off-by: Yann Dirson <ydirson@altern.org>"

> > -                raise GitException, "StGit does not support multip=
le FETCH_HEAD"
> > +                raise GitException, 'StGit does not support multip=
le FETCH_HEAD'
>=20
> Unrelated quote fixup. No big deal, though.

Right - did not seem to warrant a patch of its own :)

Best regards,
--=20
Yann
