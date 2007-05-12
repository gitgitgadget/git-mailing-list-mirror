From: Yann Dirson <ydirson@altern.org>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 16:41:45 +0200
Message-ID: <20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070512140228.GB28039@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 16:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmsoD-0001RX-P6
	for gcvg-git@gmane.org; Sat, 12 May 2007 16:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbXELOmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXELOmx
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 10:42:53 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49382 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbXELOmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 10:42:52 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9337B5E1B4;
	Sat, 12 May 2007 16:42:51 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A6FD31F161; Sat, 12 May 2007 16:41:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070512140228.GB28039@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47051>

On Sat, May 12, 2007 at 04:02:28PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-12 13:34:30 +0200, Yann Dirson wrote:
>=20
> > I really think we should have a "stg uninit" command. Note that
> > currently "stg branch --delete" on master will just do that instead
> > of really deleting the branch, but that is a known bug (#8732 on
> > gna).
>=20
> What we should do is delete all stgit metadata when the last patch
> goes away.

This supposes there is no valuable branch-level metadata.  Currently
we have the description - something which could arguably be moved to
the git level as well.  Otherwise that sounds reasonable to me.

> And we shouldn't have "stg init", either. Initing should be done
> automatically when needed.

Good idea as well, that would make stg more accessible to the average
plain-git user.

Best regards,
--=20
Yann.
