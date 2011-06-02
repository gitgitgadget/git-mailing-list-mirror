From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git svn clone failing
Date: Thu, 02 Jun 2011 08:55:08 -0400
Message-ID: <1307019308.28941.4.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
	 <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
	 <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
	 <1298587459.22431.19.camel@drew-northup.unet.maine.edu>
	 <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
	 <BANLkTine4g7LyiXmE6zYpNs7aa2FfXYGUg@mail.gmail.com>
	 <BANLkTin7bxu_XZVYaVy+eXuhcJR83hXSew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vampire <Vampire@Masters-of-Disaster.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS7Qu-0008Vx-2R
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553Ab1FBMzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 08:55:23 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:46551 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933510Ab1FBMzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 08:55:22 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p52CtB9c024675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Jun 2011 08:55:11 -0400
In-Reply-To: <BANLkTin7bxu_XZVYaVy+eXuhcJR83hXSew@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p52CtB9c024675
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307624112.44594@vhexdK7jwbYkFPd/E4HrCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174946>


On Thu, 2011-06-02 at 14:22 +0200, Vampire wrote:
> Drew?
>=20
I have no idea. If anybody else on the list does I'd welcome it, but I
don't have any more time I can spend on this.

> 2011/4/3 Vampire <Vampire@masters-of-disaster.de>
>         Any news on this one?
>        =20
>        =20
>         2011/2/25 Vampire <Vampire@masters-of-disaster.de>
>         >
>         > I tried it with 1.6.3.3 and with a self-compiled version
>         from latest git code.
>         >
>         > 2011/2/24 Drew Northup <drew.northup@maine.edu>
>         > >
>         > > On Fri, 2011-02-18 at 15:21 +0100, Vampire wrote:
>         > > > Hi Drew,
>         > > >
>         > > > SVN client is in version 1.6.5.
>         > > > svn co http://svn.apache.org/repos/asf/ant/core/trunk .
>         > > > works fine and without problem.
>         > > > I guess it is in the phase of searching for history in
>         other places in
>         > > > the repository and there some place is accessed that is
>         password
>         > > > protected.
>         > > > I did not contact the server admin as the normal svn
>         client works fine
>         > > > and so it seems to be a problem of git-svn, not of the
>         SVN server.
>         > > > Did you try the command I gave you and does it succeed
>         for you? It is
>         > > > a publicly available repository so you should be able t=
o
>         reproduce the
>         > > > problem.
>         > > >
>         > > > Regards
>         > > > Bj=C3=B6rn
>         > >
>         > > The error is reproducible, and I'm running a newer
>         subversion client
>         > > than you are. It definitely isn't making it through all o=
f
>         the revisions
>         > > available before dying.
>         > >
>         > > .....
>         > > Checked through r161300
>         > > Checked through r161400
>         > > RA layer request failed: Server sent unexpected return
>         value (403 Forbidden) in response to REPORT request for
>         '/repos/asf/!svn/vcc
>         > > /default' at /usr/libexec/git-core/git-svn line 5131
>         > >
>         > > I forgot to ask, which version git are you running? I am
>         running 1.7.4
>         > > on the machine I tried this (RHEL5 RPM, compiled locally)=
=2E
>         > >
>         > > > 2011/2/18 Drew Northup <drew.northup@maine.edu>:
>         > > > >
>         > > > > On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
>         > > > >> Hi,
>         > > > >>
>         > > > >> I'm trying to issue the following command:
>         > > > >>
>         > > > >> git svn clone --stdlayout
>         http://svn.apache.org/repos/asf/ant/core/ .
>         > > > >>
>         > > > >> But unfortunately this fails after some time with th=
e
>         message:
>         > > > >>
>         > > > >> RA layer request failed: Server sent unexpected
>         return value (403
>         > > > >> Forbidden) in response to REPORT request for
>         > > > >> '/repos/asf/!svn/vcc/default'
>         at /usr/lib/git-core/git-svn line 4354
>         > > > >>
>         > > > >> Regards
>         > > > >> Bj=C3=B6rn
>         > > > >
>         > > > > Bj=C3=B6rn,
>         > > > > Have you made sure your subversion client is
>         up-to-date? Does this work
>         > > > > as a plain svn clone? Have you contacted the server
>         admin?
>         > > > > Without context we cannot act on this.
>         > > > >
>         > >
>         > > --
>         > > -Drew Northup
>         > > ________________________________________________
>         > > "As opposed to vegetable or mineral error?"
>         > > -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>         > >
>        =20

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
