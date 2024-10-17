Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE41DD0EF
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166963; cv=none; b=V5d3TO0Z+AEkI4BC4Pmy/lt4A+EPrWBaN6QC09f5tjAat0edRpVn3PGsoHZB7mpAMf7HcVa+M3qaA9tVF+pEc6CufI+/1Oj1m6WE/04Jo4UrMmtJblqKrYyc3rXItrmLAP6eXl4flMBiy43N20MSfOHdUJgAZQ6WrWvndk19OSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166963; c=relaxed/simple;
	bh=o/cDlLnscPex7a61Jc+Q9JblpaNR7IfyLkdbegmOfaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMuKL3aYxx/mCzrYAWVc2FsAnoPdw+R4gG6+hEhissFhQEPBkskBrYgEetn0SMe/ju+be+iTVJBsIex0ORYB1Wu5SM89xgaSyL5P5oerHrjRT6k25Cku+ULMWLou7VG1lpIwdm5iPTrh49PV03bFCH/t+uWU6LOgZ86g89VEP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=RvGympcO; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="RvGympcO"
Date: Thu, 17 Oct 2024 14:09:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729166954;
	bh=o/cDlLnscPex7a61Jc+Q9JblpaNR7IfyLkdbegmOfaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=RvGympcOpqtd4o3o7GbTBYO5wjpb5oLFA+uSwvqKfnzmNwmkCoh1ABhMdi6g0m3Va
	 0X3QAvlnrcQ6RpV2oyrhqOwZmYY/nQuqsseuZt6SgVyGzcYYXLiiWNWItvoR5XRTpf
	 mOAbwA/BbHMtwRyrHlhQvzXviBPafNtcT8vQ4KMMF0r97zjYLxBfQeH36TD8XZs5ba
	 aEc7C3gP0f1sSYweYhozpfhmBD2IUXGusWltY02P0xFMfvCIcXa5mgr9YB+5jV2ySU
	 CHzB6GF0NyApg60b66pD51ueBsQJzqbgMaa96t9yanXql+r7mQgoBuKPZoVCpogyeC
	 d9Z7JikG0QOzg==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <bjk4i7bnlc3bajzjy7izt56mm2ynh6jofbdmqegsmfrzkwqnud@t7qiaonbktuw>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-2-wolf@oriole.systems>
 <ZxASXLz4lA+E9MuQ@nand.local>
 <ZxD7j-ciyAGHrGwM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxD7j-ciyAGHrGwM@pks.im>

On 2024-10-17 13:58, Patrick Steinhardt wrote:
> I think it's also more common to use "Helped-by" instead of "Thanks-to".
> I see you have the same trailer in v4, but don't necessarily think that
> it is a good-enough reason to reroll.

That is good to know, thanks. Is there by chance any document that
outlines usage guidelines for when to use which trailer or is it more of
an undocumented custom?

-- 
Wolf
