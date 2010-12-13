From: Sylvestre Ledru <sylvestre.ledru@scilab.org>
Subject: Re: Corruption in the repository
Date: Mon, 13 Dec 2010 17:47:25 +0100
Message-ID: <1292258845.25237.27680.camel@korcula.inria.fr>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	 <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 17:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBYj-0002c7-95
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985Ab0LMQr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 11:47:28 -0500
Received: from santostefano.inria.fr ([193.51.192.151]:34577 "HELO
	santostefano.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750759Ab0LMQr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 11:47:27 -0500
Received: (qmail 12628 invoked by uid 1001); 13 Dec 2010 17:47:26 +0100
Received: from korcula.inria.fr by santostefano (envelope-from <sylvestre.ledru@scilab.org>, uid 92) with qmail-scanner-2.02st 
 (clamdscan: 0.90.1/7197. spamassassin: 3.1.7-deb. perlscan: 2.02st.  
 Clear:RC:1(193.51.192.130):. 
 Processed in 0.021226 secs); 13 Dec 2010 16:47:26 -0000
Received: from korcula.inria.fr (HELO ?193.51.192.130?) (193.51.192.130)
  by santostefano.inria.fr with SMTP; 13 Dec 2010 17:47:25 +0100
In-Reply-To: <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163564>


Le lundi 13 d=C3=A9cembre 2010 =C3=A0 17:34 +0100, Christian Couder a =C3=
=A9crit :
> Hi,
>=20
> On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
> <sylvestre.ledru@scilab.org> wrote:
> > Hello guys,
> >
> > I have a small problem with a git repository and I haven't find a w=
ay to
> > fix my problem.
> > I am using git with gerrit [1] as frontend (even if I don't think i=
t is
> > related here).
> > For an unknown reason, the repository just became corrupted.
> >
> > When I try to clone the repository straight with the file system, t=
he
> > following error is displayed:
> > error: refs/changes/98/398/1 does not point to a valid object!
> > error: refs/changes/98/398/2 does not point to a valid object!
> > fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corrupted
> > fatal: The remote end hung up unexpectedly
> >
> > git-prune & git-fsck both fail.
> >
> > Does anyone know how to repair this error ?
>=20
> Did you try what the FAQ suggests:
>=20
> https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repo=
sitory.3F
Yes. It shows an other error and it doesn't match the error described o=
n
this URL [1].

I get the following:
error: refs/tags/5.3.0-beta-4 does not point to a valid object!
fatal: object 555a7c359b2e589ec10822d9b56cdfeee0105fe0 is corrupted

Sylvestre

[1]
$ git fsck --full
> broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
>              to    blob 4b9458b3786228369c63936db65827de3cc06200
> missing blob 4b9458b3786228369c63936db65827de3cc06200
