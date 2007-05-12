From: Yann Dirson <ydirson@altern.org>
Subject: Re: Transactions for git (and stgit) ?
Date: Sat, 12 May 2007 20:34:43 +0200
Message-ID: <20070512183443.GM19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070512095312.GK19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070512104919.GA22735@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 20:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmwRh-0005vS-Ca
	for gcvg-git@gmane.org; Sat, 12 May 2007 20:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXELSfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756302AbXELSfv
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 14:35:51 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:36247 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXELSfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 14:35:51 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 19A565F185;
	Sat, 12 May 2007 20:35:49 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6C0C71F161; Sat, 12 May 2007 20:34:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070512104919.GA22735@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47070>

On Sat, May 12, 2007 at 12:49:19PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-12 11:53:12 +0200, Yann Dirson wrote:
>=20
> > It could even be more sensible to implement transactions at the git
> > level rather than at the stgit one...
>=20
> Yes, please. (Unless a convincing technical argument pops up against
> it, of course.) Any stgit invariant that isn't based on a git
> invariant is one more thing that can break when git and stgit command=
s
> are mixed.

=46or reference, I have written down some design ideas in january[1].
They were written with StGIT in mind, we'll have to see if it
transposes easily to plain git.

I fear it will not be that easy, at least with this design :)

OTOH, implementing transactions in StGIT could provide a first
experience on this particular field, that may later be transposed to
git core - not unlike cogito did for other features.  There is the
risk, however, of seeing a different (hopefully better) design for the
feature in git afterwards, and this in turn is likely to make life
harder for StGIT...

[1] http://marc.info/?t=3D116803935800001&r=3D1&w=3D2

Best regards,
--=20
Yann.
