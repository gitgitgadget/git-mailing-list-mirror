Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F820156D8
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: me@ttaylorr.com
Cc: git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <ZZ77NQkSuiRxRDwt@nand.local>
Date: Thu, 11 Jan 2024 11:45:07 +0000
Organization: Gentoo
Message-ID: <87v880m6r3.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Something I'm a bit concerned about is that right now, neither
rustc_codegen_gcc nor gccrs are ready for use here.

We've had trouble getting things wired up for rustc_codegen_gcc
- which is not to speak against their wonderful efforts - because
the Rust community hasn't yet figured out how to handle things which
pure rustc supports yet. See
e.g. https://github.com/rust-lang/libc/pull/3032.

I think care should be taken in citing rustc_codegen_gcc and gccrs
as options for alternative platforms for now. They will hopefully
be great options in the future, but they aren't today, and they probably
won't be in the next 6 months at the least.

We also do use git heavily on platforms which rustc isn't supported
yet.

thanks,
sam
