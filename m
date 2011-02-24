From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git svn clone failing
Date: Thu, 24 Feb 2011 17:44:19 -0500
Message-ID: <1298587459.22431.19.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
	 <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
	 <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vampire <Vampire@masters-of-disaster.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 23:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psjvg-0001XF-7z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 23:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab1BXWoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 17:44:55 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:45845 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1BXWoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 17:44:54 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1OMiPtI009779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Feb 2011 17:44:25 -0500
In-Reply-To: <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1OMiPtI009779
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299192278.55052@3KUBRhBjmk6wH/PoS5xTDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167868>


On Fri, 2011-02-18 at 15:21 +0100, Vampire wrote:
> Hi Drew,
>=20
> SVN client is in version 1.6.5.
> svn co http://svn.apache.org/repos/asf/ant/core/trunk .
> works fine and without problem.
> I guess it is in the phase of searching for history in other places i=
n
> the repository and there some place is accessed that is password
> protected.
> I did not contact the server admin as the normal svn client works fin=
e
> and so it seems to be a problem of git-svn, not of the SVN server.
> Did you try the command I gave you and does it succeed for you? It is
> a publicly available repository so you should be able to reproduce th=
e
> problem.
>=20
> Regards
> Bj=C3=B6rn

The error is reproducible, and I'm running a newer subversion client
than you are. It definitely isn't making it through all of the revision=
s
available before dying.

=2E....
Checked through r161300
Checked through r161400
RA layer request failed: Server sent unexpected return value (403 Forbi=
dden) in response to REPORT request for '/repos/asf/!svn/vcc
/default' at /usr/libexec/git-core/git-svn line 5131

I forgot to ask, which version git are you running? I am running 1.7.4
on the machine I tried this (RHEL5 RPM, compiled locally).

> 2011/2/18 Drew Northup <drew.northup@maine.edu>:
> >
> > On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
> >> Hi,
> >>
> >> I'm trying to issue the following command:
> >>
> >> git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/core=
/ .
> >>
> >> But unfortunately this fails after some time with the message:
> >>
> >> RA layer request failed: Server sent unexpected return value (403
> >> Forbidden) in response to REPORT request for
> >> '/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn line 43=
54
> >>
> >> Regards
> >> Bj=C3=B6rn
> >
> > Bj=C3=B6rn,
> > Have you made sure your subversion client is up-to-date? Does this =
work
> > as a plain svn clone? Have you contacted the server admin?
> > Without context we cannot act on this.
> >

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
