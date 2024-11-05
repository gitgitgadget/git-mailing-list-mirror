Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1988B65C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769966; cv=pass; b=FRla53vl2VhFxD2nEhKV9QQFfB2XJGGzohqIxtFvl8njgjJJgaNFNIGiHjZGKcISlm2XLOT4ly0bQMRQy/PRm6p0sAQiZxw3l2c0SI1djy7gdD55cUP/FBGE2TnNijHuS2g8jEhVga+lHFBx7DkLEkpQpnrKR1wlpx0Qh6RfJLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769966; c=relaxed/simple;
	bh=NXBSO9gW3goMpB/YxLakb6NlQzIFajB2RVdL+nVmAFM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvKzX/042HAbokhX4i4FRe2pjTv/AjV3CUB5ObLcJutVVUf6+zdQ09PWsT5Rj8mwOePg0h9sZ2xjbnclWG0YqbpVNB1S+g1SaDZQm2t5yv/CYRCRjEI27wSDkNXRzEEJtniQAv/xiDFf+nEan+t2ljGco1pbN7U8UZ8y1nlymzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F12C28A6B7E;
	Tue,  5 Nov 2024 01:26:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-107-236-127.trex-nlb.outbound.svc.cluster.local [100.107.236.127])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3A7148A73AE;
	Tue,  5 Nov 2024 01:26:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730769963; a=rsa-sha256;
	cv=none;
	b=3DMgId65QaXl/1JuHgLHKIRQNMOobb6PU46F8ydQghwb1T6J3GXUOCK/Cutb20nxaeq15x
	OKFkKuGA+qT2wgg7D9qLgGP8X1a3nbDGCSQ7KG5YYyfvI1SSeZnxtdFCrYFO4HLoF66Xwx
	iQhqWSxhOABEX15QW9lwrJ/4lWB1nDmOI8ZNDYcSJTTMUa8Z18fXlglD4sT4NnyigsgClV
	ZYEvSQztPqZeiaVgg5I5/wWOpW+Q6R9N3oV0Lo6dp+AGDVZ+mItWw50LD5DrPdBQ4ycVlq
	mKOFPRiz1FxhGB2e2jWSEBt3/c18KVCS7PoqsBvKR21H25xzdkgHd/wdBQIXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730769963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXBSO9gW3goMpB/YxLakb6NlQzIFajB2RVdL+nVmAFM=;
	b=RnR35nJ89Iz+qMi1Eidae2fnBGp8Z5HYj+yePWg1WehN9wee1OZFObiFVEyKrBq3EJjSQ+
	blW8sNFMwttvT24v7nsPxiPGI+0Qm8v1A7rA4e5CHQ1p/SqbNPy4uETjE4Ts/qcHQx3Uu5
	8onwVqwwFTX0CjBJBhI9oHwLDIbotgx9ncaTkGzmt2jUB2RXzvy943i6kVya3Y3sw0EIUU
	zFyrBaSJ4wQwZO7zw41firbxejiQHeeghrQp0MFjo8nxDHGNLXQT52CXJdkrIgZeuiJsBW
	mngJQVL43C+zInTqmhzsH46NJ3826kj/mKmR7TusNIlx0+D2AfQOxa0uMRhjmA==
ARC-Authentication-Results: i=1;
	rspamd-6c6b6c849d-drj77;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Hysterical-Harmony: 6781ec53112a6729_1730769963853_1346184606
X-MC-Loop-Signature: 1730769963853:2051222892
X-MC-Ingress-Time: 1730769963853
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.236.127 (trex/7.0.2);
	Tue, 05 Nov 2024 01:26:03 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:63330 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t88KX-000000069zy-19az;
	Tue, 05 Nov 2024 01:26:01 +0000
Message-ID: <83639e75d9d04208aa0dee345d9ef3536de105c9.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Date: Tue, 05 Nov 2024 02:26:00 +0100
In-Reply-To: <305dc9f7-4bdb-40c5-92f4-7438a9ecd482@app.fastmail.com>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
	 <305dc9f7-4bdb-40c5-92f4-7438a9ecd482@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Mon, 2024-11-04 at 23:15 +0100, Kristoffer Haugsbakk wrote:
> It seems to me (totally na=C3=AFve) that you would do something like
>=20
> 1. Blank line terminates headers
> 2. Then there might be some optional commit-headers which can
> override
> =C2=A0=C2=A0 things (`From`)
> 3. Commit message
> 4. `---`
> 5. Look for a regex `^diff` line
> =C2=A0=C2=A0 =E2=80=A2 Now the indentation will tell you when it ends
> 6. `^Range-diff` and `^Interdiff` can also make an appearance in this
> =C2=A0=C2=A0 section

Well as you've seen by the follow-up, such a naive approach is not
really possible, as the commit message may also contain ---, unified
diffs, etc.



> At first I thought that it is a magic string for a reason.

I think such magic cookies can always only (safely) be used to detect a
type, but not as a separator, at least not when free text is allowed,
too.


> It did the right thing for me with this (last part) of the commit
> message:
>=20
> =C2=A0=C2=A0=C2=A0 We should look into Pedro=E2=80=99s backup system.=C2=
=A0 Why does he use
> email?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff --git a/a.txt b/a.txt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index ce01362503..a32119c8aa 1=
00644
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --- a/a.txt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ b/a.txt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @@ -1 +1,2 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hello
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +goodbye
>=20
> ***

But yours look indented? I mean then it's clear it works.


> It seems like it would be nice if format-patch complained if it found
> regex `^---$` in the commit body.

Actually already when committing... cause there it's taken as valid and
then it should also work with any following tools.


> The magic string is unlikely but could happen.=C2=A0 The solution is to
> use
> an indented block.=C2=A0 Same for the diff.=C2=A0 (Hopefully few have to
> code-quote diffs)

As written in the other mail, there is nothing real obvious for the
user that this wouldn=E2=80=99t be allowed, and in fact committing and such
works.
The simple problem here is the fuzzy format which cannot be parsed
properly.




> But escaping things in this format?

Coudln't one do something like this:

If the line consisting of three - is the line that ends the commit
message, check during format-patch whether it's contained in that.
If not, generate the patch as now.
If so, use another magic timestamp and/or (since that might get lost
when sending as mail, set some X-git-patch-format: header, there adding
perhaps a flag like "escaped" and if that's set, any line that matches
the regexp:
>*---
get's another > prepended when escaping, and one removed when
unescaping (well in the latter only lines that match >+---).
* =3D 0..n
+ =3D 1..n

Or probably thinking about some more sophisticated solution or at least
a better character than > .


> > btw and shamelessly off-topic question:
> > Any chance that git format-patch / am will ever support keeping
> > track
> > of the branch/merge history of generated / applied patches?
> > That would be really neat.
>=20
> What does this mean more concretely?=C2=A0 :)

I guess I want what's been asked there:
https://stackoverflow.com/questions/2285699/git-how-to-create-patches-for-a=
-merge


In short, imagine I have the following commit tree (just a simple
example with --no-ff):
*
|\
|*
|/
*

And I make a series of git format-patch patches from that, it would be
nice if git am *.patches, give back that structure (i.e. with the
branch and the merge).


Cheers,
Chris.
