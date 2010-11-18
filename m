From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 00:15:14 +0100
Message-ID: <20101119001514.4cd0c4d9@varda>
References: <20101117095233.GA23817@basil.fritz.box>
	<20101117101516.GA12416@burratino>
	<ic3or7$dfi$1@dough.gmane.org>
	<1290114671.2316.12.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Nov 19 00:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJDhV-0004QN-Bd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 00:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760374Ab0KRXP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 18:15:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48027 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759975Ab0KRXP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 18:15:26 -0500
Received: by wyb28 with SMTP id 28so3803703wyb.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sS1aIn1t2H78xh+KEpiSur0nldshcPhoZBAZOSkWPQk=;
        b=EPcmHL48W1oR+YNGmHMuoIkf46WrBmBABN04fSxiZnvE6X4ZIaoR6bTlyi3DnTXLyk
         wYlupdP/PFDfIhFQi3MBJof8Z+leFf5AbIryaL+KgkgcMbwgXozWJ4ZmxPASPyQuFCsg
         CVqcRsU7io9syc/2mWUZYMRCdFqBfdyLui7m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=CHwBbcyTBZ+o7gJOS3Jrl82BSS7mY2wwRYTZLkToebp4I0B67tnBudUHK0DMKkXLZH
         WONaedeb01wXUXcHAFd9Filz6Fdh+1Er+vdQBHTEgS4x0VQbu+JNd223Hf94hNmOOxgs
         wCR5wComaS0ytTDaySvuwqaScL/J7vtC/dIqQ=
Received: by 10.216.46.65 with SMTP id q43mr1028072web.114.1290122124811;
        Thu, 18 Nov 2010 15:15:24 -0800 (PST)
Received: from varda (156.Red-81-38-65.dynamicIP.rima-tde.net [81.38.65.156])
        by mx.google.com with ESMTPS id e12sm503101wer.36.2010.11.18.15.15.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 15:15:23 -0800 (PST)
In-Reply-To: <1290114671.2316.12.camel@drew-northup.unet.maine.edu>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161716>

El Thu, 18 Nov 2010 16:11:11 -0500
Drew Northup <drew.northup@maine.edu> escribi=C3=B3:

>=20
> On Thu, 2010-11-18 at 17:47 +0000, Alejandro Riveira Fern=C3=A1ndez w=
rote:
> > On Wed, 17 Nov 2010 04:15:16 -0600, Jonathan Nieder wrote:
> =20
> > > This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git=
's
> > > asciidoc.conf will include raw roff directives in the docbook mar=
kup it
> > > generates.  And then docbook will escape the periods, producing t=
he
> > > output you see.
> > >=20
> > > The workaround is very simple: set ASCIIDOC_NO_ROFF to nonempty w=
hen you
> > > build documentation.
> >=20
> >  I use make quick-install-man which, afaik, installs man pages=20
> > "prerendered" from the man branch and i see the same artifact.
> > =20
> >  So can those man pages be rendered with this workaraound?
> > =20
> >  Thanks
>=20
> Out of curiosity I went ahead and ran that make script. I then ran th=
e
> following in the directory that the manpage directories were written =
out
> to (an alternate DESTDIR):

 Doh! ... the problem was between chair and keyboard. i used alternate =
DESTDIR
 with the make all and make install but with quick.-install-man i forgo=
t to set=20
 it; so the man pages were old versions from when i actually builded th=
e man
 pages myself
 Sorry for the wasted time ...

>=20
> [dnorthup@drew-northup man]$ grep -R "\.ft" *
> [dnorthup@drew-northup man]$=20
>=20
 After correcting the above
 $ grep -R "\.ft" *
 man3/private-Error.3pm:.ft CW
 man3/private-Error.3pm:.ft R
 man3/Git.3pm:.ft CW
 man3/Git.3pm:.ft R
=20
 Which are probably letfovers from previous builds ...
  =20
> Note that it returned nothing. This is based on the current git.git. =
(I
> just pulled to be sure of that...)

 Thanks for checking and again. Sorry

>=20
> As noted, all that make script essentially does is write out the
> manpages found in origin/man--so it matters not what my current platf=
orm
> is.
>=20
> Run "man git-commit" in one terminal open up a second and run "ps ax =
|
> grep man" and report on the results.=20

 For the sake of completeness
  $ ps ax | grep man
    585 ?        S<     0:00 [kondemand]
   4994 ?        S      0:00 gnome-power-manager
  32649 pts/2    S+     0:00 man git-commit
  32690 pts/4    S+     0:00 grep man

 Bye.
