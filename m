Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647262253F2
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416587; cv=none; b=jILuL9kwyL2j8c9swsS7Ebcmk3yp39TmyGCovjsLNdZx+DyiidYBYeI6d3sogKxYre8hBMv06hVph8fHq4gdWq3oGMANVcOvuUVxAXQMC87lKwrRlbIosfdN6iTZhM19uXn0ucoPy8DlP6pWrG+h/kxvO0R8tvS/XOJl0ndF654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416587; c=relaxed/simple;
	bh=fpRRrbdePNkDlVOlle+oUqGXNDle0gdK21vzY81/+7Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HANdv5GPt+yew46UMLfl0ofDPpanTbdsV7iM+rcGnIb5Arw1VFA8OJwFPL22v0qeKaKSfaJNU2EdB4QUSqEOvohBHbCV7S5i+NCKvVN+n9oi2Dvg0gPZiHs3yI67EhL1S9u7uJk5W55iufw6GQc4w09fzIf8RbzshyDomwAg9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mroach.com; spf=pass smtp.mailfrom=mroach.com; dkim=pass (2048-bit key) header.d=mroach.com header.i=@mroach.com header.b=knrSmogv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mroach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mroach.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mroach.com header.i=@mroach.com header.b="knrSmogv"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mroach.com; s=key1;
	t=1762416582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpRRrbdePNkDlVOlle+oUqGXNDle0gdK21vzY81/+7Y=;
	b=knrSmogvHzE8c8r0NL+cJPyHPkkhWYWaAjOTMlQmW58GRTbwXx7nSoT+RNl6Cq9RAAw70r
	XyKppvlQHGaX2nLN6FnHfOKUQYDGegNzie3cW69zMjnrsW/wqG1O4niRcCEtSGmAFKE7T7
	tBc8KE10H6HNLkdmc7m81Cxu+Y6ExKrXHepBph4V6jr6xR99JYcRCUrjghNVkD18egb7Qi
	/OaelG0imMhW4uxI01a7e2O0a6lpMo/RXn4EBj9Fdn+C+qaqSfaca77dtJd/iruTOe4zCD
	0Q69sMMV6majYPgVGXZds+KPEJ1CCQdymW4caHxSgEVr7HJ3mWznkDTpZ8clCw==
Date: Thu, 06 Nov 2025 08:09:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Michael Roach" <mroach@mroach.com>
Message-ID: <616fa0e461f2bf15bd3588914091fd9214183a8c@mroach.com>
TLS-Required: No
Subject: Re:
To: "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.com>, "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <FE487800-06D5-46ED-9C78-3C42EC62EB4E@gmail.com>
References: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
 <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
 <F8EAD922-315A-42F8-8E77-5C562B5041ED@gmail.com>
 <9f8acce4-1a4c-4f4f-b8f1-827d778fe6e3@app.fastmail.com>
 <FE487800-06D5-46ED-9C78-3C42EC62EB4E@gmail.com>
X-Migadu-Flow: FLOW_OUT

Sorry I didn't do a reply to all on Kristoffer's response. Can you tell i=
t's my first time here?=20
Thank=20you both for your time on this!



November 6, 2025 at 01:05, "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.c=
om mailto:lucasseikioshiro@gmail.com?to=3D%22Lucas%20Seiki%20Oshiro%22%20=
%3Clucasseikioshiro%40gmail.com%3E > wrote:


>=20
>=20>=20
>=20> Sorry, I didn=E2=80=99t see that he only replied to me previously:
> >=20
> Thanks for forwarding that!
>
