From: Vampire <Vampire@Masters-of-Disaster.de>
Subject: Re: git svn clone failing
Date: Fri, 25 Feb 2011 01:44:21 +0100
Message-ID: <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
 <1298033812.10893.23.camel@drew-northup.unet.maine.edu> <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
 <1298587459.22431.19.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Feb 25 01:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pslnj-0006ZA-4z
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 01:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab1BYAou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 19:44:50 -0500
Received: from masters-of-disaster.de ([85.214.103.232]:56978 "EHLO
	masters-of-disaster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab1BYAot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 19:44:49 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.69)
	(envelope-from <Vampire@masters-of-disaster.de>)
	id 1Pslnc-0003aV-Af
	for git@vger.kernel.org; Fri, 25 Feb 2011 01:44:48 +0100
Received: by iwn34 with SMTP id 34so656569iwn.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 16:44:41 -0800 (PST)
Received: by 10.42.135.71 with SMTP id o7mr34775ict.196.1298594681057; Thu, 24
 Feb 2011 16:44:41 -0800 (PST)
Received: by 10.231.149.19 with HTTP; Thu, 24 Feb 2011 16:44:21 -0800 (PST)
In-Reply-To: <1298587459.22431.19.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167870>

I tried it with 1.6.3.3 and with a self-compiled version from latest gi=
t code.

2011/2/24 Drew Northup <drew.northup@maine.edu>
>
> On Fri, 2011-02-18 at 15:21 +0100, Vampire wrote:
> > Hi Drew,
> >
> > SVN client is in version 1.6.5.
> > svn co http://svn.apache.org/repos/asf/ant/core/trunk .
> > works fine and without problem.
> > I guess it is in the phase of searching for history in other places=
 in
> > the repository and there some place is accessed that is password
> > protected.
> > I did not contact the server admin as the normal svn client works f=
ine
> > and so it seems to be a problem of git-svn, not of the SVN server.
> > Did you try the command I gave you and does it succeed for you? It =
is
> > a publicly available repository so you should be able to reproduce =
the
> > problem.
> >
> > Regards
> > Bj=F6rn
>
> The error is reproducible, and I'm running a newer subversion client
> than you are. It definitely isn't making it through all of the revisi=
ons
> available before dying.
>
> .....
> Checked through r161300
> Checked through r161400
> RA layer request failed: Server sent unexpected return value (403 For=
bidden) in response to REPORT request for '/repos/asf/!svn/vcc
> /default' at /usr/libexec/git-core/git-svn line 5131
>
> I forgot to ask, which version git are you running? I am running 1.7.=
4
> on the machine I tried this (RHEL5 RPM, compiled locally).
>
> > 2011/2/18 Drew Northup <drew.northup@maine.edu>:
> > >
> > > On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
> > >> Hi,
> > >>
> > >> I'm trying to issue the following command:
> > >>
> > >> git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/co=
re/ .
> > >>
> > >> But unfortunately this fails after some time with the message:
> > >>
> > >> RA layer request failed: Server sent unexpected return value (40=
3
> > >> Forbidden) in response to REPORT request for
> > >> '/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn line =
4354
> > >>
> > >> Regards
> > >> Bj=F6rn
> > >
> > > Bj=F6rn,
> > > Have you made sure your subversion client is up-to-date? Does thi=
s work
> > > as a plain svn clone? Have you contacted the server admin?
> > > Without context we cannot act on this.
> > >
>
> --
> -Drew Northup
> ________________________________________________
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>
