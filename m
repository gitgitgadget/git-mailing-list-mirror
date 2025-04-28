Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6B1FFC45
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839326; cv=none; b=LUwF2HJJaEDXUvb5puMmAViI3GyxklLh/R8k4Taq53hoSIcC/RDgxzwGSkAIuqqp8+MFQBUyVApaVN00aGcclxAexB06H/AD7u3fo7aq66Vj2qeU/R+19pu3+Zh2/14eHdxMo7hjzhsOfInmHwn5MGVXr/VLhx24lvbGDQDlAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839326; c=relaxed/simple;
	bh=BhY13WPXqXEvIDf8YyUSrW0JiLyssdE8sj7ouBYayM4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RT1yKPDhV78ggjevjMLlxjaRba1lDv/NWNMNvliDd9ztZ52b5z1sA53rTmC9VMdOUvPyfd9yPFugwRK0Rpm2T/ExDCORblXnCLLOVrb1xoEAFHtQarPrHO0THBmJwhFceuIMU+TAVjka/mP/ZBFGfAkOVPQycXps0jThyfeZcXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jQ7vyMt4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jQ7vyMt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745839321; x=1746444121;
	i=johannes.schindelin@gmx.de;
	bh=wQpUV508B2OIakd9L03Ucj+i7jCL536PDFwNj8g8HIM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jQ7vyMt4KNzSEHtAYLSBJMzbNiwKrO9GZJHE8KLUjpQ2gTmcsA7X+aZeN6gBgfDh
	 s9EkCH6WHwoErK2rT2ZtfzN5Hhj+3Opq94cFTzo5X0J2UvELlY7OjGp98MREwKnES
	 Bg9WpGDf/QL4+dMnO2euDGXRowLmVc6e0S3X+LH6HvhPH18f/hwD6InuBVCtPF7zM
	 kIlhtD3JOvDRfFSuccDJgVaF+mYV2CSCfs9N3VwjOiY0fXQ3KlrRIkaW0Mn+on9Ec
	 BHj9HkQh3bUA+IMZaJdOn/Dl6+67Ieu3ZQcJioXTw7xjXXxkwK9h9pJS7idldXDmr
	 77qI9lPuKb+Cn1kbUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1uzgCJ20eY-016mHY; Mon, 28
 Apr 2025 13:22:01 +0200
Date: Mon, 28 Apr 2025 13:22:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio Luan Pereira <junioluanutfrma@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Error on using git update-git-for-windows
In-Reply-To: <CA+7SsOd9jtjQT+zg8XttA-bfONG2Jpkg4uBTTdys87e_jEX1pw@mail.gmail.com>
Message-ID: <01e30386-028a-b115-6550-57d598ba93df@gmx.de>
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com> <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de> <CA+7SsOd9jtjQT+zg8XttA-bfONG2Jpkg4uBTTdys87e_jEX1pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1940586538-1745839321=:90"
X-Provags-ID: V03:K1:1UxqmQpjCoYR+JG0dxQqz1TZRzBnYsDE4lEoH5g1LfYOZKOV8Nr
 menEvd5Sw6ESlbF00w2/g6dKxoc1ifQt1t70IG3DXSRhCNstOAgQZ49OS1cWqQE/h4s8rrS
 lXP+xeVkuRWf3Ruqt1EvQSjlgC99pM/U2kClATm0rzHhQXlceiNFZ3hf3YNM/HwRWbgtyuI
 QBec7dDVJYzMIoBdWk4KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0xgnxNGiYZU=;d40JMtTYK3/8AztIOSk5xjyOo9z
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1940586538-1745839321=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 25 Apr 2025, Junio Luan Pereira wrote:

> I discovered that the problem lies in the schannel feature of the curl
> binary. More specifically, the problem is not in the curl itself, but
> in the feature "Safe Web" from Norton Antivirus in my PC that, in some
> way, blocks any attempt of curl to access sites with a public key
> validated by "Let's Encrypt". Turning off the Safe Web makes
> everything work properly.

Interesting.

One last question: do you have OpenSSL or Secure Channel configured as
your default HTTPS backend? You should be able to see this information in
C:\Program Files\Git\etc\install-options.txt, under the key "CURL option":
If it is "WinSSL", you chose Secure Channel, otherwise it is OpenSSL.

Ciao,
Johannes

>=20
> I am no expert, but an AI I used suggested that replacing the curl
> executable by one without the schannel feature would solve the
> problem, but I was unable to do this.
>=20
> Based on this, I believe this issue can be considered solved.
>=20
> Sincerely
>=20
> Em qui., 24 de abr. de 2025 =C3=A0s 10:05, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> escreveu:
> >
> > Hi Junio,
> >
> > On Wed, 9 Apr 2025, Junio Luan Pereira wrote:
> >
> > > I am using git-for-windows on a windows 11 laptop with the Brazilian
> > > Portuguese language.
> > >
> > > Recently, an error occur every time I execute the git
> > > update-git-for-windows in the following way:
> > >
> > > $ git update-git-for-windows
> > > curl: (35) schannel: next InitializeSecurityContext failed:
> > > CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo =
de revoga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> > > p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.
> >
> > This command is implemented as a Unix shell script:
> >
> > https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra/git=
-update-git-for-windows
> >
> > Could you edit (in elevated mode!) the file at
> > `C:\Program Files\Git\mingw64\bin\git-update-git-for-windows` and add =
the
> > `--ssl-revoke-best-effort` option (for a full explanation, see
> > https://curl.se/docs/manpage.html#--ssl-revoke-best-effort) to the two
> > `curl` invocations in that script, and then try it again?
> >
> > Thank you,
> > Johannes
> >
> > >
> > > Reinstalling completely the program apparently does not work.
> > >
> > > Is this some kind of bug on git-for-windows? Was it reported? Should
> > > it be reported?
> > >
> > > PS: I have no knowledge of programming, developing or debugging git.
> > > Ask me in case more information is needed.
> > >
> > > Sincerely
> > >
> > >
>=20

--8323328-1940586538-1745839321=:90--
