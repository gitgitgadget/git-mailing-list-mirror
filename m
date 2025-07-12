Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED25227
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752316242; cv=none; b=iUExb57spHPlu7HEXGpQLbGGS/StBHOki8RdPofJcWJvEPtpqPzxqF4tcyZ+sfxDbSiKn+3Dy7WjzXpal3Cs1CH0BkDnhNfDhd5osog45o8sSqMwnmgn29VCRWpG3pjtC2/q1CP2XYG+Kd0wILYnui2W1owvt7gBNzkUPnQXW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752316242; c=relaxed/simple;
	bh=Xut+pK/BH+ZuMbE944EV9+k1ymN+/D1C0dkRTGU9/jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCRlYNKv9F6r3LFaMHso1vFxMrMltm+pS5yg7X7Tnnsq7jkRsf8yi+p/xN1PaHEa5j3pXq8NFrbTFS0+5uaD3d9jiw3B7hgBZjaG1xS3O4CZiNFYzf2BHW6hy+DWUe6W0bwVkMTY953C5oiJ/myGbtPONqDU/VG9MheRIEu5vXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=bRolmc/z; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="bRolmc/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752316232; x=1752921032; i=tboegi@web.de;
	bh=ANeM4fahzNhKMIg69SNXVuunvnfF6YMe2soYHA+IG+M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bRolmc/zejqr9oHlb305uBlQFMeqWNcEJzX2O8umRZ/Tk9oIgeCLXLIGjxe2zjWE
	 gR7/6Bwq5fAWYHOrLAdE7YrWXTsqZw1RFI5wMuYXBgJE+QEaTcEK81pjhQbUUeOvt
	 JCBl3fs3ipmzGXAcHTeP/AO8trQ23cdLFwkeyamaucvfHoW66ZKOZYDn6U6UijEsU
	 SCwMjdHU6ocJGRJD/1tLN2qscdQci3Sc+iATJ+nWWWsBop6bCttn8uVlNJc2v/iUd
	 xGOaYTZTu1FaCpxXDVYtxxt1VHrXq36ueNj/hBb5Tbsz5TlU2pbzH8S6Wgd0zGg7L
	 lLf5Rj7ld0Gt4OUEyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1uSGJ70Yly-0009q9; Sat, 12
 Jul 2025 12:30:31 +0200
Date: Sat, 12 Jul 2025 12:30:30 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jason Cho <jason11choca@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why doesn't git core.eol=lf work?
Message-ID: <20250712103030.GA30568@tb-raspi4>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me>
 <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:FenB9A7g83dLWgXFF4n6XFeZZJ4gC7hBaU8iuahlknThapefOOG
 2yEFsPDwZzT9SICDx7La1RqKSecerfCKHGNxPK8++NkTgQHIivCz6fMyrGKzXqkOOLH8ngx
 XQhhUqaG+41D6A1CiSvKo5lj+GK67PuIASITZ5WVE7ksmVVUoOtejy3k2o6F4cTZhI/dKg0
 CMbqVMj2cVTKlyhYtdN9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:asUP6vjT5Oc=;+n8wTGRp7QzwDN3tyJf70LRO1rD
 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
 5IwGJsq3WOaT6X25IP6l4zM=

On Sat, Jul 12, 2025 at 09:45:39AM +0000, Jason Cho wrote:
> ```MINGW64 /tmp/summer-temp/dbeaver/docs ((e4219ccb38...))
> $ git log -1 --patch license_header.txt
> commit b5121d4a6e8f3f21079920180b0fb14ada6d3349
> Author: serge-rider <serge@jkiss.org>
> Date: =A0 Thu Jan 10 21:56:55 2019 +0300
>=20
> =A0 =A0 License header update (2019)
>=20
> diff --git a/docs/license_header.txt b/docs/license_header.txt
> index 86de505a18..d75b48e98e 100644
> --- a/docs/license_header.txt
> +++ b/docs/license_header.txt
> @@ -1,5 +1,5 @@
> =A0 =A0 DBeaver - Universal Database Manager
> - =A0 Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)
> + =A0 Copyright (C) 2010-2019 Serge Rider (serge@jkiss.org)^M
>=20
> =A0 =A0 Licensed under the Apache License, Version 2.0 (the "License");
> =A0 =A0 you may not use this file except in compliance with the License.
>=20
> MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
> $ git check-attr --all -- license_header.txt
>=20
> MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
> $ rm license_header.txt
>=20
> MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
> $ git -c core.autocrlf=3Dfalse -c core.eol=3Dlf checkout -f HEAD -- lice=
nse_header.txt
>=20
> MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
> $ cat -A license_header.txt
> =A0 =A0DBeaver - Universal Database Manager^M$
> =A0 =A0Copyright (C) 2010-2019 Serge Rider (serge@jkiss.org)^M$
> ^M$
> =A0 =A0Licensed under the Apache License, Version 2.0 (the "License");^M=
$
> =A0 =A0you may not use this file except in compliance with the License.^=
M$
> =A0 =A0You may obtain a copy of the License at^M$
>=20
> MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
> $ git --version
> git version 2.47.0.windows.2
> ```
>=20
> I ask git to force checkout license_header.txt with LF line ending, but =
`cat` tells me the file is checked out with CRLF. Why?
>=20
Side note: Did you  ?
I would suspect that core.autocrlf=3Dfalse switches off the CRLF handling.
And this could be a command line:
git -c core.autocrlf=3Dinput -c core.eol=3Dlf checkout -f HEAD -- license_=
header.txt

But now to the real stuff:
It may be that your file had been commited with LF or mixed CRLF into the =
repo.
In this case will Git not change CRLF into LF at checkout.
What does
git ls-files --eol license_header.txt
give you ?

Beside that, I would recommend to set up a .gitatrributes file
and add it to the repo.
echo "* text=3Dauto" >.gitattributes
git add --renormalize .
git commit -m "Normalize line endings"

