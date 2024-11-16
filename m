Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C928172A
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731778775; cv=none; b=lAhSJ+u6Z+UZ5877lwh65SGla3OFiUT7SWIIcjMyKes5UTxal38nU2kn8KeZHthbk5cMy4dgCDF8fs9Z1EGC8f6prkm2mV8SVP4+B0DE9xjM3l5EDn71RWezuXMRZF5XdAkTsy6h0/aJMD8Mr3EB4pRbj52RqtJjASi7k+5fji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731778775; c=relaxed/simple;
	bh=CkL7vd1hKtMep5wX9L1kdyCpd5HKGYOWF/+hy/1lHBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X3KGmoDu9dG9MfNbb4l3BP0n29mhDHj1XvdJtYYqMZCRz1jZQakT7IeZN58fWSGgDO12vngtcimVwi97PAFHpvOn4W2dNOTFFNnc35k4toCCQ1ZpqnpD8Z2Y+z5bIs/JT0j+DQLLBevY/w409WluKCYpQe8cDH3qJk3S/8OvRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Z1q6iwnr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Z1q6iwnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731778765; x=1732383565;
	i=oswald.buddenhagen@gmx.de;
	bh=CkL7vd1hKtMep5wX9L1kdyCpd5HKGYOWF/+hy/1lHBc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z1q6iwnr8T3Gmm/NemaOwfIztTq6pCalqdWn0GJeXdBNIVn2u3/X9Elg4Aob4Qw2
	 SD4MlFWQfr0aKU3Gye31FCU7Izk37LCWutXUCh3hGjk5xx6b4mwapLkLyYAoga6Bs
	 MtJWwYpY9z5Hm+6kqt7iJgWaJhSdLhbzKQiW/O+nNYeEN7DGMMwKyw+y/7BZXW1Yl
	 afm6J3SHzZNV4n1z+a9VmCIukf7jAqNaD6PaaFzoYHPQhGE8zcQJtfWhBOjajOYHP
	 t6p8fYChEKIqiLZY487l3ke3Hdd5BgotqGW6hjYfDyC1lOOqxnoCqVMTvZVAFDV9P
	 n2JDgpru6H4DxlkmXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1tpm3B3fl2-016k99; Sat, 16
 Nov 2024 18:39:25 +0100
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1tCMlZ-09i-00; Sat, 16 Nov 2024 18:39:25 +0100
Date: Sat, 16 Nov 2024 18:39:25 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: mcepl@cepl.eu
Cc: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com,
	martinimre25@gmail.com
Subject: Re: Feature Request: Interactively pick fixup revision
Message-ID: <ZzjYzTfmZLVXgJ9R@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D5J0DCN2Y2V1.3C2JLTMGY8VAM@cepl.eu>
X-Provags-ID: V03:K1:44PQt8reFlMxQdWUWsCzuk2fLgPUyozKgUG5lu1/xFkMVoBcAEu
 ZPtEoSHMr16KGyGeOXwz70eR0Oh96AoqMzULpiKHqYdGNYzN86PNn0q2fT+1uq5DNjD9JJS
 BqngjyHKMQjqjt2dtvUcDSNe3gtVInfYwoFFZVTHPMccWe1k4bBVRNAA2UU4Bwu/vMoeLtp
 6twRsnjCCYI0JgQ/CPpAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cQ0lVzz7bkY=;ybNQ7hjF/T+yJtMH4ZPARy6LOd/
 ukIRS5hu8BucqyUR9AXoi8t5naqKEpD6Vy6E1x1c2FTZpvUFEaQaBpe/n+kn46Uixl4x22bPu
 6w1/uvPxwGC6uyYlYez+VAR3vWGV62K84R3UB4pgmet2N7xihOm2Erqa4WN7UQRvPJATRtOSK
 /0CD1YoL4B9FkFGpIp50TxVxyzUhqqgBcpBZ2PJYsU3P6lUlfzt6QxQbRrq7YCdyuWlt69Vhs
 CJ01BqmKODcsTYEtDwYg+mpud/t6cImUMYsquUXepdiwdf5rVjgsuUdJc1sb7Ak8+l8Xb46SY
 wSY30rSTHONnRb48yx82zJ29qvNdqQ16DyhyCv43cf345fuSLzi6R4qijxvr/2o2v2gJLdHcF
 +ru+nFwn+H7JdJ/ti6IRo+lYRKRCZZXuJKhw69N5S8n8nCDjgnX7sQDPgQErawyxf3oait1Mi
 9ULtZVCNfD1qBDG3CYIYe49Mnb9tlrG+sZrKU/h1fkcOQGWZoKn7h6lcx4YMXtECtq/ZSaMoU
 LpKt4bQq0TRxJYiO2eAsMwTeHpKZw0DexEC1F+PuT1sb0fKAn9uqFFhrvoiNVT9QOJYv5WppO
 7B6o2zVRf0pUertHSBkcHW04YUB5VtPcXIXPQDVujM/t2/JDsOlhBBmAOJ7dS4jUZpH3JcD0N
 KpauV/hBf3kpig5cmDPGwqEGGZz0oBORKb2VMBjoEmy49pa7Zt7HqLWOsOSLqdSDRgwJu9+2+
 9MSWYFmLhl94LxzSF6eRYmR7NmYbVNYhlqrz0iq9uyXaU54o1w2ZXWwm3hsY0RTCufDBoD+kX
 oUMuJE2e48FTDALXJGn5IAJXHAmlzSguFpBlKmZNIgS7VqFByZeDF/Z3CISQQI1qD4Wx8nNp7
 HP0LEK/xT4xbSmQcDmsGezVDtiwZJ7+/JsIZDlVtFCCu8jgqjeHUdz1PM

On Mon, 11 Nov 2024 03:53:47 +0100, Mat=C4=9Bj Cepl wrote:
> On Sun Nov 10, 2024 at 8:55 AM CET, Martin Imre wrote:
> > Just as a general question: With 2 (or even more) different
> > implementations that solve the same problem, wouldn=E2=80=99t this be =
a good
> > addition for a future version of git?
>
> There are few problems, one which is the implementation language:
> git-absorb is Rust and git-fixup is bash (using arrays and other
> non-POSIX constructs).
>
fwiw, i just stumbled over https://github.com/torbiak/git-autofixup
which is written in perl. no idea how good it is compared to git-absorb.

