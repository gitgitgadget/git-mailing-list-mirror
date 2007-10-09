From: Yann Dirson <ydirson@altern.org>
Subject: Re: Status of kha/experimental
Date: Tue, 9 Oct 2007 23:46:13 +0200
Message-ID: <20071009214613.GC26436@nan92-1-81-57-214-146.fbx.proxad.net>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com> <20071007213307.GA32210@diana.vm.bytemark.co.uk> <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMxQ-0004tU-8c
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXJIVtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 17:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbXJIVtb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:49:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48319 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbXJIVta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:49:30 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8AAC517B543;
	Tue,  9 Oct 2007 23:49:28 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5E98C17B528;
	Tue,  9 Oct 2007 23:49:28 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6660C1F20E; Tue,  9 Oct 2007 23:46:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60450>

On Tue, Oct 09, 2007 at 10:10:12PM +0100, Catalin Marinas wrote:
> On 07/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2007-10-07 22:18:44 +0100, Catalin Marinas wrote:
> >
> > > How stable is the kha/experimental branch? Since there are more a=
nd
> > > more bugs added to the tracking system, I'll have to start lookin=
g
> > > at them before a 0.14 release. Is it worth merging the
> > > kha/experimental now or we better wait for after 0.14?
> >
> > The idea is that experimental contains changes that need testing, b=
ut
> > may not yet be ready for your master. (They are generally safe,
> > though; I run StGit from my experimental branch at work, for exampl=
e.)
> > When I decide that they are ready, I move them to safe. If there ar=
e
> > any patches you feel should be in safe rather than experimental, ju=
st
> > ask. Or you could just take them directly from experimental without
> > asking, of course. :-)
>=20
> OK. My plan is to merge kha/safe and have a look at what seems safer
> to merge from kha/experimental. Fix bugs (and freeze the current
> features). Release 0.14. Merge kha/experimental entirely post 0.14 an=
d
> test/stabilize it over couple of months. How does this sound?

Sounds like a good time to bring back my refactoring patches from the
hydra patchset.  I have not addressed yet the remarks that were voiced
at that time, and the hydra patch itself has not been completed, and
in fact the refactorings touch so many parts of the code that I can't
envision mantaining them outside the tree (in fact, I left them bitrot
for that very reason).  If there is no other remarks than those
already posted as replies to the patchset, maybe we could consider
merging them soon after kha/experimental ?

That would require that I update them, but I'm not sure Karl would
want them in kha/experimental, since virtually any other patch causes
a conflict...  The best situation would be that there would be a code
freeze at some time, during which I could update those patches without
too much perturbations, but that may be asking a lot :)

The ideal situation would be if we would make diffcore and merge aware
of a (de)indentation type of change.  That's something I have felt the
need for since ages, but I'm unfortunately not going to find the time
to implement that anytime soon :)

Best regards,
--=20
Yann
