Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191202BE621
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164980; cv=none; b=nrh6i0hOIpOxeb9IXR0Xd6IulXpqH/xOat0h8JaOPFZNGG0N66oaimAydxXlNZM4jgYnAViv47MFdx9hQMY8nnNhmjw1FUlfRM3lb+eyU0NHHgxw0H0XDE5Bn4tt80v6+h+6sJGvAjTdqBZ41aCo8DodjddM5emlHY+6pkA6hfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164980; c=relaxed/simple;
	bh=Lz7QIQdB90TUBwkxlX+4iSwdMeI6NhXd5ZNEKFBPxh4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGhcepCId53+hUepsb0tmNnu6xG3B0uqTrEqp9quCS5/j5uBHGo3RxpK8Ksog/wG1QW9dmUPtz0HnHVSe7F2oxRsDewZSuOg3YdWxEUug2vQLqatDoxO4uXwFpa2O4vehlS69XsValph/0BnlFTQSQNooTFtXxJawNF7tTutrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Mreow01z; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Mreow01z"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65B82ggG016375-65B82ggI016375
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 11:02:43 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXaN8-00FdJJ-SM;
	Thu, 11 Jun 2026 11:02:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 11:02:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 0cb259e4;
	Thu, 11 Jun 2026 08:02:42 +0000 (UTC)
Date: Thu, 11 Jun 2026 11:02:42 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Jeff King <peff@peff.net>
CC: <git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight
 markup
Message-ID: <20260611080242.lqXwi%taahol@utu.fi>
In-Reply-To: <20260611061156.GC2187173@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi> <20260610225513.6269-4-taahol@utu.fi>
 <20260611061156.GC2187173@coredump.intra.peff.net>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZXkgCBkYJHgEECSgOGg0NRg4a
 SFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFleSAIGRgkeAQQJ
 KA4aDQ1GDhpIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=5jTfXqO+4nJGQWUkus1QkpJPRMiPL3g6LMJxDDntpgA=;
 b=Mreow01zwoc1oIQbTIay0ntFWRF4TpbVKM7YT13mvAQYHLFjdRQdbEum+tJLUFzbAOXKOaWNTmQg
	tvLxACXEZeGhsAn/yGuaLMjSvJH8mSYgvBcCphpvtYFfX7iIrzIUl0m9sbP7bW8+dlR3zvsoc+nx
	yuu1G8XFxqD4uDPcgoFM322NA1b8FFHGhLsFiGYSR/LBqsWMVwz+BIy7xOL6PIljBk+gpIsEG/5g
	vS2/QtG+WxaLo39S307JwNJkpMxZt04X5J+Z4YK7Ff1NKXOC4SSpSUqzTbSebZtYrs3YDHRYqCiG
	Kvpuej2J1DZG0XxZ5uPy0IkRU0t7Q/1+Y7d5iw==

Jeff King <peff@peff.net> wrote:

> On Thu, Jun 11, 2026 at 01:55:13AM +0300, Tuomas Ahola wrote:
> 
> > Paired octothorpes are used in AsciiDoc to mark highlighted text,
> > <mark> being the equivalent HTML tag.  To use the symbol as a literal
> > character, it can be escaped with a backslash.
> > 
> > Do so in git-config.adoc.
> 
> I think this works OK, but in general I think most uses of backslash for
> metacharacters should consider using literal backticks. That shields it
> from the special meaning for asciidoc, but also will render it
> differently for the user (usually with a typewriter font, which becomes
> bold in roff output).
> 
> Though curiously the case of `#` in git-fast-import seems not to get
> marked as <code> in the html output (even though the nearby `LF` does).
> I wonder if there is some special treatment of `#` or something.
> 
> >  If _<message>_ begins with one or more whitespaces followed
> > -by "#", it is used as-is.  If it begins with "#", a space is
> > +by "\#", it is used as-is.  If it begins with "\#", a space is
> >  prepended before it is used.  Otherwise, a string " # " (a
> >  space followed by a hash followed by a space) is prepended
> 
> I saw the comment on round 1 about this second "#" on the line. But
> while we are here, should we be doing the one in the context, too?
> 
> -Peff

It seems adding that second backslash was already too much, as doc-diff (which
I neglected to run before submitting V2) shows:

```
$ ./doc-diff V1 V2
 
            If <message> begins with one or more whitespaces followed by "#",
-           it is used as-is. If it begins with "#", a space is prepended
+           it is used as-is. If it begins with "\#", a space is prepended
            before it is used. Otherwise, a string " # " (a space followed by a
            hash followed by a space) is prepended to it. The resulting string
            is placed immediately after the value defined for the variable. The
```

--Tuomas
