Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035123ABAA
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215892; cv=none; b=L9gWnqCJwFtc6YDWKtlOx7WqwEz61oxzs9sWTn8T7P2r4TJ0pdcLaUqWD2wRXQqWEqpSKuf0RZi2P84hpwYqfqMKtSWsZi/anqwaAcpuRxS5jwaPq35cHSzvCDJJFR/OBjRePxFG8cKk95nBv40vEFf8jP08QpR5AxTj1ZgsYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215892; c=relaxed/simple;
	bh=2zoVrssYB97LvPNSRAZsWOd0X29/DUz5KR4+pwjbHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiCHxUNPyBC/u56SMNJX+dbmccXVoLo50C0djcgBZoEoLMpig4ES1Zn/76PdSvKw9zUCGE/lWOfa/fC3cc3KXVQMBxBO9Qz+c59NoWtbzlx3YnUjubnB0/Dk2HmSipTfiZtxIFpdfcgiS0cvQOtLalC7CRWjrWNxmnlaptJoS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=nU2LGcwP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="nU2LGcwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768215889; x=1768820689;
	i=oswald.buddenhagen@gmx.de;
	bh=2zoVrssYB97LvPNSRAZsWOd0X29/DUz5KR4+pwjbHO4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nU2LGcwP5zxp9h3DT6oDlPup4FC313Ou0dPF26EcLANqiZButFwR4L/fwoygWTsC
	 DS9BI5R6a8bt0EwZnx60BGNRKyz8Ipp3pKBm0KSWAWwLpudZu3H3tA1X0pEcVKzQN
	 qefmU/R5MKZ5vWfKCnO9C0yO7fb5G5p0kZEF0beYsxXJb5EyjtbTXxOi9/K+dR3//
	 IvqjBNg9YDXoad2sjrSplzhUf5h3BXRtVGfSPYxVdAUcxtQzEJJ7vI30W5MfcDoHF
	 jA2jB05i1+ZHpDDJPPf8qM1Zecn61e1eSuVBEa6rslt12d/r8ryjNqbFdYJVPExQr
	 hTE2nri43hQdDvIcsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.102]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1vSnFC0Gw7-00PbRc; Mon, 12
 Jan 2026 12:04:49 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1vfFj6-Od1-00; Mon, 12 Jan 2026 12:04:48 +0100
Date: Mon, 12 Jan 2026 12:04:48 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Krzysztof =?utf-8?B?WmFixYJvY2tp?= <K.Zablocki@student.tudelft.nl>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Idea regarding GIT
Message-ID: <aWTVUC8WuHxePfRO@ugly.lan>
References: <DU0PR09MB8272C80E049596044EF581C2B181A@DU0PR09MB8272.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DU0PR09MB8272C80E049596044EF581C2B181A@DU0PR09MB8272.eurprd09.prod.outlook.com>
X-Provags-ID: V03:K1:7QtDX3Z/RgwBAK00KMrKuBmmRyZyTLc45JNDIA1s2i9ZNm6UiQq
 dhxsDa84XPkUSwgJaJqGWRYXmJOsRE++vHyztdTXdDhFssS5YZRsRmXUKwjs5TygpNXDWoN
 uCIPhygc6nNuru54jrwHrJtVCAtvsgqYtl1vPLO6WB33vI1vSb6yPu02ewpYiPyt++eTKQ1
 5HTRnpqXADkhXNpUs2cfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CC6b3G8jamg=;NEzkkrR4sstDRJqieVqd/GioE5S
 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

On Mon, Jan 12, 2026 at 02:53:49AM +0000, Krzysztof Zab=C5=82ocki wrote:
>I propose adding
>new configuration file (or parameter in .gitconfig) .gittemplates. Files
>listed in there had to be indexed before adding them to that file, otherw=
ise
>it would work like .gitignore, but difference is if file was added git wi=
ll
>not track changes in it and won't commit them.
>
at first sight this sounds functionally equivalent to "precious" ignored=
=20
files, which was discussed here[1] last time.

[1] https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@g=
mail.com/T/#u

