Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377943BDA6
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032127; cv=none; b=GjvHXpLR/ibgovLS8Wv1gIl4sZZXlATwBOPmmediIlBXBYyb5ZAUa3+cp30pJt/sdxBDjyrWb9nj1WCvUFKSWVJrJyza9krOP+x6ZyzjunerzmFP0SfDdKeGINMFeW5nb2Jj9UPn8dtlu4GzPVPvj5PuVdCfSp8bjopOX7wgmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032127; c=relaxed/simple;
	bh=L5iiu09njRDOzf6TxGc4/FHqrNHMzqFTwKC5FsR62pI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3EREQHhAVrMBPJUtdOfD/s6wY8CxXkt5CFfE94T61ldeN76RAwjyPpbj/AGgLnsSJZ0sXcqbzHEQF4/GCq4n+Q8rCTfYyYwhPROAPg3QDVzeNBKDFDlCgzJJGJT5KecBHy0Xi7r9Iecdt4Hud7BSaX10gvGFTt436v62oCxSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=IWWAjmBC; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="IWWAjmBC"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 693CtClt011255-693CtClv011255
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 3 Oct 2026 15:55:12 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xCzGi-009ajy-AS;
	Sat, 03 Oct 2026 15:55:12 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 15:55:12 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6aa594aa;
	Sat, 3 Oct 2026 12:55:11 +0000 (UTC)
Date: Sat, 3 Oct 2026 15:55:11 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans <julia@jvns.ca>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
Message-ID: <20261003125511.B8Nsu%taahol@utu.fi>
In-Reply-To: <79451beb-15c4-42f3-92fe-1b7fd284b21c@app.fastmail.com>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
 <01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com>
 <xmqqo6dbvlaf.fsf@gitster.g> <20261003073303.G-Gck%taahol@utu.fi>
 <79451beb-15c4-42f3-92fe-1b7fd284b21c@app.fastmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsHBUhYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=qyKWOWsTZI5znoK6jSZj3E8SCn8gk8SMJbQRN+uEJAs=;
 b=IWWAjmBCkWxfWEqpJ4p49QVtqUCuiuT5alzqqw5GZv8mPlK43rHDkhrZryNK2Ts3PkdL9afdN0gu
	Rauv3/apNySVte65fxeV1TLw/R8dKuU/ApYCeI3v2B/1BFFRrFQd6hRwu3VgMfXqdoD7oxHleduR
	DA+u/Dds1UkyORhuh4mE+9/gil4E1cDq94jgtFBWzstgTUepIAuHO8piuqPHo4TqEwFV3QxtySgr
	fYgfXCSYntxpNdgH7jD2QvzchbLyXrOx2T8vj8wZcYC7+Q8kLquF0WmzHtVAPacn/x7Af0x8mvwm
	Nm4cQrIMda+OEzXT6XVD2Xn9i9Cc7o/YRyJSWg==

"Julia Evans" <julia@jvns.ca> wrote:

> > Something slightly more declarative I managed to hack up:
> >
> 
> This looks great! Will use for v2 and mark you as a coauthor, thank you :D
> (let me know if there's a better way to do that also, still learning the process)
> 

Cool!  You can add these before your S-o-b line:

	Co-authored-by: Tuomas Ahola <taahol@utu.fi>
	Signed-off-by: Tuomas Ahola <taahol@utu.fi>

That seems to be the usual formula for marking coauthors (cf. [1] for a random
example).

> I wasn't sure what `$.` was before but this makes it clear that it's the current
> line number (and https://perldoc.perl.org/perlvar agrees). Apparently
> `$ARGV` is the name of the current file. (different from @ARGV)

Yes, the Perl syntax is... interesting.

Links:
  1. https://lore.kernel.org/git/20260711160447.99708-3-marcelomlage@usp.br/
