From: "L. A. Linden Levy" <alevy@mobitv.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 09 Sep 2011 10:52:27 -0700
Organization: MobiTV
Message-ID: <1315590747.10046.5.camel@uncle-pecos>
References: <1315514452.10046.0.camel@uncle-pecos>
	 <loom.20110909T115356-849@post.gmane.org>  <4E6A514C.5080200@diamand.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-wJ7hCAQUQWcwQeQmuhBy"
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25Fl-0005aq-Nj
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759591Ab1IIRwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:52:32 -0400
Received: from mxout.myoutlookonline.com ([64.95.72.241]:33176 "EHLO
	mxout.myoutlookonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759380Ab1IIRwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:52:31 -0400
Received: from mxout.myoutlookonline.com (localhost [127.0.0.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id 922328BE756;
	Fri,  9 Sep 2011 13:52:30 -0400 (EDT)
X-Virus-Scanned: by SpamTitan at mail.lan
Received: from mx1.myoutlookonline.com (unknown [10.110.2.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id 324D08BE589;
	Fri,  9 Sep 2011 13:52:30 -0400 (EDT)
Received: from mx1.myoutlookonline.com ([10.9.36.14]) by mx1.myoutlookonline.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Sep 2011 13:52:31 -0400
Received: from [172.16.131.153] ([75.55.199.5]) by mx1.myoutlookonline.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Sep 2011 13:52:31 -0400
In-Reply-To: <4E6A514C.5080200@diamand.org>
X-Mailer: Evolution 2.32.2 
X-OriginalArrivalTime: 09 Sep 2011 17:52:31.0873 (UTC) FILETIME=[3F988F10:01CC6F19]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181099>


--=-wJ7hCAQUQWcwQeQmuhBy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed that it only skipped the edit check. That is why I added the
skipSubmitEdit option. If they are both true then it never opens the
editor and never checks for an edit. Probably they should just be one
option. I think it should probably also be a command line option to skip
the editor.

- Alex

On Fri, 2011-09-09 at 13:47 -0400, Luke Diamand wrote:
> On 09/09/11 11:05, Vitor Antunes wrote:
> > L. A. Linden Levy<alevy<at>  mobitv.com>  writes:
> >
> >>
> >> Hi All,
> >>
> >> I have been using git-p4 for a while and it has allowed me to complete=
ly
> >> change the way I develop and still be able to use perforce which my
> >> company has for its main VCS. One thing that was driving me nuts was
> >> that "git p4 submit" cycles through all of my individual commits and
> >> asks me if I want to change them. The way I develop I often am checkin=
g
> >> in 20 to 50 different small commits each with a descriptive git commen=
t.
> >> I felt like I was doing double duty by having emacs open on every comm=
it
> >> into perforce. So I modified git-p4 to have an option to skip the
> >> editor. This option coupled with git-p4.skipSubmitEditCheck will make
> >> the submission non-interactive for "git p4 submit".
> >
> > Hi Loren,
> >
> > This option was already included in a recent commit. The name that was
> > used is "skipSubmitEditCheck". Please make sure you are using the most
> > recent version of the script.
>=20
> I put that option in - glad it's of use!
>=20
> That option actually just skips the check of 'did the user edit the=20
> file'. git-p4 will still go ahead and bring up the file in the editor fir=
st.
>=20
> I get around this myself by setting EDITOR=3D/bin/true. That works for me=
=20
> because I'm only using it in a script.
>=20
> But it's possible that an additional option would actually be useful.
>=20
>=20
>=20
> >
> > But don't let this discourage you from submitting patches. Just makesur=
e
> > you clone git's repository and apply your patch over "maint" or "master=
"
> > branches. For more details on how to submit patches you can read
> > Documentation/SubmittingPatches.
> >
> > Vitor
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Alex Linden Levy
Senior Software Engineer
MobiTV, Inc.
6425 Christie Avenue, 5th Floor, Emeryville, CA 94608
phone 510.450.5190 mobile 720.352.8394
email alevy@mobitv.com  web www.mobitv.com


--=-wJ7hCAQUQWcwQeQmuhBy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5qUlgACgkQlZX6YS+3Zku82QCgoRxfrlb9nxMKhXq38rLw1Ed0
2pYAnA1K54ycMno+MEA4AdVQ0TMu/LUf
=4jsH
-----END PGP SIGNATURE-----

--=-wJ7hCAQUQWcwQeQmuhBy--
