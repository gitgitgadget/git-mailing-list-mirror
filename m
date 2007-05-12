From: Yann Dirson <ydirson@altern.org>
Subject: Re: Using StGIT for tweaking already-committed stuff
Date: Sat, 12 May 2007 09:10:23 +0200
Message-ID: <20070512071023.GD16903@nan92-1-81-57-214-146.fbx.proxad.net>
References: <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz> <20070510222347.GB12366@diana.vm.bytemark.co.uk> <20070511204016.GH19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070511224325.GA13310@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 09:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmllP-00079B-Bp
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbXELHLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 03:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbXELHLb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:11:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46666 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491AbXELHLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:11:30 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B681D5F004;
	Sat, 12 May 2007 09:11:28 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D86162025; Sat, 12 May 2007 09:10:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070511224325.GA13310@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47022>

On Sat, May 12, 2007 at 12:43:25AM +0200, Karl Hasselstr=F6m wrote:
> It's only unothodox if you expect git and stgit to not always mix so
> well. But if we have the ambition that they should interoperate as
> near to seamlessly as we can make them, this kind of workflow becomes
> very natural.

It is great that this is possible, but I'm not sure I'll ever see it
as "very natural" :)

> It shouldn't be necessary with a manual "assimilate" step. If stgit
> finds that there are unadorned git commits on top of the patch stack,
> it should do the assimilation automatically. With that in place, "stg
> new" and "stg refresh" would be nearly superfluous, since git-commit
> with and without --amend does the same thing -- the only thing they
> won't do is give the user the option of manually choosing the patch
> name.

Hm.  I'm not that convinced :)

Eg, imagine a merge commit somewhere in the stack.  What would stgit
do with that ?

> I believe this sort of integration is the way to go. It'll be
> beneficial for git users who want to occasionally use some stgit to
> rebase their patch series, since they'll not have to learn more than
> two or three new commands in addition to the git they already know.
> Heavy stgit users will benefit from having the much larger git
> community maintaining a large subset of the porcelain they use,
> instead of having to duplicate the effort and always lag behind.
>=20
> This is no binary choice, of course. One could certainly imagine a
> compromise where stgit becomes much easier to mix with git than today=
,
> but still retains the current command set.

I quite like the idea of makeing it easier to mix them, and removing
the real duplicates from stgit, but I think that we should be careful
not to remove power from stgit while doing this.

Best regards,
--=20
Yann.
