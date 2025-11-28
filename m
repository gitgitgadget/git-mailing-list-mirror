Received: from mout.freenet.de (mout.freenet.de [194.97.212.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E92AD3D
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.212.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307193; cv=none; b=ARafH5F8pupiKHI/elp3uQCV/z9HlPNfGn1wT93Ay0zHVu9ITv1m6qaGR8b4/8H+/rbgxvbLLbTsLmDJEbQTgBLtlU33bA7jqEDu5p/uiVxeWFYkaQW7AR3dgLY9DjYdexpL5evHTqRV+ql7vC7MRY8dQgp4Bdyy8/UARbKYgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307193; c=relaxed/simple;
	bh=VOscc8wcx/0X9OhSqQcaHAVBlDlTxgogCPbsLzFrgOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EtlNfBpmOOG/Ywy3LyFfiiJ8vjdrcmqn04o8ZsowOOzqZiTrGi/DQvHkivY19QZpOQra1xOmPCTSFoDmvk2OCPn3KujHvHJ9DhqW49MKYRRJm+lmwHja3vUZhwBPn3LTdJnuudGd/AXF6ZTpNWhQZQiuuIk+y8Dnhn84QqWlyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=UuqkY/DH; arc=none smtp.client-ip=194.97.212.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="UuqkY/DH"
Received: from [2001:748:400:3319::4] (helo=sub6.mail.fnrz.de)
	by mout6.mail.fnrz.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.96 #2)
	id 1vOqoK-005t4t-2o;
	Fri, 28 Nov 2025 06:14:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=glGjaKnzk2TmqV1GZ4D1sWAqs0NChYVgJU1jtlM1TDY=; b=UuqkY/DHYI7ObYOrinZcwtGgR5
	MFABQEvPc2/EjyRpRjuknSjReCe3u4t0odl+v7QHkK+EuzRueBoxmGoK69y/gGtlqWVzcO98/qVez
	hZlvVLj0vxpkn5peYQerSsHKimnqvQ8llG1O2E/OjkwBlRLPBRxlZi7v1Bm8/FFxgDi4S+exMNDj1
	G5zMUUTidtIatcUBEPvmUqsM8pg2GR9PuYsfAcHCcYP3FVNB+AzO6IiY+UMqCBFGCb3/Yi6EFLSUa
	KI7yEAWV2dhr343otoVdCC2k7q2AurXrOzyjFgiVC6W9wLMqBdkGJoL2mTj1CTepbYFjmGBQGUL+f
	1CeP5LiA==;
Received: from p200300e2e7037400dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e703:7400:dacb:8aff:fee0:ca63]:42082)
	by sub6.mail.fnrz.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.96 #2)
	id 1vOqoK-00GVAm-2S;
	Fri, 28 Nov 2025 06:14:24 +0100
Message-ID: <1a65fcbb-0a44-41f2-bba5-e0670a312ee1@freenet.de>
Date: Fri, 28 Nov 2025 06:14:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible German translation bug
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Ralf Thielow <ralf.thielow@gmail.com>
References: <aSjehThPX8-WeQR7@fruit.crustytoothpaste.net>
Content-Language: de-DE
From: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Autocrypt: addr=soekkle@freenet.de; keydata=
 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
In-Reply-To: <aSjehThPX8-WeQR7@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1764306864D4B71E0FF901O
X-Scan-TS: Fri, 28 Nov 2025 06:14:24 +0100

Hi,

for me as a native speeker the translation revison as "Revision" seems 
much better to me.

Best regards,

Sören Krecker

Am 28.11.25 um 00:28 schrieb brian m. carlson:
> We have the following string in Git, which is translated as follows in
> Spanish, French, and German:
> 
> ----
> % git rev-parse --verify nonexistent
> fatal: Needed a single revision
> % LC_ALL=es_MX.UTF-8 git rev-parse --verify nonexistent
> fatal: Se necesitó una revisión singular
> % LC_ALL=fr_CA.UTF-8 git rev-parse --verify nonexistent
> fatal : Une seule révision attendue
> % LC_ALL=de_DE.UTF-8 git rev-parse --verify nonexistent
> Schwerwiegend: Benötigte einen einzelnen Commit
> ----
> 
> In Spanish and French, we use the translation of the word "revision"
> because `git rev-parse --verify` can permit referring to an object of
> any type: blob, tree, commit, or tag.  For instance, this is a blob:
> 
> ----
> % git rev-parse --verify v2.0.0:strbuf.c
> ee96dcfb816625436582833d812a7156513d5d39
> ----
> 
> But in German, we use the noun "Commit".  I admit my German is not very
> good[0] and my technical German is effectively nonexistent, but I
> presume "Commit" means "commit" and if so, that's simply not accurate in
> this case.
> 
> It looks like in other places in the translation we use "Revisionsgang"
> for "revision walk" and "Revisionsliste" for "revision list", so maybe
> "Revision" is a possible option here, but that would be better decided
> by someone with a much better command of German than I have.  Of course,
> I could be wrong altogether, in which case please accept my apologies
> for the noise.
> 
> [0] I do hope to improve it in the new year, though.

