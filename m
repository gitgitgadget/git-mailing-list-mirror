Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB71220F3B
	for <git@vger.kernel.org>; Thu,  8 May 2025 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690047; cv=none; b=Q5/l3mJu1R4kdyDZ3YJgs6apZtWqUiTYdoqvsf3v05SXS3T8NIQWZHmIHJ50On395bKmOLyuSsvTkk3IB85WxvRnsGat0xEBLiK4G8gxEaDbr75KwLaj5rSWTEkeHLk7XHFurntTCTwAFumO1z4saN3fDiQCerVk2SEhf6/OEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690047; c=relaxed/simple;
	bh=zpN7BceUStcrAC7eTHMkGzZ1sQDMUnX7OUQp7Xra8Bc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W7XmZpKlGVCL5fH4qVTXafNV/0bdo762Jom/MTt48rQtBZ8sIAKS39N9hkQSd2rS+skVpBXS2ykkgGYKTCwpEL5PNsBEG2coOKPJlEZosJoskJwcia6rM2eRx1GsBGV8Q/dAPi/ZeFQwUs2S4fVu3pfxoXiy5xpR2ReSxI+mCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pEJUyDVr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pEJUyDVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746690042; x=1747294842;
	i=johannes.schindelin@gmx.de;
	bh=zpN7BceUStcrAC7eTHMkGzZ1sQDMUnX7OUQp7Xra8Bc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pEJUyDVr4+LEdzA/vlVanPZrnDlt05xYVnVqiRZBjJi26TLu1V1BTqj/w1N7eQHj
	 8yaCwsYI2har9FqWnNMm5q4Jhx3JkYtpL3t/q0Dppe8rb+IYkmghmiez95DVhN2SO
	 eDQmkVXJTIni951YO7Gko9tlcYb8cUy2k+JT1UUomKmXjHRo8pbLPGLjtLERa1ya1
	 IAAA/xepz1xBJLsizzuBDbTcJ4rataNznVnOinxnSCYl6gkvKH0OFh1/rapd3+CTF
	 KVeQMEj3RLnmixZXbiW7+ztC/Rlxb2ROqWt/ANgJZPkJNiWngey0u3/i7xleMpRcM
	 jmLP9MD9OPZaeh4k9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1uwtBF0ckZ-00siGa; Thu, 08
 May 2025 09:40:42 +0200
Date: Thu, 8 May 2025 09:40:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: git@vger.kernel.org
Subject: Re: Celebrating Git's 20th Anniversary - A Token of Appreciation
 from GitLab
In-Reply-To: <87jz6sivhj.fsf@iotcl.com>
Message-ID: <45fee163-db11-d3fe-5619-944f512f62f5@gmx.de>
References: <87jz6sivhj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HnywlNr7JiSh5vviPPKk16/CbVq8Y68Ud+D7WegVDFMaCYsWgBm
 hOGsDiJxyhU/71qOvs/LkulKxRCui5UOY6bAqePMK6aYCn6fbK4crBsD5odo7x6oHTiFA+b
 RRV9hx7lNZsuL1iavvM0eNXP0rq1sF5VX4YvAfBvLg5NxpGWHMOZYvBzO7KiTg08qgi9x/b
 nX1Y454v5OfhSG0hqif6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9IEKjf0ugH8=;zllAHmqXIZpQQG7pWg0h4HQec7K
 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
 yDZfeyLvKFYTMsZ/KmeTdo=
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Wed, 7 May 2025, Toon Claes wrote:

> Dear Git Contributors,
>=20
> Last month Git celebrated its 20th anniversary. This is a huge
> milestone, and we at GitLab are grateful for your incredible engagement
> with Git over the years! It's awesome that we've reached this 20-year
> milestone together. Your contributions to the Git ecosystem have not
> only shaped this powerful tool but also made platforms like GitLab
> possible.
>=20
> As Git celebrates its 20th anniversary this year, we at GitLab want to
> express our gratitude for your contributions to the Git ecosystem that
> has made our community possible.
>=20
> To commemorate this milestone, we're offering active Git contributors a
> special anniversary package containing Git-themed merchandise. You can
> find it at: https://rewards.gitlab.com/kits/1008.
>=20
> If you're interested in receiving such package, please send us an email
> at: contributors@gitlab.com
>=20
> Thank you for your ongoing support and engagement!
>=20
>=20
> Toon Claes
> Senior Backend Engineer @ GitLab

What a lovely idea, thank you so much!
Johannes
