From: Vampire <Vampire@Masters-of-Disaster.de>
Subject: Re: git svn clone failing
Date: Sun, 3 Apr 2011 02:21:14 +0200
Message-ID: <BANLkTine4g7LyiXmE6zYpNs7aa2FfXYGUg@mail.gmail.com>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
 <1298033812.10893.23.camel@drew-northup.unet.maine.edu> <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
 <1298587459.22431.19.camel@drew-northup.unet.maine.edu> <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Apr 03 02:21:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6B4e-0003dG-FE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 02:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab1DCAVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 20:21:44 -0400
Received: from masters-of-disaster.de ([85.214.103.232]:48867 "EHLO
	masters-of-disaster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376Ab1DCAVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 20:21:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.69)
	(envelope-from <Vampire@masters-of-disaster.de>)
	id 1Q6B4X-0007GB-QL
	for git@vger.kernel.org; Sun, 03 Apr 2011 02:21:41 +0200
Received: by iyb14 with SMTP id 14so4764984iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 17:21:34 -0700 (PDT)
Received: by 10.42.139.197 with SMTP id h5mr5237095icu.243.1301790094349; Sat,
 02 Apr 2011 17:21:34 -0700 (PDT)
Received: by 10.231.79.65 with HTTP; Sat, 2 Apr 2011 17:21:14 -0700 (PDT)
In-Reply-To: <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170668>

Any news on this one?

2011/2/25 Vampire <Vampire@masters-of-disaster.de>
>
> I tried it with 1.6.3.3 and with a self-compiled version from latest =
git code.
>
> 2011/2/24 Drew Northup <drew.northup@maine.edu>
> >
> > On Fri, 2011-02-18 at 15:21 +0100, Vampire wrote:
> > > Hi Drew,
> > >
> > > SVN client is in version 1.6.5.
> > > svn co http://svn.apache.org/repos/asf/ant/core/trunk .
> > > works fine and without problem.
> > > I guess it is in the phase of searching for history in other plac=
es in
> > > the repository and there some place is accessed that is password
> > > protected.
> > > I did not contact the server admin as the normal svn client works=
 fine
> > > and so it seems to be a problem of git-svn, not of the SVN server=
=2E
> > > Did you try the command I gave you and does it succeed for you? I=
t is
> > > a publicly available repository so you should be able to reproduc=
e the
> > > problem.
> > >
> > > Regards
> > > Bj=F6rn
> >
> > The error is reproducible, and I'm running a newer subversion clien=
t
> > than you are. It definitely isn't making it through all of the revi=
sions
> > available before dying.
> >
> > .....
> > Checked through r161300
> > Checked through r161400
> > RA layer request failed: Server sent unexpected return value (403 F=
orbidden) in response to REPORT request for '/repos/asf/!svn/vcc
> > /default' at /usr/libexec/git-core/git-svn line 5131
> >
> > I forgot to ask, which version git are you running? I am running 1.=
7.4
> > on the machine I tried this (RHEL5 RPM, compiled locally).
> >
> > > 2011/2/18 Drew Northup <drew.northup@maine.edu>:
> > > >
> > > > On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
> > > >> Hi,
> > > >>
> > > >> I'm trying to issue the following command:
> > > >>
> > > >> git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/=
core/ .
> > > >>
> > > >> But unfortunately this fails after some time with the message:
> > > >>
> > > >> RA layer request failed: Server sent unexpected return value (=
403
> > > >> Forbidden) in response to REPORT request for
> > > >> '/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn lin=
e 4354
> > > >>
> > > >> Regards
> > > >> Bj=F6rn
> > > >
> > > > Bj=F6rn,
> > > > Have you made sure your subversion client is up-to-date? Does t=
his work
> > > > as a plain svn clone? Have you contacted the server admin?
> > > > Without context we cannot act on this.
> > > >
> >
> > --
> > -Drew Northup
> > ________________________________________________
> > "As opposed to vegetable or mineral error?"
> > -John Pescatore, SANS NewsBites Vol. 12 Num. 59
> >
