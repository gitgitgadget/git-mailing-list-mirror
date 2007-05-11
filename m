From: Yann Dirson <ydirson@altern.org>
Subject: Re: Using StGIT for tweaking already-committed stuff
Date: Fri, 11 May 2007 22:40:17 +0200
Message-ID: <20070511204016.GH19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz> <20070510222347.GB12366@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 22:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmbvb-0006Uc-Uj
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbXEKUlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbXEKUlX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:41:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58571 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXEKUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:41:22 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6DFD15ED87;
	Fri, 11 May 2007 22:41:20 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 17D6B1F161; Fri, 11 May 2007 22:40:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070510222347.GB12366@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46983>

On Fri, May 11, 2007 at 12:23:47AM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-10 22:02:53 +0200, Petr Baudis wrote:
> > Yes, I fear that StGIT hides the index in a similar way that Cogito
> > does. It seems like user index usage is undergoing kind of
> > renaissance these days in Git community (at least it seems to me
> > this way, maybe it's always been this way), it would probably make
> > sense to allow making use of index in StGIT as well.
>=20
> I agree. It's bad UI for StGIT to behave different from git, given
> that easy interoperation is a goal.

Well, that's an idea that already appeared in some discussions - I
can't speak for Catalin, but I too think it could be a good thing.

Eg, if we're going to use the patchlogs a bit more (and I wish so), it
will be much less cluttered by using the index to select what to
commit with several git-add's, than when using several stg-refresh's.

As noted elsewhere, there are some commands that are a bit superfluous
(add, rm, and the branch-switching feature directly come to mind).  It
is especially annoying, eg when "stg rm" behaves differently than "git
rm", by not removing the real file.  I have tried recently to avoid
using "git add" and "stg rm", and I am quite pleased with that :)


> > And yes, it would be cool if stg new could guess patch name from th=
e
> > subject line in a similar manner that stg uncommit does.
>=20
> Good idea. This would be embarrassingly easy to do.
>=20
> But you can kind of do it today. Just commit with git (my favorite
> here is the emacs modes) and "stg assimilate"!

Well, that's arguably a non-orthodox way of doing things, I like the
idea your "stg new" patch much better :)

Best regards,
--=20
Yann.
