Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D330F4FA
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771633044; cv=pass; b=JRgFLpZ21lo2q38Ksxxu+RbLqazZQxopuott6pPTP80FapzlZiwxnyTGy2RRktrwmPYKWagsNmroYQFV9SpAxnv/f/rN/LOEi0qN8JkU1YpBfYHFtrJys2gRSMX0v5HyKcssUx5NE38mqSSU843kHoWPYKhx6CenC8JcqfK2e2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771633044; c=relaxed/simple;
	bh=Rbu+MKnw81IzxIopFCOobmGAc9ne+/x4eIshTKvNXmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UMRElzaG+2fd8jAOQwf3zQbmOthzrJYJYwwXd0maWKpcUgedud2aRb/qxh8IyEyrjPfIebeYqgwozYU7EpS89NrxIydAVHAmdvWTUUi6Wl5DXO96NuOWmYuqmkc8zY8m7VMisvV6rm9aq2isEM8Tck7UbVk/AERheNInK6OmLNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
ARC-Seal: i=1; a=rsa-sha256; t=1771633036; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ebm2XiDElqOj4dax3046n1AwmTDLNlJFFECvGOm9zpYnqmSSvp/2VvnhFfabccZPWAuX4fIwdbs3A1IDDxp7tw47t4wrxaWD7G4PyYj2BiQrj2JIqXvflmBMjc65HmjQ2+lW0dqzDwg5HTUXofHP9LsFzIjlIIi6SullVkS4QoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771633036; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rbu+MKnw81IzxIopFCOobmGAc9ne+/x4eIshTKvNXmU=; 
	b=AHyVB1DrYqur4UmnQFjhMK10GogdXuD7QX6UZtdtOwUW4SEXy03KON6HhfSvfe9coSIaUOYsH6eQUGazAYuzeSfZOMxVLKXD1cr3o9kuFkVjGBBY2sE43Poih4lybLzT34NMb5AjJdwHZH+/rmji+NpKT92lB5SbmbAf6kKLUgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
Received: by mx.zohomail.com with SMTPS id 177163303380439.09981663986014;
	Fri, 20 Feb 2026 16:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 19:17:11 -0500
Message-Id: <DGK7HUXGOPXD.3HKUNKYC06PF8@ritovision.com>
Cc: <git@vger.kernel.org>, "Eric Sunshine" <sunshine@sunshineco.com>, "Rito"
 <rito@ritovision.com>
Subject: Re: [PATCH v2 0/5] gitweb: fix broken mobile layouts across views
From: "Rito Rhymes" <rito@ritovision.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Rito via GitGitGadget"
 <gitgitgadget@gmail.com>
X-Mailer: aerc 0.21.0
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
 <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
 <xmqqo6ljujkl.fsf@gitster.g>
In-Reply-To: <xmqqo6ljujkl.fsf@gitster.g>
X-ZohoMailClient: External

If any regressions do show up after merging,
I am happy to follow up and address them.

I ran into gitweb on mobile while browsing the FFmpeg repo
and the "panzoom dance" of needing to use two hands to pinch
and zoom and pan around just to read each line was a real burden.

It's a relief to resolve it!
