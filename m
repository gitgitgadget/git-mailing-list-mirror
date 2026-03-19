Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEA348898;
	Thu, 19 Mar 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940115; cv=none; b=CXqK7m6CjU5sBD4aKg9lS3xTDR/GWn9IoaCdpE6m4Fyqc2gIWJVAU7R/+0Y/daT2YEO9+s4otk5vZ7xl8dqgNiG8pAYTlpAfj3YheLJaTiYSP8gJjWzTXjs2paMQyxO5kOt+a10Xi4Y9FK72b/C6kvibXK5jxqa6jlKxHm4H9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940115; c=relaxed/simple;
	bh=JgmAb5YIPz+XYk5Nd4PZUAGgJl9Sgl8XtdAyGM2mwjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOgS9Xpbq3IpSLoWOwvK9tsDkkG54lIG2FGWPc1XLU+2hjcT79jH27Iiwft1Brlft+AWehGd3teB2J4YsmnKzLQCxXBuKCxrPsru03VQh2qYuXvotlAeImd20Q5FmkvugpWKCC7UGVvGbBOta7X2xjiHcEQEAsjLTZzGEhTK19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 50F021A01ED;
	Thu, 19 Mar 2026 17:08:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 5F0B680011;
	Thu, 19 Mar 2026 17:08:31 +0000 (UTC)
Message-ID: <5d28fa8fda122093fcfcf6f948f67184c0c9018e.camel@perches.com>
Subject: Re: [PATCH 1/1] get_maintainer.pl: add --cc option to produce comma
 separated list of emails
From: Joe Perches <joe@perches.com>
To: jim.cromie@gmail.com
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
Date: Thu, 19 Mar 2026 10:08:30 -0700
In-Reply-To: <CAJfuBxxbV1X3X0GdvBEEHB8gS9wQ8hHcKDGC7GrSkOPECgGV3A@mail.gmail.com>
References: <20260319160633.1149562-1-jim.cromie@gmail.com>
		 <b69406326eceb27f5973bc0ba55366438845a003.camel@perches.com>
	 <CAJfuBxxbV1X3X0GdvBEEHB8gS9wQ8hHcKDGC7GrSkOPECgGV3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: erg44sbot3byqaidkegpga4i7tm6hbun
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5F0B680011
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18c2n22DtN3ZcEiYiAwqLPwlq3pe0PnxoA=
X-HE-Tag: 1773940111-901988
X-HE-Meta: U2FsdGVkX18BaN5qRvGDjjJZ8u0MYE9W5lg2takUrGo2xV42m4RgmkXlNpXQaWnjhvbSDv5e5/3/LOBmTn4cs/OGVT5iqQYxpB7casek191A1+99WavGYGBWy1TZfwraJdoZ90yuyqEgsqHvaAeMYa130akoE6AUmjfKdKE8dxOvUNQL6SPzKoiRhcJp1N35lnjkauF5qfcdI/UUjAzGUe1P2hVJnIKRMKlmgEG5ZNvYgYAZRYPzY8KsOECgXRPPUAE4e8Nlo5LjfXrccQHV4Ftkyfh3gAaShoFHFIyc7zyDyo/RkZvCh2oRFVRCixPJlNgkihh+2m3axN+27uc8g5aNdes/ezkJ6yZK8rV/5vN7ecAt3mP8pml2AiHRh6y4GCh0c24Bm2T53UTNReVbVdB7P+qSKUSumhmcIJOtFHhoow/cf1liFAShTiNpELZ6

On Thu, 2026-03-19 at 10:56 -0600, jim.cromie@gmail.com wrote:
> On Thu, Mar 19, 2026 at 10:14=E2=80=AFAM Joe Perches <[joe@perches.com](m=
ailto:joe@perches.com)> wrote:
> > On Thu, 2026-03-19 at 10:06 -0600, Jim Cromie wrote:
> > > This new option works as follows:
> > >   git send-email --cc=3D$(scripts/get_maintainer.pl -cc 0*.patch) 0*.=
patch
> > I think this is not particularly useful.
> > Just use a script.

[1-3] remedied by script

>    4. Configuration Synergy: You can now set sendemail.cc =3D
> ./scripts/get_maintainer.pl in your .git/config. A shell wrapper can't
> easily override or
>       augment the built-in recipient logic as cleanly as this does.
>=20
> That last point seems a clear win.
> Far less maintainer annoyance at not receiving the entire patchset.

That's not my experience.

This _will_ cc disinterested parties when there's a cover letter
for a large series.
