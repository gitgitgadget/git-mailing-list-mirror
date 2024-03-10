Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD51FA5
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710086630; cv=none; b=S2hT1qdu4hFD0IRtwM8N+DMr0aHxi7Ub9hPZVnrXnUsXDJpsMPvakhqOVfx6XpVg8N56HtM35r5SjYFCbVv0DfBEt8KCqHHJ+ek62tIyGkMYrutTt1sdOhNQ7OMQuXeThSowQ3M8Kyggejqc0FLgtuHFTvhJVsjKsV+xDjmoyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710086630; c=relaxed/simple;
	bh=3q80kqzbdlS5iLDfhbTQLUnwYqUpu+eyYAolfhFtKrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibEL2n6ENphZLa69DMKJW5PNoGcnaZ9WBg1aICCBhyTVj6ruPpq637C0n8+N6+LBXQfWk/K9kQkyZfcX0X7YJRfuMhZS4it035ymvwzvEff+93HRdJomW/zvrO/8EZgt3tJCE3fRluoQJTPD7RzoJ2DSaoEnQgUPJYTXe8dzJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=AUyv+RNb; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="AUyv+RNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1710086619; x=1710691419; i=tboegi@web.de;
	bh=3q80kqzbdlS5iLDfhbTQLUnwYqUpu+eyYAolfhFtKrI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=AUyv+RNb74si8VMku+aHNiBbkIShGFJfhH9oTpAbCF+AXeacfJpnLZNuFl6U3AMh
	 t4d0IgrXCjf2gd/+tLN28Rzlsv4pHQEuzba4nW26/M8ZMQ3M1J4W/GO1aLWvt3WHR
	 7ZNHsZtKIKKlHDbE4SDaGauD+1EhXNZXzaFQwvxp457vkdwJknbi1GGiISuQ81eWu
	 JLf07IqQq5LEP0FiBZU7pAkuDSiwze4TRVmbwob3mcHkuwAoyJ+DbHrV2CHLDapCU
	 4+xeY8eanFamw59MzXhrhPrKBB5JP9Au5PMQFbEv8impU4KelFK+MHN/nYPHGGM8k
	 /BQaISr3lB0FdLcFHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1qrWbk2JR1-00svrt; Sun, 10
 Mar 2024 17:03:39 +0100
Date: Sun, 10 Mar 2024 17:03:38 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: unintelligible error fatal: empty ident name (for <>) not allowed
Message-ID: <20240310160338.GA7953@tb-raspi4>
References: <20240310151533.GF23839@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240310151533.GF23839@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:LLnmxvOq41DlGFkCDvN9TJ0VBuFmNwB2bgY4WsLcSBQwQIhqf61
 urF5+GEHMncOo2DZz4itBSNJ7a60FaeBLKeuuWQPEBdCD6zVKhRXT6p3rOHNIBNxCu2ELQl
 EqjgxtZhJEMWXYxURFl06vr3R4IO1UbmipO1BSYcfUZdNm6ncbBxlwQX+pw7aW6qurfISeT
 merEnTu8Nj5zLKtXVr8Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yj2n9glDoQQ=;SF4nycnhmR8Y0rLG4JIIGkLQkiP
 Z/9z3KbDAScOIGxse6LKJZVjOqIxVX75LiwChd48X4RRSu9QBxUn28Lcht5vCSnE0ifi0aoWy
 l3nViO2T/5Dm41g9WngilSPNhuq9ufgd6W0ZEOeEOhjsFZ439osgYoRD9ZOaMxAv5HLsa04XC
 AQOS7l2mWrx6E7mi2c52SW1pgnspsQkSh3aLoPRiRTOiJALxZHjJjUwcFqThoKjMVCM3OksBC
 bC70YNVrWGXvIyaL039sFO8yd64HzB4qIsBlElBlV9sBXKhjukkvAAbdcm7Q+dKjK9QuvvwN9
 OjDA4qWVYLyZd7Cp/HBBck67qnjHei+Kfhh2mShTSC5jYF8U/58oxmKxG/dvJcyYwJfy6d/XE
 MGOeYL97ljOwig4OWVGXMuwH6XO2V873dAIg/aDRH9MvDlIwEUJrtQJyz3lw5FR4PwOFOCUjm
 RQXnqCvYHROH0G5FjG9lVfbx261KViVmaxcCtPlMRnRpfB/OEAcjDRvWDzgPREiMPF9cOIUDC
 0Ya1NHROo2f1G5pNxhPgCuHSXnm8IMhYl2kk7FkV/61btqK4DgKhHKCOixScRGXIKY1qLpuHX
 4th83BSMZ6+ZddWj+nGsm7XRzUx8NHBalVimoMVgauu9TN0qkmG/Uy/UgVhjvp0RbqbAIFMCS
 ezoVuvSX7suJWKXH+YMi6MAKW1+AA2RyhcIJSOV+S9CldWLcS1AP9GEnvYIx7/Qj6irSylcI9
 e+Ja5ETYa32j8qbYmJWFOANm0DPi4Bj+1Nk8eKy4RfJzG6jhDSpSd705D8eBbyeXJlOKLMpZa
 G+NjbdDTRl4YnN8iZXhk8QH8BUD5apInMpZ7qmBSDRrE4=

On Sun, Mar 10, 2024 at 04:15:33PM +0100, Michal Such=E1nek wrote:
> git version 2.44.0
>
> git am -3
> ../linux-6.8~rc1/debian/patches/rk3588/dw-hdmi-rockchip-avoid-tmds-spam.=
patch
> Applying: dw-hdmi-rockchip: avoid spamming 'use tmds mode' in dmesg
> fatal: empty ident name (for <>) not allowed
>
>
> What's wrong with that patch, specifically?
>
> Can you tell?

The message seems to come from ident.c

Is there any chance to get a copy of that very file ?

Or more details ?

