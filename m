From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 21:50:50 +0400
Organization: St.Petersburg State University
Message-ID: <20080918175050.GM11602@roro3>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com> <20080918174307.GL11602@roro3> <36ca99e90809181056i534cffc8td8095140db4949bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 20:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNne-0001Sg-RA
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbYIRR7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 13:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbYIRR7I
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:59:08 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:39527 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbYIRR7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:59:07 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgNt5-00009r-LC; Thu, 18 Sep 2008 20:05:55 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgNeU-0003BN-Lw; Thu, 18 Sep 2008 21:50:50 +0400
Content-Disposition: inline
In-Reply-To: <36ca99e90809181056i534cffc8td8095140db4949bf@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96233>

On Thu, Sep 18, 2008 at 07:56:40PM +0200, Bert Wesarg wrote:
> On Thu, Sep 18, 2008 at 19:43, Kirill Smelkov <kirr@landau.phys.spbu.=
ru> wrote:
> > On Thu, Sep 18, 2008 at 07:38:58PM +0200, Bert Wesarg wrote:
> >> On Thu, Sep 18, 2008 at 18:29, Kirill Smelkov <kirr@landau.phys.sp=
bu.ru> wrote:
> >> > Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> >> > ---
> >> >  .gitignore |    2 ++
> >> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/.gitignore b/.gitignore
> >> > index 8868f2d..aa39db4 100644
> >> > --- a/.gitignore
> >> > +++ b/.gitignore
> >> > @@ -18,3 +18,5 @@ tg-import.txt
> >> >  tg-remote
> >> >  tg-remote.txt
> >> >  tg
> >> > +
> >> > +*.swp
> >> can't you do this in your .git/info/excludes?
> >>
> >> bert
> >
> > I sure can, but I think the question is what is the most convenient=
, and
> > for me it is convenient to start hacking right on fresh topgit clon=
e.
> >
> >
> > Also, if you'll look e.g. here:
> >
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f=3D.gitignore;h=3D869e1a3b64b6bf969eeced820691e955e03e3068;hb=
=3DHEAD#l65
> >
> > It seems emacs is supported in Linux kernel, so I'm slowly restorin=
g the
> > balance in favour of vim :)
> than I want a pattern for NEdit too:
>=20
> ~*

I'm not against :)

--=20
    =D0=92=D1=81=D0=B5=D0=B3=D0=BE =D1=85=D0=BE=D1=80=D0=BE=D1=88=D0=B5=
=D0=B3=D0=BE, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB.
