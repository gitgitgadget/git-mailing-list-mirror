Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2529B8DD
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770364; cv=none; b=hYQcfIKvBM2Z15Q6De/eJXKHYeiI7TWGCSBYpGYpwrzkNItTKHPA7GT5z6sStg25NEkvc39p1ljLzPyO/HcTS182qylSF7WeYkPxNTc4OPCUMprXOTHWUaqicqiwST812JD47WJCuGtZuyGZAhBMIv1QWK11+R5EbWv9CQcxbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770364; c=relaxed/simple;
	bh=MzQ3BBSZ92//6bOUkSBTnPQ0BkqoeS5hJDZucRpfKGw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eSbcR3sJBwtNuX8tWmELT0OJ38VhDAqbAXEgtuVKX249dTEzFnIFPqVgsnzgfytjCyYZ7gn5bFRDrce5dxR4FNMfJWwkzMcqGLAQ/jnOhYLdIJjYtnxvFSFwUOjOplM5KLl4R9w8SFTca4mnwk3NmLV2G6yQxI83wJcMTMThrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tjScgsc0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tjScgsc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752770359; x=1753375159;
	i=johannes.schindelin@gmx.de;
	bh=z8E3JUNTSJWjnuEhSP5FQTTykaZo6W9uBbgX38+v1yU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tjScgsc05MPq7cBUBaEClClxQI+YUxI40e7OffWi0gHBPfiJshHEfI1OSQ6FH2IT
	 FBETD/5U9RB/o0qbgyTaH9RxKFZ4burk4LdEFiKe0IFl16cC2gBLU1/6gmbsQg/Ep
	 Q2UMiMJinggu+AbKLjFh2giTKEP07KPO5bH5Krpnuwkv/0uzGaeCvpWrJxZ5cAa5G
	 P6MFWlp20LefroyEEaBKaye2GBDL5HmyopJt38+HdpjMrmXWhhWccqPD50WtZzYpJ
	 +N16kQfHdSrjseNU8TNAGkmu4KNOQm6mo5kVlmaCcKcA+Gfidgf+zhyWY2Glfh18n
	 Ap7aIj4903nEtM6bGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1v6Io70Mwu-00jAyn; Thu, 17
 Jul 2025 18:39:19 +0200
Date: Thu, 17 Jul 2025 18:39:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio Luan Pereira <junioluanutfrma@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Error on using git update-git-for-windows
In-Reply-To: <CA+7SsOeYhzBSTXt0V21ghqdzKBkT49GxZZU0k0MavmNrriv8pw@mail.gmail.com>
Message-ID: <6c3ac456-ff03-6c74-ba86-967e258685a1@gmx.de>
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com> <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de> <CA+7SsOd9jtjQT+zg8XttA-bfONG2Jpkg4uBTTdys87e_jEX1pw@mail.gmail.com> <01e30386-028a-b115-6550-57d598ba93df@gmx.de>
 <CA+7SsOeYhzBSTXt0V21ghqdzKBkT49GxZZU0k0MavmNrriv8pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1217877951-1752770359=:5381"
X-Provags-ID: V03:K1:2eqOAwF3Mcy0e7RVwEW/qyj6Pi8wHEKY/31yqB2kssLMUeG8ncx
 IiyvhaBPWyzvghozrV4fXsyP7Cmo1xIivL3sJHqLogY6pRNQf+KNDMTNa1tl0/Q8ydb7PGa
 XNwahckhm8A+HYQHaaupDnw7oR/ZzOMe7Byhu9v7q3hntHwIBzPQ/2NHo+oG5jdopKJXM+Z
 Mz4DqkMyJjtwNdhAGvs+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:btMo9PgTmS0=;x+P7PylWIFR9NM1nrzXO5UPjkO/
 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
 OLIL6bKO4xBktwFfWnG2YAleGU

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1217877951-1752770359=:5381
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Juan,

Yes, the 'Curl option' is set, but that does not affect the `curl.exe`
program... That will always use "WinSSL" (which means: Secure Channel),
i.e. not OpenSSL. The reason is that Git for Windows needs to use a nasty
hack to avoid depending on OpenSSL (which I want to limit to
`git-remote-https.exe`), for full details see:
https://github.com/git-for-windows/git/pull/4410

Ciao,
Johannes

On Mon, 28 Apr 2025, Junio Luan Pereira wrote:

> Hello
> The "Curl option" is set to "WinSSL", but the problem persists even
> when it is switched to "OpenSSL". To confirm this, I reinstalled Git
> using the Windows executable file (without uninstalling it first) and
> restarted my laptop. Now the content of  "C:\Program
> Files\Git\etc\install-options.txt" is as follows:
>=20
> Editor Option: Nano
> Custom Editor Path:
> Default Branch Option:
> Path Option: Cmd
> SSH Option: OpenSSH
> Tortoise Option: false
> CURL Option: OpenSSL
> CRLF Option: CRLFAlways
> Bash Terminal Option: MinTTY
> Git Pull Behavior Option: Merge
> Use Credential Manager: Enabled
> Performance Tweaks FSCache: Enabled
> Enable Symlinks: Disabled
> Enable FSMonitor: Disabled
>=20
> Yet, the issues remained unchanged.
>=20
> If this information is helpful to you, my current cURL version is
>=20
> $ curl --version
> curl 8.12.1 (x86_64-w64-mingw32) libcurl/8.12.1 Schannel zlib/1.3.1
> brotli/1.1.0 zstd/1.5.7 libidn2/2.3.7 libpsl/0.21.5 libssh2/1.11.1
> Release-Date: 2025-02-13
> Protocols: dict file ftp ftps gopher gophers http https imap imaps
> ipfs ipns ldap ldaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps
> telnet tftp ws wss
> Features: alt-svc AsynchDNS brotli HSTS HTTPS-proxy IDN IPv6 Kerberos
> Largefile libz NTLM PSL SPNEGO SSL SSPI threadsafe UnixSockets zstd
>=20
> This is why I was unable to use a cURL binary without Schannel.
>=20
> Sincerely
>=20
>=20
> Em seg., 28 de abr. de 2025 =C3=A0s 08:22, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> escreveu:
> >
> > Hi Junio,
> >
> > On Fri, 25 Apr 2025, Junio Luan Pereira wrote:
> >
> > > I discovered that the problem lies in the schannel feature of the cu=
rl
> > > binary. More specifically, the problem is not in the curl itself, bu=
t
> > > in the feature "Safe Web" from Norton Antivirus in my PC that, in so=
me
> > > way, blocks any attempt of curl to access sites with a public key
> > > validated by "Let's Encrypt". Turning off the Safe Web makes
> > > everything work properly.
> >
> > Interesting.
> >
> > One last question: do you have OpenSSL or Secure Channel configured as
> > your default HTTPS backend? You should be able to see this information=
 in
> > C:\Program Files\Git\etc\install-options.txt, under the key "CURL opti=
on":
> > If it is "WinSSL", you chose Secure Channel, otherwise it is OpenSSL.
> >
> > Ciao,
> > Johannes
> >
> > >
> > > I am no expert, but an AI I used suggested that replacing the curl
> > > executable by one without the schannel feature would solve the
> > > problem, but I was unable to do this.
> > >
> > > Based on this, I believe this issue can be considered solved.
> > >
> > > Sincerely
> > >
> > > Em qui., 24 de abr. de 2025 =C3=A0s 10:05, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> escreveu:
> > > >
> > > > Hi Junio,
> > > >
> > > > On Wed, 9 Apr 2025, Junio Luan Pereira wrote:
> > > >
> > > > > I am using git-for-windows on a windows 11 laptop with the Brazi=
lian
> > > > > Portuguese language.
> > > > >
> > > > > Recently, an error occur every time I execute the git
> > > > > update-git-for-windows in the following way:
> > > > >
> > > > > $ git update-git-for-windows
> > > > > curl: (35) schannel: next InitializeSecurityContext failed:
> > > > > CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=
=BDo de revoga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> > > > > p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificad=
o.
> > > >
> > > > This command is implemented as a Unix shell script:
> > > >
> > > > https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra=
/git-update-git-for-windows
> > > >
> > > > Could you edit (in elevated mode!) the file at
> > > > `C:\Program Files\Git\mingw64\bin\git-update-git-for-windows` and =
add the
> > > > `--ssl-revoke-best-effort` option (for a full explanation, see
> > > > https://curl.se/docs/manpage.html#--ssl-revoke-best-effort) to the=
 two
> > > > `curl` invocations in that script, and then try it again?
> > > >
> > > > Thank you,
> > > > Johannes
> > > >
> > > > >
> > > > > Reinstalling completely the program apparently does not work.
> > > > >
> > > > > Is this some kind of bug on git-for-windows? Was it reported? Sh=
ould
> > > > > it be reported?
> > > > >
> > > > > PS: I have no knowledge of programming, developing or debugging =
git.
> > > > > Ask me in case more information is needed.
> > > > >
> > > > > Sincerely
> > > > >
> > > > >
> > >
>=20
>=20

--8323328-1217877951-1752770359=:5381--
