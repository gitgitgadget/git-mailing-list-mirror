Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BED176238
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592166; cv=none; b=jbyAQ/ycr+u7pvUc7JLqYahxO/sHfaU4Ijw0vMW3A+KArdbqFInx/qbJZnxmZ3Lsqp6gNxmpCcaEdKB5GvPasI3NfSNOnsfIouXJR0TsVE6n+wbg12f8bMsQ2+wfkVSQCWnj4WCu7JtCYJ68ukMSIJXbKVhi1dwcZw6QMaXWLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592166; c=relaxed/simple;
	bh=jqMhnvtK0XSYe04VXklj79koDAToZ9fe+tE5Ik3ia5U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zugubw+yNnEyyn1GDIE6A1cCzIcpTrz/+oni6MkwccsfW6MDeKLKZPbSh3aq05lI5EJhxcQmLrZ8n86ah8ozz1cwLJuDT11sxEgHYCm022BNIMxZAlv6LOaG2/70BN3f5IevGFirjUsUPGw6rgvncmxJz9FwtPHS8ELPbRqjT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=S5fLehYk; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="S5fLehYk"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 654Gtwmo017251-654Gtwmq017251
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 4 Jun 2026 19:55:58 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wVBMM-0036Fn-2Z;
	Thu, 04 Jun 2026 19:55:58 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 19:55:57 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 32dbd3aa;
	Thu, 4 Jun 2026 16:55:57 +0000 (UTC)
Date: Thu, 4 Jun 2026 19:55:57 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] docs: fix typos
Message-ID: <20260604165557.MWQuu%taahol@utu.fi>
In-Reply-To: <92fe3db2-83bd-4aa9-a1f4-bec01dfaf8ca@app.fastmail.com>
References: <20260604131457.19215-1-taahol@utu.fi>
 <92fe3db2-83bd-4aa9-a1f4-bec01dfaf8ca@app.fastmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhbWkgDGgEbHAcODg0aAAkdDxsK
 CQMDKA4JGxwFCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIWkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIW1pIAxoBGxwHDg4NGgAJHQ8b
 CgkDAygOCRscBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=CyEnJgVNW5xQF41XLyZIigQnvWtFpot9MFhMr/wM/fk=;
 b=S5fLehYki3aTXx+IRY469EWgHSxf6yHnmmHi2OAb9+lGLzJpURwKeuFGcHT1uQr1cIknaBH+ZqhK
	sMcbmEMf/5RAacj+YeRVUWMu1HrjANKCfFkgZoYYwqOo6Ms+nLJdnm9pn1JnS/6cOyFcaWtt7IHp
	4mUp0CEOMOZsCEWQjhUGA1xUmstXwhldHiJerlx0smei4DQW/4R9KGyfgjcV8a8bHHdQzkJnHoLU
	JZSy47iWXVjs0B2kgtCNdhixVmq+JD6mUOuUFjcliDEht3560Dlb5xpNCJU9ge0KIAvsQN9vkYfU
	0ruL7vKtmGzn/M5EzGsZIpGqAYjMpU7QlaaJDg==

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:

> On Thu, Jun 4, 2026, at 15:14, Tuomas Ahola wrote:
> > [PATCH] docs: fix typos
> 
> The area `docs` isn’t correct since you are also changing comments in
> source files.
> 
> `*` could be used (as in a wildcard). Other people have used other
> things for “treewide” changes.
> 

Hmm, I took that from the other typofix patches we have currently in `seen`.

> >   * The tm->tm_mday field has an additional logic of using negative values
> >   * for date adjustments: -2 means yesterday and -3 the day before that,
> > - * and so on.  The idea is to deref such adjustments until we are sure
> > + * and so on.  The idea is to defer such adjustments until we are sure
> 
> “deref” could have been “dereference” but this must indeed mean
> “defer”. We are putting off a decision until later.
> 

Yes, that was my own typo.  I always meant "defer".

> >
> > base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> > prerequisite-patch-id: f827362e061e199150f149dd36c67664c77406bc
> > prerequisite-patch-id: e5b32f0b916ec86eab6631b9bd9bafd639191765
> >   [...]
> > prerequisite-patch-id: 083f554bc5e09ae54c6b545628196e11a9e90cea
> 
> Okay, these must be all the non-merge commits from the topics you
> merged in.
> 

That's true.  Quite a list though.

Thanks for review!
