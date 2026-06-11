Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471F30E0E5
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184527; cv=none; b=UIwSiYe6FUBXFS/3P9NgXsZPOpTSHlWh7C7ZBLuJZjr6OfycYR5B48bXIK3AdkGa+oOiRWDctBL5McHhbUlVPHbDZePGfQR/WmN5Dt61EyH/o5QzilnBsFVsM52vdApW0CnmXaDg3wRzRYBB7eQEFr3b1+pci58uF03HmQHPoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184527; c=relaxed/simple;
	bh=Vzdx2OF19wRATwuDTbzvxr1Eo3KJRzKoFLD+WKT0C/w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpOewmsJwtZTARJnDS9IeRVwcMEi2sC1P35FMUc30HMfXjHHdqGXQli1S8PsKy8r0oP2q3HZCHNfQ8oQPBaE4iZhag4VhW9QGROfiZjtZU20FfgxZZepG0G5e8y9Waazym/WkpeugUCWcvJduXWwFuOXVvQwiPPsuxmpEL4F5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Fu0A5T/i; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Fu0A5T/i"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65BDSVAF029967-65BDSVAH029967
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 16:28:31 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXfSR-00GI2z-5U;
	Thu, 11 Jun 2026 16:28:31 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 16:28:30 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 679b5dc0;
	Thu, 11 Jun 2026 13:28:30 +0000 (UTC)
Date: Thu, 11 Jun 2026 16:28:30 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Jeff King <peff@peff.net>
CC: <git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight
 markup
Message-ID: <20260611132830.FZ0Ks%taahol@utu.fi>
In-Reply-To: <20260611083139.GA2237523@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi> <20260610225513.6269-4-taahol@utu.fi>
 <20260611061156.GC2187173@coredump.intra.peff.net>
 <20260611080242.lqXwi%taahol@utu.fi>
 <20260611083139.GA2237523@coredump.intra.peff.net>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFleSAIGRgke
 AQQJKA4aDQ1GDhpIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=N8AshGkPXNUwRVHwPfWA9IvxPwm/zExgjSk2Ed0iISI=;
 b=Fu0A5T/iBP2lr5S5qwyFOaV+cLJRUE3nktiGZnet/put5xA9gFFy5fYbL1fEiaFIEKXwZlZ8cocS
	Wc9OR5wANuijp+uPu/c2UDk2S/s79Apfhv00fcRw15NYWeoe1RclZgp94HOLHqrI6mvRXZGFS6iH
	G2kN4RseTNiT+ADbY/v/3kfKuw8ne+28v/3w860OXKMSkyLeM9wl/DM8vhl5SzrUXY6MfMG2srXc
	c3v6wWybl9pnBQQVc+IXTD61LyKQAuahkdU02WK/JrnWxmZ0lsQkRCupF5KBiulmZqkoUVu+b79W
	wozkov6Va6V21gFVqLXAqUigA8SV+y/L1W9dhA==

Jeff King <peff@peff.net> wrote:

> On Thu, Jun 11, 2026 at 11:02:42AM +0300, Tuomas Ahola wrote:
> 
> > > >  If _<message>_ begins with one or more whitespaces followed
> > > > -by "#", it is used as-is.  If it begins with "#", a space is
> > > > +by "\#", it is used as-is.  If it begins with "\#", a space is
> > > >  prepended before it is used.  Otherwise, a string " # " (a
> > > >  space followed by a hash followed by a space) is prepended
> > > 
> > > I saw the comment on round 1 about this second "#" on the line. But
> > > while we are here, should we be doing the one in the context, too?
> > > 
> > > -Peff
> > 
> > It seems adding that second backslash was already too much, as doc-diff (which
> > I neglected to run before submitting V2) shows:
> > 
> > ```
> > $ ./doc-diff V1 V2
> >  
> >             If <message> begins with one or more whitespaces followed by "#",
> > -           it is used as-is. If it begins with "#", a space is prepended
> > +           it is used as-is. If it begins with "\#", a space is prepended
> >             before it is used. Otherwise, a string " # " (a space followed by a
> >             hash followed by a space) is prepended to it. The resulting string
> >             is placed immediately after the value defined for the variable. The
> > ```
> 
> Heh, it would not be the first time I am baffled by asciidoc's parsing. :)
> 
> Adding a backslash to the third instance "fixes" the second one to me,
> but I wouldn't want to rely on that (plus it breaks the third instance).
> 
> Using backticks does work, though it always opens a typographical
> question. When reading the source, you see `#`, so you get a punctuation
> delimiter but no typographical one. In the rendered output, you'll see
> it in a typewriter font (assuming we fix the config issue), but we'd
> lose the visible punctuation. I could live with that.
> 
> But for " # ", it gets weirder. We need punctuation to call out the
> spaces, but what should happen to the quotes? They are not really part
> of the literal string, so should they go inside or outside the
> backticks? I think it may be a moot point as "` # `" is not parsed as
> you might hope by asciidoc. Doing `" # "` does work, and is probably OK
> enough here.
> 
> -Peff

Okay, I'll change those to `#` and `" # "`.  That seems to be the best,
or the least bad option right now. :-)

--Tuomas
