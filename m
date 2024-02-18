Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF66F07C
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293969; cv=none; b=Cb5K1kWrIvpHl6f22V/529awSDlyTDubNonjlRC4dKc6sUdm/K8xvR88wdSvUAeO23VBE497MbLudaK7uLFVoc6J26E2Dn0ovNmxmWlvPx8kV1V0rAoAtLHtVFLRcc75MMC7ce28Gv2NY+r7D3090dyWNkliqszfNFT1yw4TY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293969; c=relaxed/simple;
	bh=dqF/EQalFTJm+jX7F3a7lb9oHPr87oKnSzcXYa3NQFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tU/b5vmtB/jj+raeRU1c4Hqy5KyisHdtm/SPzWW+4b+m1QbKsOq/QIeJn+EJpFJn3gSGdepqBx5rrtyqJx9Wmrcg8cfCo4udnHOjWBDHja7RPeDHeOguUbRHXbQM4DqRRz9quCMRTVmruCXKlcBHwI7DB2vbwcHZxk2M+NNQimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tG4LW4UM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tG4LW4UM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708293965; x=1708898765; i=johannes.schindelin@gmx.de;
	bh=dqF/EQalFTJm+jX7F3a7lb9oHPr87oKnSzcXYa3NQFQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=tG4LW4UM6YAqRbNzmnhm7kgYtPOYk5oxwCvmPE62L0YeOZjppkZvjIOCfBBz7s84
	 zrbdf3vLDuPiukABtjmW5ZiltPr9IV3QFM7GlCb71B+8FWOTyjaohZHk/7iHoOcej
	 ju7KoA9MjwKvm3T8JhUmsF23GsDpMcTLpifD7Q+WX+J+9NOvCOShw1eElxB8mR4JU
	 HhAOzbDUEPuWkldDpHEd1W0zsxSjEMqOdzU4+J29g0pLnZWyi1hJJYv5GNSY6JHj1
	 BDNk9Hts0pIJnp/9CtdF1x48AyjhgRm0B6LMVV7UyC9Cfbe2Nfw9mf4hiXIj+JDbr
	 J4flflP6sqFv/nKYWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1rkajt0Wdk-008vEK; Sun, 18
 Feb 2024 23:06:05 +0100
Date: Sun, 18 Feb 2024 23:06:03 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Konstantin Khomoutov <kostix@bswap.ru>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
In-Reply-To: <20240216110041.dqz2n5dz43mqtq25@carbon>
Message-ID: <7ddaadd4-cfa6-00b3-1aee-34f5c57f4e7a@gmx.de>
References: <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com> <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM> <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
 <20240216110041.dqz2n5dz43mqtq25@carbon>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-284384438-1708293965=:504"
X-Provags-ID: V03:K1:IpXVYqRjyr2yg82aFMXm6tCM0IMx+BpnH41PREGqFm1COWDMljw
 hu4ehr8pAhFuPArAQCGMAJ31uR6CYlWk5vDAYaeYCDa/KV2Ab0gKe8HGWhCjo1/CDEq3sw/
 DaWyZ39oNQJ87vnwsqR7SMmh5dK5Wt0yjBNvHzSUL/bupLYjiNfmkKYjRB5y6DZx0pakypc
 wePfpf3gILOM2ug0fpmMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLe2Co04dBs=;owQdrA37Z1csukCWrwFJCEdA7SS
 +vzbxe2RTyeVA9v2oQFpjwLwZ9ORTnp29mSmA6wJ6EJtKzoa/7yH0tP52DBcIXTd5LtLoXyWK
 ADSEperujdJjPXoeM3zSjNEUtNkVewsHZXMYnZm1vhgfMh6+2l0lFISp92u+Ks/yHmq5iPFJ3
 XQr41MhVXJXh9jYLcMHPCg5weqkcns/PlH5RLjt4E48qQWnBrdly/y0hpEKieEFa7F2cOW3Gb
 bTHvdA1ltNBe1+UtlPtt26Hjrp5a+Kp5PXckFXzvH1+NI7hXgEWLFjReGKTIb3cvIwtRnfE6X
 cIIxYQilyfXtR0ooiVlJ4wUSlcT0aknqxOlT3dYVpjBB8laRlpmF9mInNDIi7hgWCvsW2+xyu
 gCmVxZG/cnoNlfuNX9lHJ1RdQCouKT08r+yXtNxLU6qdpmzg5AmA0yr9nPesvxedBiEoua/0B
 ZERbzz0GJtSe1RqjIly4G0mFbNiivyQsYhzf6Qu5QfHAXKK5BCaCLViBPhQEbooZgWpYfTt80
 vgsraubh7qjyKIjxngOE7v7sVjLroTG6gyu5zwJSWN9CA97y8qN0wItwbnsWQJFZ9Kri5fCT3
 jeUZndwftApdmWqOJWmleGaYO2DCsjUvFMYaZK7D+FZJI5Te3jiEV5epNPAB/BHHldLiknlfA
 gud/MR0Ti3/2aPaG2aQolizGqgl+UGKxvE9jhz6ultTNvWhKvQuYIWNjKUZqMCwUVtNN6aF0Q
 bkW1CnWA/Wr2qZ8TATJKvewD7apUE7YU7FmNDhTsHx8CJ5VI4RabiFV5VduNFc+qWY8gIYdKt
 HyXIaBU6raH41RbW9Ccu3GJnvXfmdWD1VcKCUJOnwxTXw=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-284384438-1708293965=:504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 16 Feb 2024, Konstantin Khomoutov wrote:

> On Thu, Feb 15, 2024 at 09:40:47PM +0000, Christian Castro wrote:
>
> >>> I have a question on the GUID and/or SWID tag for Git for Windows 2.=
43.0.
>
> > Question: Are you a Git for Windows developer, open-source contributor=
 or?
> > I ask because I will contact the manufacturer of our inventory product=
 and
> > provide them your feedback. But I'd like to know what your role is wit=
h Git
> > for Windows for as of now I just have a reply from someone named Matth=
ias
> > from a live.de email domain. I hope you understand. Truly no offense m=
eant
> > on my part.
> >
> > Therefore, please let me know what your role is with Git for Windows s=
o I
> > can send this feedback accordingly and continue working on with our so=
ftware
> > inventory vendor on the issue.
>
> I would say the chief Git-for-Windows maintainer is Johannes Schindelin =
[1].

It is: https://gitforwindows.org/governance-model.html

Matthias A=C3=9Fhauer is a trusted Git for Windows contributor with write
permissions on the repositories, so what he says has a ton of weight.

Ciao,
Johannes

--8323328-284384438-1708293965=:504--
