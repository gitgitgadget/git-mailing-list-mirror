Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DE22A4F1
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337734; cv=none; b=lpT4DGfDmEzgalUiJo8BEKwZMudJAuzENBFwQfbUaehSwNI95fEi/JHKcXI1NoYULq64DlfIpgcU2z30IiK0rSWKTSFbPi6VmspFwATk5zuBou05yg14eY5spytcI865UVkL+mP046HkH0gEXIEh/Cawi2H2D5G8bjQqpaR7wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337734; c=relaxed/simple;
	bh=Rotc9vCeEp1xTje2pVsVke5YCCUYgKsdTu1y93gzD0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8e9TtGvnwGJF2zlfcufFh+aXgP0nop7H6OMeFqUWCoZ2eju/0g1eTM1jaTrKF+z8Rmqp/u4FXznmPMNrHc96wAtKDwUh9cQxncg+duhzmfSq7I/fvk0NZ/UN3HjDb7n9gNqHsBZXB4/p/Imzh/cOL0uNxndY9UnDAlkq9NsiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=O63fJjs9; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="O63fJjs9"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 87A22B00571;
	Thu, 12 Mar 2026 18:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1773337731;
	bh=Rotc9vCeEp1xTje2pVsVke5YCCUYgKsdTu1y93gzD0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O63fJjs9pCVwHqegsZSOWLZGgTo1f4vjOamLdBhpeiInjSiQw2LkJKdNC5CIQhmWM
	 0Mkrkbnm407wVxDpI+yGhr1iZjpFDQpUiDx/rfVnpg/yrwlAK1nPLJrcYqz8nH7qDn
	 ZZMJyye65TBQdsVqy0sT1g5BCMvjSGqCDGfPCAiUcUKIDZ/I22e1ahhlF+yBBveZvp
	 j8J/hNHbOxjUC8rMTXOYBwho5u4ol//xEHkyiQ41cUa1PQVQTFGtlD0BgQP9pZ94Su
	 /JC1KxwtQsuQiOUPZBiHDzTjoUk7uaCMAEVBBZOPT8YHtx7z1BIldRTDTnHfMLdt5N
	 9bDyV4ndVFPtg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject:
 Re: [PATCH 3/3] doc: config: convert trailers section to synopsis style
Date: Thu, 12 Mar 2026 18:48:49 +0100
Message-ID: <3411126.44csPzL39Z@piment-oiseau>
In-Reply-To: <doc_interpret-tr_config.48d@msgid.xyz>
References:
 <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
 <doc_interpret-tr_config.48d@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

Except the replacement of <keyAlias> by <key-alias>, this is all good.

Thanks




