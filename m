Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151B1B425A
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460043; cv=none; b=LiTp/ZpbW7f6Zrm6nXlAFSStBxyzmWaC/DO/ITeqaO6OwwKQAxfZEbJAFaBeEeBKWjDVXsWuyP24HQ/0K+DZW+KykZG/QjcmySkVmMV3UsTRoLzin7Wm3WvyLMJn0qkHoQQgGTShZYtkIGlsxwYE+3l6pVenSBW8XzbfoH8whgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460043; c=relaxed/simple;
	bh=j+D+FLkydV2RLngU9i2+nPR5fDUN4Xzm6reLTMgmGaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq/Qgo5268h3gP8IeIId9OZUbnhV5KQ3QlvIYbRSMeWUAGPqu+htHkJHJ0PoqdBvyXCRchGxC3sEzBKGR+s6FNO3NG9TC6n7HacNgU5TTAa7pW0oX0d7HUNvP3IsWGieVAdv253AbvkYqEcIlTCt3AV9IN/bs9617JmbVBLRBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=KF8jrrpd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="KF8jrrpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737460034; x=1738064834;
	i=oswald.buddenhagen@gmx.de;
	bh=07N8SiI6+ohuQCdM/4Sj7nWjsxBQzpvuea14ceKa+Tg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KF8jrrpd2Z/BvU+fDCLBky0fGJulIcOOfcSeYPd88x+5K5L2GEohYo+IRmwxVgOO
	 krpuBh2yIPxthqZinESJO3i6RBWEtmQDJHIRyHjpqGZ8f6qI34BQ9JXSYEqQufogl
	 kt8BFdbM0HAEgT+X9KZhhRf612TjYmULN+xJ6bQDydq5+uttjg3J5M1p+VMb70Dxs
	 l3SzVnWlZZk9NCIbtcvIbdgfchtX5f0AHIGRWVc7gCcBUPsOGAJd2oPf7XYGBO2Bp
	 13S4uOQGfA6NKObxDjuBWzCJD/u4B/Y3JnAtJ3NjrX63f3EFVqcD2/yMD7IQizIcf
	 5OS5ZD4YTjck1Sj9UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.120]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1t5ZkL3CEp-00hne7; Tue, 21
 Jan 2025 12:47:14 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1taCiw-e6H-00; Tue, 21 Jan 2025 12:47:14 +0100
Date: Tue, 21 Jan 2025 12:47:14 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z4-JQp9uOP8ALT7R@ugly>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z432QXJb_TfzNBa2@pks.im>
X-Provags-ID: V03:K1:5sW24y9jVRD7TTuB1+YAK28ltlPV5HXJgbJXeHsbc7QSX+F/PdG
 oe01grK1o5S9+aUKT/QnFXV4AHNfsbuAMqEfAb8bXYZF1ECUq9gMIm40ijWpr5TMuYwsicL
 mWy+0BiBO3ERKDrhXjjV/YJwSyeBmEilBDXPjAzyzzRSRqvcgu2qt/mFllyyeH0ul2EGylt
 Xhyj/lLu9YavXjJKgIk2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PVx3MQ4SvN0=;4IUGnjuXqeqx/c6PGzseYnzMm0a
 WfDlZ9uZnUqwX9l0ZTounqzoJnuUBvQtEsUNUaT3kOVDA2N0B+ySEeoRsOkveiQ4fEgJ2yU2d
 h7J0i1th2uan4omofXnGrlBTOOc/j2wYMaSMDz3gOBIEvF/NkN8eYcTou0ioHed35hY7Zjy+2
 2fjuwHUGkLT4WTXsQTBZoaegHXYltjBuUPdxyzbL3eC4z+tilGImNkxK5EgQgglU4/Vy4n7YE
 SCn4ms+bxl0s0hI+H4oKZSA3fCbAjFvQWZkzuRGmySF0EtpVtBWI2lV3HNjvMzFP7JB58JTaw
 duFQGxSFSS2wQ6c92QYhptcFsPhbj4fq3+HsFXj5BCnobeY4bliSKIcwCUEkUQjYwhar/JTrU
 06inANa9bBB7EF2q0seJtYl972l9ZWgjM6Bzq9E1P2jmTlDkCb/FDxK4KTs2Jfth5iIX0rpDR
 m+KgC42RtJP5SK9MdOnnZutq1FYVb6KjFnnMPVAVsvsPEfYUoK+3CJN480U2RbuNXPp1nZsw9
 BRsdswhCsWNBxklRdzCQiZWJm7ky8XXUsvHB3w+smNdYSZBrxnF1xH3uck10HYh8uH1D0kWBI
 HkaIWsghd1txgybMWeHN1XtFEfpC+B2skdAdkOB8dF3dQngBIMRYRe03YAQDkmQlGXqKt31JI
 ETd+sOJy6CKIzKF2kEK5ez77UjpofXUwyISWs2T0F+ftwusrtsn3yTUILT2N06iWsGMX5KOgD
 RZHO8I+KbPcOvHKYaWGmVYbuY89Z0wEm2tbKyWzartxK1aebfoPjVvlJWA/nMYrfVHL0LWWwX
 SP2wTFLynAlWX/6bGdrRxtaGK/voT8eNQRUHznBwjPoEju3RM3gQLT3y2PbifJjY+gKYYtOeu
 OASQC1dU1vLFyr251G3Mn2uqQRPR03duiQYwp+rttzcn6tqq9RF42gh6xcSHOLTFTsIn380XD
 OOwPHKeTt/VD9egFrR+1JNT3oc9q296Dbwqve4Z5W2du+B5nA5fmU46OAnSoJkeJeXdGlWUPn
 VzK0S6JZVgaTFgRBN/Ci0pQ5pv2CMTGkTseAUjuqcx2cLhRUoHfWz+d5XcuJ2dW5aJR5r3cDA
 Fa79yuFQxOEj+ws4xRERJCMFXT83AS2MqdK1Y0zuDQt0NXrP4toIEk8YORV3pnjZ6cFkwchPX
 vP9Yz19X60PLbovY3SnFLIMH8OeHq7QZ3PR2hRge2pw==
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 08:07:53AM +0100, Patrick Steinhardt wrote:
>  - Create a new command to query repository-level information,

>    potentially making it machine-readable via for example JSON.
>
only optionally, please. the current positional output (each line
corresponds to the respective query command) is much easier to deal with
in shell scripts.

>    This
>    would move such information out of git-rev-parse(1), which is a
>    somewhat weird home for it. It's something I have been thinking
>    about quite a bit,

> but it wasn't ever discussed to the best of my knowledge.
>
that depends on what level of engagement counts as "discussed".
https://lore.kernel.org/git/ZZbFGTkM8aR7MXQu@tanuki/


