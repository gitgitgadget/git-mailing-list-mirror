Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75723AB87
	for <git@vger.kernel.org>; Wed,  6 May 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096710; cv=none; b=Gms2jKaZPVbgHCaA+Gh1bdZh474lAgV5acJiHsF1QMAzQCLUVEPRQggmmbG3O3Q2ve8ciOsq94XVBsO4L5piYuKmqnkLed2CM3k4xEizRbxxfPbVjaD6B/t3yau3cr7Q5BO+WuagWwG38enxglAUiai8y8W3UmjxV4vKX/PgxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096710; c=relaxed/simple;
	bh=7n/LpfzFxGx41j58yIQUREnVG/+AVMk7PFV9zpA3I/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keQ8Qu4nbCUNTCT5sbzYcs0XTgccApiD7w6vwoYn4QK0PCcZhUZ458+eN+NUH/T8edQYh10I5gzI5iUk8S40qiXLs93fg0S839P272rqvBJNINFSBp3pueUO0RgQqP6VTrH1Y/YsKi1I2j3TyywLOG2GoSZamewH8694ndvm+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Vw9BC8Iq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Vw9BC8Iq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778096704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEb4EtuWYkcidDo1wm+81GSa7TwHTAnWEcRQ/YTzWUA=;
	b=Vw9BC8Iq+MT+vxGeWBSPSaZ081LJOPVot+E8hIGs0ucklWExy11EFf+C0TDmZ2wMGEevSX
	h+ULoG0O9/AazLgVV6MSc+w9jUylOQDA0ZhRzNJjMF6U5cD3iI8+UHCKqDIC3NJDl93+AY
	cy7Z/rUtO+jE66Bx9ufbHB+q87F2oNk=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 6/9] update-ref: handle rejections while adding updates
In-Reply-To: <CAOLa=ZRj11QW16-E6dY2YxDWZ+3moV1h_-S1DfbFPJeOGTjHgg@mail.gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
 <20260504-refs-move-to-generic-layer-v4-6-936ac2f0b1a3@gmail.com>
 <afmFmGo_Sg33Rv6V@pks.im>
 <CAOLa=ZRj11QW16-E6dY2YxDWZ+3moV1h_-S1DfbFPJeOGTjHgg@mail.gmail.com>
Date: Wed, 06 May 2026 21:44:53 +0200
Message-ID: <87o6isqq4q.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> I'll hold off on a re-roll unless needed.

Well, from my side there aren't any extra comments. I've reviewed the
range-diff and this patch, and glanced through the other patches (but
they didn't change compared to previous version) and all looks good to
me.

-- 
Cheers,
Toon
