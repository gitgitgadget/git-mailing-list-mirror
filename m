From: Drew Northup <drew.northup@maine.edu>
Subject: Re: groff .ft command use in asciidoc
Date: Thu, 18 Nov 2010 16:11:11 -0500
Message-ID: <1290114671.2316.12.camel@drew-northup.unet.maine.edu>
References: <20101117095233.GA23817@basil.fritz.box>
	 <20101117101516.GA12416@burratino>  <ic3or7$dfi$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 22:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJBlO-0008GR-8e
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 22:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760475Ab0KRVLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 16:11:20 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:60985 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054Ab0KRVLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 16:11:19 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAILBHJs001132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Nov 2010 16:11:17 -0500
In-Reply-To: <ic3or7$dfi$1@dough.gmane.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAILBHJs001132
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1290719477.85165@KDLSayXyeJ5SnY0ogihocA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161711>


On Thu, 2010-11-18 at 17:47 +0000, Alejandro Riveira Fern=C3=A1ndez wro=
te:
> On Wed, 17 Nov 2010 04:15:16 -0600, Jonathan Nieder wrote:
=20
> > This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git's
> > asciidoc.conf will include raw roff directives in the docbook marku=
p it
> > generates.  And then docbook will escape the periods, producing the
> > output you see.
> >=20
> > The workaround is very simple: set ASCIIDOC_NO_ROFF to nonempty whe=
n you
> > build documentation.
>=20
>  I use make quick-install-man which, afaik, installs man pages=20
> "prerendered" from the man branch and i see the same artifact.
> =20
>  So can those man pages be rendered with this workaraound?
> =20
>  Thanks

Out of curiosity I went ahead and ran that make script. I then ran the
following in the directory that the manpage directories were written ou=
t
to (an alternate DESTDIR):

[dnorthup@drew-northup man]$ grep -R "\.ft" *
[dnorthup@drew-northup man]$=20

Note that it returned nothing. This is based on the current git.git. (I
just pulled to be sure of that...)

As noted, all that make script essentially does is write out the
manpages found in origin/man--so it matters not what my current platfor=
m
is.

Run "man git-commit" in one terminal open up a second and run "ps ax |
grep man" and report on the results.=20

--=20
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
