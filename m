Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D347D95F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135059; cv=none; b=Skv9JIPiyj37A77937LZvC1j8fsU0tha89tDQBBlKdAnlepSCrsI3KqfwrYl3GcS3FoxKISk5ZU+REJWSoHb6Q/JnFq5QXL0SL1ORM1g3X47NVxDMqHV10gBxBLqv2PqzZ/pj/87A9gWAnGSIEQv9e2K8dRXGkCrHuj5GbyWaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135059; c=relaxed/simple;
	bh=DPbzBZM/grmyAVpqva6aOrp0IK1Cz316uA7XnRpV3PM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTIiygkhrHe7P6JZJGantv4w4x6S0RI8gYXhCsFSsbMiGjHAOw4xLm56qbP9ReP5QzS+yBqggNn91etsGGml2eytFuoT/Iao9rFtgSNaVeG1wlyUGwEVAM60v70iQREbjnCxmziehafWaebMd5FitC+0p9tMDrATMCcjCQt1Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=jtCtYkb6; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="jtCtYkb6"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68BDvGO7021067-68BDvGO9021067
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 11 Sep 2026 16:57:17 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x51ki-005Nmu-NJ;
	Fri, 11 Sep 2026 16:57:16 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 16:57:16 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id b3034edb;
	Fri, 11 Sep 2026 13:57:15 +0000 (UTC)
Date: Fri, 11 Sep 2026 16:57:15 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "=?utf-8?B?w4Z2YXI=?= =?utf-8?Q?_Arnfj=C3=B6r=C3=B0?= Bjarmason"
	<avarab@gmail.com>, <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH 2/4] .clang-format: Add a
 BitFieldColonSpacing=None rule
Message-ID: <20260911135715.N3vhE%taahol@utu.fi>
In-Reply-To: <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
 <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-07.utu.fi (130.232.247.47) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWkgaGwoNCwMNGigGDRAKGgEM
 Dw1GCwcFSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhdSFhIWEhYSFleSAkeCRoJCigPBQkBBEYLBwVIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEc
 GxwNGigYBwoHEEYLBwVIWEhaWkgaGwoNCwMNGigGDRAKGgEMDw1GCwcFSFhIWlBIGwkGDAkEGygLGh0bHBEcBwccABgJGxwNRgYNHEhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=axoiZrCUbrj7M9TXxPGLiNY2liBu58Jv22bqcV85ogY=;
 b=jtCtYkb6ybBFomZD529zifs0xfRsI/I6XaO6FpkQnSnDKsr9+hK15wXuc8RVdM5To8MjXpvNAdA6
	ZAiX2N9gjQrN+EiflfSK4U8a8hAAYyFLW6GRYYfOneFdr7zvjsCxHaPpdbx/Atm+xEpPqgDRUBZS
	4ilcnAMBCUrHe+lOsfDl/SzWSGIfX7+obWifA62aQ+a1RKnm6aCJbJkM6QX1r+jMFIibWAbXxyRP
	o7JdqTFFMr+EDZPcPU01SfKoWW1pXv47whfTc3he3HHLFIv2vDv/G7R9SKmZqOc3YKpRhdGMo2Au
	jRrvnperlP7xBuPFumgOwY2McxskiQOTf8o1oQ==

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On 2022-07-11 at 11:37:26, Ævar Arnfjörð Bjarmason wrote:
> > Formatting bitfield as "unsigned foo:1" is the usual style in this
> > project, not "unsigned foo : 1", which clang-format will use by
> > default.
> > 
> > Before & after this change running "make style-all-diff-apply" will
> > yield:
> > 
> > 	582 files changed, 32029 insertions(+), 29794 deletions(-)
> > 	579 files changed, 32065 insertions(+), 29818 deletions(-)
> > 
> > However this highlights a major limitation in this approach, because
> > clang-format v12 or newer is required for this rule, but that version
> > was only released in April 2021.
> 
> This isn't supported on Debian stable, which has clang 11.  I think we
> should expect that to be a viable development target here, and I know
> it's what some Git developers actually use.
> 
> I think for now we should drop this patch, and we can reconsider it in
> the future.

Hi!

That was four years ago.  Are we now in a more blocker-free future?
