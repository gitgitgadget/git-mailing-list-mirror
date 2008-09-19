From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Fri, 19 Sep 2008 09:06:12 +0400
Organization: St.Petersburg State University
Message-ID: <20080919050612.GA4423@roro3>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com> <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 07:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgYLi-000110-Nq
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 07:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbYISFOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 01:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbYISFOf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 01:14:35 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:52558 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbYISFOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 01:14:34 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgYQh-0000K3-BJ; Fri, 19 Sep 2008 07:21:19 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgYC4-0001mj-BB; Fri, 19 Sep 2008 09:06:12 +0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96258>

On Thu, Sep 18, 2008 at 03:30:35PM -0400, Daniel Barkalow wrote:
> On Thu, 18 Sep 2008, Bert Wesarg wrote:
>=20
> > On Thu, Sep 18, 2008 at 18:29, Kirill Smelkov <kirr@landau.phys.spb=
u.ru> wrote:
> > > Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> > > ---
> > >  .gitignore |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 8868f2d..aa39db4 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -18,3 +18,5 @@ tg-import.txt
> > >  tg-remote
> > >  tg-remote.txt
> > >  tg
> > > +
> > > +*.swp
> > can't you do this in your .git/info/excludes?
>=20
> It's generally better to put a core.excludesfile entry in your=20
> ~/.gitconfig pointing to a ignore file with editor temporaries for th=
e=20
> editor(s) you personally use. This will then apply to all git project=
s you=20
> work on.

Yes, this makes sense, thanks.

I've had to add the following to my ~/.gitconfig

[core]
    excludesfile=3D /home/kirr/.gitignore-kirr


because it does not work when '~' is used for $HOME

[core]
    excludesfile=3D ~/.gitignore-kirr # does not work


Is it intended?


Still I think since a lot of people have to do the same operation, mayb=
e
it makes sense to put ignores for popular tools right into project's
=2Egitignore.

--=20
    =D0=92=D1=81=D0=B5=D0=B3=D0=BE =D1=85=D0=BE=D1=80=D0=BE=D1=88=D0=B5=
=D0=B3=D0=BE, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB.
