Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02E182CB
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lh8LKOBH"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78451BF
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:24:35 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A18875B099;
	Fri, 27 Oct 2023 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698405874;
	bh=c9fQf09awmhsSHusvCmLSTSfil53tDz0cTW6lqOtwIo=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lh8LKOBHiSBu9R5o2OBYSKkyUHEHzCWOiawmYu3LWwgS7XC2oEviJ9/S6KTV5eyBw
	 PjPtX3eJA3OpSEi6zC717WJyJ0HeWDfku9DFANVSoKud/TeJRuaRrOEwLcS3g5OApP
	 zAgAazlIUh9zlcS0TR0r2QYwGQPCokRo+5nnw57PF9HBN8fQNgRTeqq/KqJjIUIy/8
	 Vd4mSLOtGcH97x9RLbd2Xrjx9tVx0/GmM6rWrfigerkQMj1wIrOUtwiTYpkQLVDVby
	 fdNzLevrLWSBO6DBZVMgJsP62p8cjDlkpQtOS1cxSLEuJAWDBkgxolozk00odrLwSv
	 UPMdYh+HRFVQ56KymLgwxYXabr0sQs23OUuS0XY8CkHOcwlJRriKpQOLsOk90anp9Y
	 1b/36XDUi/7OwYUjGeULNvmYWtw3tTqZ0ZW4SZtjeoemYb215XpSdPkDsp+/4JL0pV
	 D4kEOzxoOF2zhJmpJRVeTurn+TbDU6w0Jk74JOVaiIIrXGen7Jo
Date: Fri, 27 Oct 2023 11:24:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: John <john@quantbo.com>, git@vger.kernel.org
Subject: Re: GFW fails with ST3 on Windows 11
Message-ID: <ZTud8HxDxK1UgLCR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	John <john@quantbo.com>, git@vger.kernel.org
References: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
 <ZTuCHVwAhAGJcQDd@tapette.crustytoothpaste.net>
 <e1de1948-8604-4c8f-961b-d214efa4ed84@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8YsGNmJk1WTYkG8i"
Content-Disposition: inline
In-Reply-To: <e1de1948-8604-4c8f-961b-d214efa4ed84@app.fastmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--8YsGNmJk1WTYkG8i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 at 09:59:47, John wrote:
> Brian,
>=20
> Thanks very much for your suggestions. Unfortunately, after each command,=
 I continue to get the same error messages noted in my original email.
>=20
> Any Windows 11 experts out there--please help.
>=20
> John
>=20
> On Fri, 27 Oct 2023, at 16:25, brian m. carlson wrote:
> > On 2023-10-27 at 07:31:32, John wrote:
> >> I have been using Sublime Text 3 as the editor on Git for Windows for =
years, on Windows 10. I recently purchased a Windows 11 machine. On that ma=
chine, when I give GFW the following command, I get the response shown:
> >>=20
> >> $ git commit -a
> >> [=E2=80=A6]
> >> hint: Waiting for your editor to close the file=E2=80=A6 C:\Program Fi=
les\Sublime Text 3\sublime_text.exe: C:Program: command not found
> >> error: There was a problem with the editor =E2=80=98C:\Program Files\S=
ublime Text 3\sublime_text.exe=E2=80=99.
> >> Please supply the message using either -m or -F option.
> >
> > I think the "command not found" indicates that you may have specified
> > your editor incorrectly.  In Git Bash, can you try the following
> > commands, one at a time, and then commit between each one to see if one
> > of them works?
> >
> >   git config --global core.editor '"C:/Program Files/Sublime Text=20
> > 3/sublime_text.exe"'
> >   git config --global core.editor '"C:\Program Files\Sublime Text=20
> > 3\sublime_text.exe"'
> >
> > I believe that both should work here.
> >
> > My guess is that this is the situation hinted at in the FAQ[0], where,
> > because the editor is passed to the shell (bash), you need to use double
> > quotes to prevent it from thinking that you have a program named
> > "C:\Program" with arguments "Files\Sublime", "Text", and
> > "3\sublime_text.exe".
> >
> > Hopefully this works; if not, please let us know, and hopefully someone
> > on the list who uses Windows can provide some help.  I'm afraid that, as
> > a Linux user, I'm not able to provide more than a guess here.
> >
> > [0] https://git-scm.com/docs/gitfaq#configure-editor

It looks like this was sent to just me and not the list, so forwarding
it back for additional assistance.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8YsGNmJk1WTYkG8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTud8AAKCRB8DEliiIei
gcfeAP9fhC1G/3TJggAPWfvQcgTimhK5GuXI+478gyxemsOgagEAtQqioaJ2NPdY
BXfrWLalHcerg3Mj/KJPhiuLAwnIuQw=
=RWJB
-----END PGP SIGNATURE-----

--8YsGNmJk1WTYkG8i--
