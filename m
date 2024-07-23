Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B547A64
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775910; cv=none; b=s/BhIUpC/Y5O3nVf4682TKCV7TD+bhSW8yfYWz/NuuHWfvd7cOzbPgC26jDOxCew/rQf3sanOKcmOX4jN55nwVl/LZA4IoqkOISTYaLOvnAV01iY3W4goweLuaCAdILE8bF1mkDoMy81kDUcI3+sto7mctFC9p20qFQOV8mKRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775910; c=relaxed/simple;
	bh=bXpcunGpMSJkl4s/+TGfazI3X0B+58NPHQAJ633t5mM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPeFV1sbtWVWIrL1R+d20ohLNP/3Fb0c2u5G+1kXXPfcVN9kIEfYtDLcVoZK3psk4a0ogRQMuX+S3OhHk5jrtPY2s5xVO44INfI5xMB2U7mGyb+AI8m774D9kdVofPNGjEs8kAINpi71o2fYTmJTmrPfrLKXQL/p2jsZKCNrelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=G26R31HI; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="G26R31HI"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4498242803A
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 01:04:54 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:e31a:b656:6fcc:2ebf])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id AD70120039E;
	Wed, 24 Jul 2024 01:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721775882;
	bh=bXpcunGpMSJkl4s/+TGfazI3X0B+58NPHQAJ633t5mM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G26R31HIdVLk3iiW4NWEulunuD+OpFmxbbISMxXQO9MHu5RFiOIYjgxwp+KNqK/0B
	 s4v7TSo/JrDMSjUc7jYW0AaYjNaTjKLSZAxnBKlLeSWpN4uEyp+smG9V3NbFTWn5pU
	 a8V/GbkZWYfv14TNzAydyC6Zd/XIiLRLGZzxWTBOPSuWk1NxFoYrcGTYpwgi2ZGqrj
	 MQGKhFQ7/ID3AaaCHmgSxY5OLL51CBM9pwflYkOUy4cpmkikGNhqvIOvLgGurQGK7w
	 QNxj2FsSUujNTaBgdeUhDYGqfZE70hu1u5xuPIkIA2990DToDEkybFAFxRQi3wfz1s
	 4ya6I0H/N4RGA==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org,
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/3] doc: introducing synopsis para
Date: Wed, 24 Jul 2024 01:04:41 +0200
Message-ID: <2911357.mvXUDI8C0e@cayenne>
In-Reply-To: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Sorry for the noise: this patch series does not work on macOS.

BR

Jean-No=EBl



