Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012420;
	b=CNhMLqONeFjr6aSsAvUAyXqolIi3YIwOJeBeaVayTjAdp8hiMIjz1ow0aQwJYF6EBDko
	 IKblf6ZZtWORofRrBI+WWgZzBtQhltw4ModpId1fe3Ydu4isXZINvrhbijCjdblRM3+hI
	 tJSqg6JYT70uy2sQ6lhDjOK4m4evK6g4a3W98F8zGX/AZWY02cRbgsfJXdlmpIutG9NW5
	 8qr+0pRx1z1F5G4QFGLWLbn1wmkiiG6LXtDA7rT8xQ3PBruwfmZy5xKAU4hHP9SkZZjff
	 n4/Q1Xz5/jKY3bfIjtZ3P0mh9JBpxIWPzUIp+UlEGYy+zt4ARdzH7rdZnbrJWstf1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012420;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=s81tTVV8NrS60U8FpNJzexBGwVORszh162Pyg0PBQCY=;
	b=Q1fjzQGe7kZr5u74k3+75HQQuPDUQ4ZI6/Tuib6MIQQFdsvEs/8TRs0uMuSz5+sW61hO
	 i2azIX9iM8evkFBNwgTz2k17qiAVbZ4rUHvp6dUm/RpcU9wVlfJK6mWdQgdPzVaMzq+q3
	 GfmOgbANuUJISloUJubFy8mEruiaodu+NbmboBAby9G/129yNbl/C8gb5NhjKBMkyao9y
	 hwsjXM3xnLrgY5gJqVAEak0FpXOEiaVxP/I5Amf9ZuMmbzf9QZ9BnUvy0Z+E+aLvc4SZ+
	 D/3pEhv36LJBQiBilwGuD2DrgQKg/q82PwnLrHaDFCcrtM+s+EbOhfxKp3U+CFGia/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=bBUK8YE2;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4226606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4226606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=bBUK8YE2
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69QB09n0002479-69QB09n2002479
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 26 Oct 2026 13:00:09 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xLIQz-007Xkp-3w;
	Mon, 26 Oct 2026 13:00:09 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 13:00:08 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id c87d4436;
	Mon, 26 Oct 2026 11:00:08 +0000 (UTC)
Date: Mon, 26 Oct 2026 13:00:08 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans <julia@jvns.ca>
CC: Julia Evans <gitgitgadget@gmail.com>, <git@vger.kernel.org>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261026110008.Rixj1%taahol@utu.fi>
In-Reply-To: <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi>
 <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhbWkgDGgEbHAcODg0aAAkdDxsK
 CQMDKA4JGxwFCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8F
 CQEERgsHBUhYSFlbSAIdBAEJKAIeBhtGCwlIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=s81tTVV8NrS60U8FpNJzexBGwVORszh162Pyg0PBQCY=;
 b=bBUK8YE2J1K+0PN0uBYU8pvFrbGkVf++9gSILquGks2qeEFRduiyJBP9Avcu1wTgeZ1Fi+QVr/hc
	1xZy/N0RQJqdVc0TZt96NTB8w+Mf3m4yBz4ZogXXA5GdaIV3J0+Ze2JL5uPHabK6TIfrWgP4p9CK
	mapHnZJWwpzR2XNtODbXJmdESsxa30Uh4ZX3nnivhz68+cxNrV2OVZBQIVAasaSCmUgrOcOCehJ2
	VDUevQU/ocitREkyZyOgIoixfKnnr0RAGXhLqpoGHatwYxCyqHlK6VUBN2G1MSapIf4d2Z7NpaSO
	vteMyzztPWx+jjViJ8h2tNpLKdAuGIgfDFKe6A==

"Julia Evans" <julia@jvns.ca> wrote:

> 
> > $ git diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2 
> > -- ':!po/'
> > diff --git a/command-list.txt b/command-list.txt
> > index 5c649c882e..63ae2a67c9 100644
> > --- a/command-list.txt
> > +++ b/command-list.txt
> > @@ -244,6 +244,7 @@ gitrepository-layout                    
> > userinterfaces
> >  gitrevisions                            userinterfaces
> >  gitsubmodules                           guide
> >  gittutorial                             guide
> > +gittutorial-2                           guide
> >  gitweb                                  ancillaryinterrogators
> >  gitworkflows                            guide
> >  scalar                                  mainporcelain
> >
> >
> > That, as can be guessed, causes git(1) to advertize this "obsolete tutorial".
> > Perhaps we would like to avoid that.
> 
> Agreed that we shouldn't advertise an obsolete tutorial. 
> I'll remove it from `command-list.txt` on my branch and submit a v3.

Just a friendly *ping*. :-)

--Tuomas
