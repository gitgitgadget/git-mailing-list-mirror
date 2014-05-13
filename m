From: William Giokas <1007380@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 14:39:11 -0500
Message-ID: <20140513193911.GG9051@wst420>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
 <20140513184800.GF9051@wst420>
 <53726e0355875_4aa4b312f892@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 21:39:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkIY7-0005ox-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 21:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbaEMTjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 15:39:35 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64808 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbaEMTje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 15:39:34 -0400
Received: by mail-ie0-f170.google.com with SMTP id ar20so839012iec.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=c14E6uMsNWFdebe8Iivp/EefNs5NBA4jLdHcjWW7hz8=;
        b=c7ltB6Pwq8ItQPX16fFN9YAlfSChQ2t9xcWQm+PVrlp3pY99OxXEaGH5jFa9bRq0Pa
         V3417nDuOVHXkbepPe+EvgC4hZPazpSbOgZQsqeD/RN2BnHdiF1I7fHXOf9S68vl4An7
         WZ3ZHBLZXUgTxev8HLuX9LsijjNN9MfEQkwpaspMzG48YXN/J8dAd1i3oljpSTDgsshv
         Y6gaUPyXcJ8WIVTaPmVVncScRHZPUlir4x606yzgg7vyxLMuWsUhkZ+YvnQTn5p2RhTo
         rizkZsdMoGKkCIaAo5dcJBVlB8+wRkyoaRTD8ERPg5kjOyJ2uOkesXhHAns8uwe8gHvW
         SRUg==
X-Received: by 10.42.58.130 with SMTP id i2mr1328152ich.66.1400009973768;
        Tue, 13 May 2014 12:39:33 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id sc2sm32218307igb.5.2014.05.13.12.39.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 12:39:33 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53726e0355875_4aa4b312f892@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248810>


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 02:09:55PM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > On Tue, May 13, 2014 at 10:30:26AM -0700, Junio C Hamano wrote:
>=20
> > >     Why do we "import changegroup" unconditionally, even though it
> > >     is only used in the new codepath meant only for version 3.0 or
> > >     higher, not inside the "if" block that decides if we need that
> > >     module?=20
>=20
> > changegroup is prefectly /okay/ to import unconditionally, though as you
> > say it will never be used.
>=20
> As you say, it's perfectly OK.

But wrong. Yes, it works, but it's not how it should be done when we
have a code review such as this. It should simply not be done and makes
no sense to do with an 'if <check ver>; else' kind of thing later in the
application.

>=20
> > We can also be even more explicit with what we import by doing something
> > like::
> >=20
> >   try:
> >       from mercurial.changegroup import getbundle
> >=20
> >   except ImportError:
> >       def getbundle(__empty__, **kwargs):
> >           return repo.getbundle(**kwargs)
>=20
> We could try that, but that would assume we want to maintain getbundle()
> for the long run, and I personally don't want to do that. I would rather
> contact the Mercurial developers about ways in which the push() method
> can be improved so we don't need to have our own version. Hopefully
> after it's improved we wouldn't have to call getbundle().

Assuming that mercurial <3.0 will not change, then this should never
need to change. Changes in 'getbundle' upstream would require changes
either way.

> Moreover, eventually there will be a Mercurial 4.0, even 5.0, and at
> some point we would want to remove the hacks for older versions. When we
> do so we would want the import to remain unconditionally, and remove the
> 'check_version(3, 0)' which is already helping to explain what the code
> is for without the need of comments.

The same exact thing can be done with this. In fact, it would probably
allow us to have better future-proofing with regards to new versions of
mercurial, there would just be different try:except statements at the
beginning.

>=20
> > I was really sad to see that, and didn't have time to really look at it
> > because of work and other projects, but I hope this presents a better
> > solution than the current patch.
>=20
> Either way Junio doesn't maintain this code, I do. And it's not
> maintained in git.git, git's maintained out-of-tree (thanks to Junio's
> decisions).

I still see it in git.git, and I will contribute this upstream for as
long as it is in the tree. If you want to use the patch that I sent to
this list, feel free.

> So please post your suggestions and patches to git-fc@googlegroups.com,
> and use the latest code at https://github.com/felipec/git-remote-hg.

Thanks,

--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcnTfAAoJEGkCBthzzQnPVIYQAIm5znvbzbdA2VFPtxSUXNr+
jIS8i4xzGpmuwIUvYoom1sWiOe9Ox1DnPVQRWbJpkz6so6BLG9Uc+qUTIRLGJOdU
COcy3qYVI5dkFNJvf05ke6+8LGR5goeYezafC50x7B13QCNlxu0YRkqYbnMib6JC
SGBaWLENQCoaiqBxSufR+pp+xpu4sLFzzVqG1YyXHRx0hsg3RfN9gB6H72RPrtwH
WMAbIJ3dfG4Sl9AonJ9xF68BcULBa04wnUVCVenS5dF873fPM3ljIikYoumpYkt5
8nEmp31ExTL9ZvopQ/5zUf3W2/dUSKm4oZsjRzj53EMhJs1FJ46mVs3edfU0Y4oT
M5OYSGQbwHWfkUW6zhOGM+lflRy1mVgrO0B9+dnfsqsl5P0LNRIMCxuVw/pRwUA8
ScRIXvAATA2A9PcTu/8lSmkCk89MmMwR4e9/n4MMPlBQdzVDu7PCtJh2VmUGQcvN
D/mKoGzgEuVvmhbNYoLZc49/nZrYRw/wfZyBjDlmszW36ZjD2ajNdei+RIhab82B
dlSCGsmhqHZ1cBd64NACjcF9Nze+TPA5Q2n+GMAQpDSVRR0cEXqEr9VxFuxzZUit
YJT8s188F1Vve/AZoB6fwBZfWM/2G4WhpoRnZUTSvqpm0NQesyPsi0FjlG4fW1q5
6hXaAEk9+VysGbngVhLg
=Mo/X
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
