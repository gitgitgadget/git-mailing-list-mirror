Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NpNlRn6L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0CA4;
	Wed, 15 Nov 2023 10:08:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C6A340E018F;
	Wed, 15 Nov 2023 18:08:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iEHahqT_tC2V; Wed, 15 Nov 2023 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700071679; bh=Cv3EjMfWm6FdFawpmRBV/D3gHWyeScSfWQgZtc5gglM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpNlRn6LdX2auEB+rXN06qtGweNXLprYyx6Qm/IdSDZlgCI9ADqfVdyUPnJxZx7Tm
	 2k5WfoxZAjxnCb55AX1UhdQqFuUf7+tsPNFApunDWDzqdW3Rszr9MKYFZxjl4mMDE+
	 0Kw7aaTfKh/HctY3xXhzZn6MJWgxBARu3Rab1uLQBJycSeni0ufKBalP46naIxjh6M
	 HJjwkjy4Qj70vodi9i9uypKQMs3XP6B1jp3uiykKC0qF6eDQhKpu0uWNpnZ6HCYG5L
	 GYdu0AeoUIykOQqpwse3c+1u9g50ILmK6F9mUoqTvoPUNejAEFjhFyGPdOJmrrsWPP
	 fydbUHMCu15jY1SLsWjNb4zYpcEzeJd6HDonmkvbP3rCgL2AB0PtklnfvRbg2PCkNe
	 LqRdNshCHHloPDzVjZ3j1rY7FpcqjPnA7OiTlwjiSBCM9v/x3N6mPn7cqV+KuSMeCF
	 OU2pOhIioJj0nFfvoGYTzlAMe7f3UXbYlq900ZGeh//pV615sbf1wjv7YrOPsB59ds
	 giry0RmKaFEl3sA9+KDHxvvEHlesaDdQH5oACXyh29dkzG6DtEYPNWs0HpNo+R4Qtg
	 1jgRVuHp9ip63UM6RWeSTzjBHBIedwtNT5YVbI4107FLtwhLn2KSGlWNZrzORZMUpi
	 EG+JR0gHBtNDxepZbJCLNTjE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63D8A40E0030;
	Wed, 15 Nov 2023 18:07:53 +0000 (UTC)
Date: Wed, 15 Nov 2023 19:07:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: improve the base commit
 explanation
Message-ID: <20231115180747.GFZVUI84eKiMC9BPs3@fat_crate.local>
References: <20231115170330.16626-1-bp@alien8.de>
 <202311150948.F6E39AD@keescook>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311150948.F6E39AD@keescook>

On Wed, Nov 15, 2023 at 09:49:31AM -0800, Kees Cook wrote:
> On Wed, Nov 15, 2023 at 06:03:30PM +0100, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > 
> > After receiving a second patchset this week without knowing which tree
> > it applies on and trying to apply it on the obvious ones and failing,
> > make sure the base tree information which needs to be supplied in the
> > 0th message of the patchset is spelled out more explicitly.
> > 
> > Also, make the formulations stronger as this really is a requirement and
> > not only a useful thing anymore.
> > 
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> Yup, I wonder if making "--base=auto" a default in git might be a good
> idea too?

Not a bad idea. And if not needed, one can simply ignore it when reading
the cover letter.

CCing the git ML for comment/opinions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
