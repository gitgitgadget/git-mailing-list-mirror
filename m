Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC126F510
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309850; cv=pass; b=qnrjFCB0nJUjqrreM1ZCQjtl2llmcgOtjwS5jrP2u/gmFFpP8M6KpTblfTze/pjXeq45TKtPhhbeNKFiUHSBrE+lfhtfRmVSqIOBiS9kHU/JGDOgslnPj57aOYDXg924xCQUot4NRdA/wgCvRVyMZbMbd3DgCh8AjNQxc9fooqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309850; c=relaxed/simple;
	bh=qP5SzhaSWwomI6hTgfc2cZ1aKZn8tuGwR6czcMawUCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTol6o4UjcJcR4WVAayKyTMYfcNeTBU5jLts9bn59tHL87KFypHkvLO0mGHNDzCCVxgNFx8sliw/D9fIZgjsapV2RwGRCxqCkYNQeRXkx6HokhggeV/ZxnQPAZqgwPEP97UMWI8QDgdtkVHLn+I0B9+I2Rs4ImuN1G137Z3Blvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3DC24845F69;
	Sat, 16 Aug 2025 02:04:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-blue-8.trex.outbound.svc.cluster.local [100.96.56.14])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2A614845F48;
	Sat, 16 Aug 2025 02:04:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755309840; a=rsa-sha256;
	cv=none;
	b=c7dyZX+wA7A7WqfoexFKagGfMcCsbv+EFhp+LRHCGwiJB6a86vO7jMvAO9GmTxvNOexC9s
	kbPVtkZTH47WOdglO9slQccbHYC5fAuBjBxOJJCGEMHVlKAjnYfOqONC0pqrhdBhAgM5y6
	h628PzaFLfxfdaOHR0OuOYEsrqcMRuyepAlpsKR1FMPY1wL6nLA3hACge0Du3L64DH3uJf
	eVIb9quJw22wi5bXbpTqcH83g4KXh6GDO2qZXk+OT5kBViRjEh1srROUbAMDjqJrD0FOjO
	diTChHzPDzFJVNe521ec7JlVR7XueO8yTIoN2C2IMeu1ncOHZaTWsQDHwi9GCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755309840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4b/IuxfbNQEptzZUffobte0b/MPQJPvgt6aazbbHKKI=;
	b=EhTP6DrojjbAwUMoKJwxugni2HdoQHTSJR1D1AL8Zq5GSQhfk1JuY3BMPHFxZZJHy/A+lq
	+eFNck44zxzL6Gq+DZEdiG/EYDwz8OBh7Q5uhAtA1L8RPrR+2xP27yIvM5oGBe9Bxv3DRr
	iipK0W9UcnPrYmofKLP7ZP7OzJVRAR7KhFIDBOKB8L188gS+Pt0KhGpBz8D2YiTNn9FN+a
	XiwjQw19iRpkKhZ3pXI1QsLyEASLla4/7YF03weprlmElN0cy4eNtdynrlgThtIxfUNICH
	1qM5YppIvn8cjXHpaCtTKZhxWi/HtdX0tCBmZ2gk1TgIQR+eJTF/TKlgmVUUcg==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-mzdjc;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Language-Cooing: 09489c9e5b7cffc1_1755309841108_1787318368
X-MC-Loop-Signature: 1755309841108:3805917978
X-MC-Ingress-Time: 1755309841108
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.56.14 (trex/7.1.3);
	Sat, 16 Aug 2025 02:04:01 +0000
Received: from [79.127.207.171] (port=46661 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1un6H2-0000000Bze0-43la;
	Sat, 16 Aug 2025 02:03:58 +0000
Message-ID: <46840dddbb8a1647539e1b2cd3838167600fcb14.camel@scientia.org>
Subject: Re: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Date: Sat, 16 Aug 2025 04:03:56 +0200
In-Reply-To: <00ec01dc0dd6$f4e31f00$dea95d00$@nexbridge.com>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	 <xmqq7bz5v0mq.fsf@gitster.g>
	 <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
	 <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
	 <00ec01dc0dd6$f4e31f00$dea95d00$@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2025-08-15 at 07:22 -0400, rsbecker@nexbridge.com wrote:
> >=20
> Aside from the above, hiding an existing command would potentially
> allow a
> man-in-the-middle attack. Imagine changing git clone to be something
> else,
> like cloning a hostile repository. Hiding existing commands could
> result in a
> HIGH severity CVE in git - I would consider it as such. Please ensure
> that no
> fix/enhancement is done to support this request.

This I don't understand.

I mean I hopefully never get a remote git config file e.g. just by
cloning some remote repo[0].

So - if git aliases were to be only applied when called from
interactive shells - how exactly could there be a MitM without the
attacker having already compromised at least one=E2=80=99s user account?


Cheers,
Chris.


[0] Perhaps a bit off topic (my apologies for that) but I had wanted to
ask this for a long time - or maybe I've had even brought it up back
then, but there was no outcome):

I vaguely remember the CVE that cause the introduction of
safe.bareRepository, which AFAICS was CVE-2022-24765.

I'm not an expert but even back then I had already some doubts whether
this really *fully* fixed the issue (for all niche cases), did it?

I mean when I do a plain
  git clone http://hackerz.com/rogue/repo.git
then the resulting repo/.git/config cannot contain any configs from an
attacker (e.g. rogue alises).


What if repo.git itself contained e.g. a ./x/.git subdir with configs?
My understanding was, that with safe.bareRepository =3D explicit, such
subrepo .git would never get cloned, so that would be safe.
Right?


But what if I untar such rogue repo... or perhaps more likely, stumble
over it on some network mount?
To many users it may not be obvious, that this is a risk. And I guess
it might even be exploitable by just cd-ing into the wrong directory
(if e.g. git prompt is used).

It's also not really clear to me whether any 3rd party git utils/libs
(libgit2, etc. pp.) may fall for such attack?

And IMO that is different from downloading some untrusted binary and
executing it, as e.g. already a cd could cause troubles.


Is that the situation as assumed? Are there any plans about doing
something against it?

One could e.g. keep a central list of pathname of directories that are
actually considered repositories... and things like aliases/etc. would
only get executed if they belong to these.
A git clone could automatically add the new repo to that list (but e.g.
un-taring some repo wouldn't cause it to be used as that).

Or, in order to allow moving the repo to another pathname without
having to re-register it, any "allowed/trusted" repo could get some
magic cookie in it's .git dir, which is signed by some key from the
user.
Could even allow more than one such cookie, so that multiple users
could work on a shared repo.

Of course this would only fully protect, if all other interfaces/libs
to git would also adhere to that.

And of course, one could make it configurable, i.e. safe.ignore-
untrusted-repos ... for all those who think the whole thing is annoying
and rubbish.
