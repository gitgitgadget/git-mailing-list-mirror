Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8981361
	for <git@vger.kernel.org>; Fri, 10 May 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322769; cv=none; b=TSQXCM2VVtrlRBiF/QGdqR9DEt7stzgrffxwamlsLRkJR8RWPczuDJ6j87DROZjcZj7avw3qvL4NURtFP7QRU4Ej6dDkkXXYdR/MlrUw6i3IuWn80vfeUOMj3N+hIuHS5buab7r3h6QzFnoy637zXvVPru4dgelWlCvR/h4U39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322769; c=relaxed/simple;
	bh=rMvvqSFwjwWvI4Kdm2nq3+uO9U1oyeVJm/w9LJRUJlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpsuypU6iyegfyBWUZraHx78a1l7WV/jYSnDDULV8fp4gdTPX41zt/9b/j7d5HXqzJhWIW3TzvrLV403uT/tgxiHecC97YDJkuoI/Gqk9q6pI/B5AFSEzvHkRFZliMv3FdfDjCHq9e44hHChmFwTQVnE6Rhrvxb97NX1Ygu20nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=nmBqKiF6; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="nmBqKiF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715322751; x=1715927551; i=tboegi@web.de;
	bh=vVamt4gMfYOuqX9TnSoU/ewB+WLxyStt1ZhCGneunsg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nmBqKiF6YRnzbAhqM0fDfh7vlD6KFGMv/XHX5vMUCw5cy/KdndZ4LG7sWIeRmdg2
	 VjpwjKMbD5zUvZhwkSq5mmE1ihSKf3r4vVICmKvuxeYWZwER7TZHNvczHT+2f+SPy
	 KvogcrGAY1+bQav4VJFvBeVa894UwveaWhGR23kkCjgdGNN9I93JKLdnmcD30Ro+q
	 zpuDZUL4YBq7cgPr90Y+5Cy3faC1vbiUuwWSM+DDNQXAdmaRQziijXYKMJvIDC6sf
	 +BlSqEGxvS3Ri7PSXM2diBRuECzGQvluywWX8DaqYyKdjKR9uiJa0XI08XxZbOaRq
	 UMDcdSSluNL4thoLag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([213.65.201.17]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1sKDku3rAc-00LY3P; Fri, 10
 May 2024 08:32:31 +0200
Date: Fri, 10 May 2024 08:32:30 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
Message-ID: <20240510063230.GA27291@tb-raspi4>
References: <xmqqfruqsjb6.fsf@gitster.g>
 <xmqq5xvmschw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xvmschw.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:WwJYNNP0hmNSFq88G16bZaKuGfEOd7e9S8cb6Sa4SgRFeU0Jdxc
 0rEU7e3wJCPTqfXqzahFmUsW/aKip8F1U+mo34UaX5Lh7WmWLprqaKOoKCdvM+iiydp2eGG
 zEU0M2siZ1ijQOBOA+GqjEcrR3Opc+c661OYVkmxrVC/27wDehg1pjOrKW4ozUA+Q/AvLiS
 FKkuxwvQnirVutQYfA3Mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fcxxXTU1Kn8=;dpPIpmlTtYELxMVx/z0AHdtWLDX
 7tt6w7ppRhcJW2znCLKz9is1534Ej7ztWZO4mxHR1AaldwlMoR0Oyay/yN1I9Tb1fmYjtEIEr
 l2vxd0hXg+JK2cZYjHYh8T6DLV1CR1L58HiEHFAycZsZBHkbaebyrS06u8yHiSmncDufZws8i
 SWqnYwDWzItjjZ1ZJ/4puq/+xlvz28SLXmnIUx86KJndBxGoeCZQyx/PcyFS2HXgFqOB1xP0F
 p2eHXOEv64iUXcR1qt2sRiXNYJd/mEMQNU+KrT0AAINA7ik9qe424CDjqTyfhMpVC9REwjdu+
 LCA0jJ83dimFEEJmvoZpXaRUR9Srw5EhXmf1ZW8+cGGRjqqzOYYUff+JNGIZhNn2aGQm3wFAS
 mv9zUXsjXoJIwiz9GXin74IKvxD6e4vf1fNKTbnWBsPSmAMJs83hMPIMfP+PVV/BtPnrcd8XD
 DboMuQKcwFT1PWj0JLeEH11Wju1l3cjrVf4hjKElwtOgvvWU2XIE9Z9yiCUEzUtLx+N3vi6pr
 lbCx2iwoAbRc+kYEAPh9uYPrYppfZ/arvyZQr+MK0q8NphUnU4DgoO+SWkUEk2gsWo+OiwMDD
 6QuT3hT2saRgQhGJpH19YVAl3irFFjZEpgltxIfqZYNJat5BYBGpyJbR1vMGy7cZHL7MMiou1
 UkMW9A5z0p6SASGjIWoayg/GAraXoaKF1w8SzoEZLp3aZZyPo4LUm+CW227CbC25e8hwouuFW
 GA9dhZuLTL54QopiS5d5THuN7H4zM6wEctULCDJtDu7TaKAo77DjgPB3Slflz1sHBqamKvo+L
 /9+pON8ALFNLqZk54V+EkSgcfBURSfScj4trdlrt0XBm8=
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 06:04:59PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > * cw/git-std-lib (2024-02-28) 4 commits
> >  - SQUASH??? get rid of apparent debugging crufts
> >  - test-stdlib: show that git-std-lib is independent
> >  - git-std-lib: introduce Git Standard Library
> >  - pager: include stdint.h because uintmax_t is used
> >
> >  Split libgit.a out to a separate git-std-lib tor easier reuse.
> >
> >  Expecting a reroll.
> >  source: <cover.1696021277.git.jonathantanmy@google.com>
>
> Just a heads-up.  The topic is pushed out of 'seen', as it seems to
> be hated by osx-* jobs when linking programs.  As the topic has been
> expecting a reroll for some time, it is not ultra urgent to fix
> this, but before resurrecting it, we may want to look into it.
>
> https://github.com/git/git/actions/runs/9023837489
>
> is an example run where we see error messages like:
>
> ld: warning: ignoring duplicate libraries: 'git-std-lib.a', 'libgit.a', =
'reftable/libreftable.a', 'xdiff/lib.a'
>
> and
>
> ld: Undefined symbols:
>     _git_config_get_bool, referenced from:
>         _precompose_string_if_needed in git-std-lib.a[11](precompose_utf=
8.o)
>
> in both clang and gcc jobs.
>
> We did not see these breakages before, and we do not see these
> breakages in today's 'seen' with this topic excluded.  I haven't
> tried to include this but excluding tb/precompose-getcwd topic
> instead, which I suspect might also work.

I think that including tb/precompose-getcwd should be fine.
As a side note: Thanks for cleaning that up.

I tried to reproduce the breakage, but could not.
The github log says:
2024-05-09T21:33:21.8856440Z ++ CI_COMMIT=3D0c244ffcb1ec0d507d71e244817a3d=
1972acde59
(But that commit is probably gone).

Trying to compile
  commit 0ebed321d488910d7b34953df0e3bc9d5d74ba70 (HEAD, junio/cw/git-std-=
lib)
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Wed Feb 28 12:42:51 2024 -0800
    SQUASH??? get rid of apparent debugging crufts

Did not bring up the problems here, compiling worked.

The problem on the github run is that
  LINK t/unit-tests/bin/t-ctype
failed because of missing symbols which should be provided by
compat/precompose_utf8.c

I am not an expert on the libification effort.
Someone could wildly speculate that this very version of "seen"
did have merge conflicts, that led to compat/precompose_utf8.o missing
somewhere in the Makefile(s)

