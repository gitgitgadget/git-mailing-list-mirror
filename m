Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5181D968D
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819273; cv=pass; b=laMiB1NR4+o0yZljiQxAt2FzT/4BpuRMJr7gseJBj5Re4k4OmdlFWs926u9QnPmQbMauzLp7e+6GV9Ca6g3QW0ao59sUgB/weEg6kak/tNOkcJDt306ovdpvTv8rDPSBtkGE8yNU5bTjDSUDsw6ra4+s6YALWEiJgY5+CrVTTps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819273; c=relaxed/simple;
	bh=/qH6NdDzheIfqoMn4zrQlkPYo+tiagB5/B+rpSiLBfI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqzhR/pWqMxrOQqv6OcfEkrOJH6Gbza2t6za9LYr/uavystsTkhj8tmI6SQcw+RCJZaUQs8ywtpleZQVAevzBcX5kgMBXhrcIgzs1t9n6SHftYbGg//3CmVA2rIGW0xRC4bdtEnVf7Wfexv0TMJPHPB7x0CWXVV0CYyCygNj/wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 97069824C71;
	Tue,  5 Nov 2024 15:02:20 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-103-158-175.trex-nlb.outbound.svc.cluster.local [100.103.158.175])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C8D3B824C90;
	Tue,  5 Nov 2024 15:02:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730818940; a=rsa-sha256;
	cv=none;
	b=trINP85NKo4ldrHQmNcDPpI4bGzby4Q2BkojH8zuFZonU8JyNeNtvuhqYXbb925C525+5D
	/KLvHGufwIa/5f2pIe6+lRHs0rY3slXVoKxsTRyHJeVXqlHMI/q+5tKaA5R6o1LXBJw15l
	mk0/vwATZurTPjHH6gww6wIbYBRzZNiK9cmLnRIAbQY19jQ7EMtwLr+fTzjTZ741rRYvwe
	EdFBqInGeYq/hnrFJ805HWKiN0M1bNWRKrgMgmFeHT8JJcIF4aENv6bMFlHojsHblNg949
	v30cEDU8/uHqNdPQhuUEp+mkma74cqzVj5Lb/T6sazuG5IYnJ1u1sLcDIW6egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730818940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4CMnLXFCwJKbgO8Lg+6BCLJuo9MsxjbUuz2SNmxLsU=;
	b=lNvXHUuwhTd/ck7dq7sp+envhwZ85nLczBc8SlDH8eyP0x+mdqyflhWmwlRXbydpAcUCXl
	9jVAaxtcPpS2efLoif74QBKWpZZ6hKeMJbcMn8guC+aAa1XRQmofDePybAL/SDHFW/8WDx
	WChVTOjLy1cCFIn7HNWY5V7gvVEgI0iPpjBPAdXQjbXUZ+qtd6jGPSWjM2j0JXTU3uFksR
	ibHMpYCmz9EPzm4G68hlqG0tioIxaQvGeh0L07qPRJVYpzo7NxwJcwp+v5UuKb6eH+Qerc
	9XW57S9/ryvYZKfzifwS8dJWzNn8Oq+VaFMk9EkCj3dk5pfNiFvzIpms7LDIVw==
ARC-Authentication-Results: i=1;
	rspamd-696f47875-52qhl;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Print-Company: 3852fa864ddb4745_1730818940469_1401567567
X-MC-Loop-Signature: 1730818940469:1694856613
X-MC-Ingress-Time: 1730818940469
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.158.175 (trex/7.0.2);
	Tue, 05 Nov 2024 15:02:20 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:63277 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t8L4U-00000009S2M-06bt;
	Tue, 05 Nov 2024 15:02:18 +0000
Message-ID: <527da3336bc6cbc550b5cd271dc5689b32f400e1.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Date: Tue, 05 Nov 2024 16:02:16 +0100
In-Reply-To: <43b401e0-df86-4849-8747-d5ab172becb6@app.fastmail.com>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
	 <305dc9f7-4bdb-40c5-92f4-7438a9ecd482@app.fastmail.com>
	 <83639e75d9d04208aa0dee345d9ef3536de105c9.camel@scientia.org>
	 <43b401e0-df86-4849-8747-d5ab172becb6@app.fastmail.com>
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

On Tue, 2024-11-05 at 15:32 +0100, Kristoffer Haugsbakk wrote:
> You could make it more robust with some backtracking, like finding
> the
> last `^diff` and movig back.=C2=A0 That=E2=80=99s OK in a file with only =
one patch
> (`.patch`) but harder to do for an mbox file.

I wonder whether that (parsing from the end) is really a proper
solution or whether it could still break.

A patch can contain multiple diffs, like in:
   From b3b82e59ea52fc059dc23ecc1a3cc0810d297b10 Mon Sep 17 00:00:00 2001
   From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
   Date: Tue, 5 Nov 2024 15:40:13 +0100
   Subject: [PATCH] foo
  =20
   ---
    a | 1 +
    b | 1 +
    2 files changed, 2 insertions(+)
    create mode 100644 a
    create mode 100644 b
  =20
   diff --git a/a b/a
   new file mode 100644
   index 0000000..ae5b3c5
   --- /dev/null
   +++ b/a
   @@ -0,0 +1 @@
   +Aaa
   diff --git a/b b/b
   new file mode 100644
   index 0000000..f761ec1
   --- /dev/null
   +++ b/b
   @@ -0,0 +1 @@
   +bbb
   --=20
   2.45.2


But the unified diff shouldn't be able to contain newlines or a line
consisting only of --- .

So would a proper description be:
From <ID> Mon Sep 17 00:00:00 2001
<mail style headers, no empty lines>
<exactly one empty line to separate headers from commit message>
<any arbitrary sequence of zero or more lines>
---
<a number of lines (not sure whether it could be zero) all starting with a =
space>
<exactly one empty line>
<n unified diffs, no empty lines, no lines consisting solely of --- >
--
<version>

?

Seems still pretty brittle.

>=20

> > Actually already when committing... cause there it's taken as valid
> > and
> > then it should also work with any following tools.
>=20
> That would inconvenience all users that never use format-patch.

Sure, the real solution would still be to do proper escaping.


> It=E2=80=99s not non-obvious either.=C2=A0 The simple format is apparent =
if you
> review your patches before sending them out into the world.=C2=A0 (I=E2=
=80=99m
> paranoid so I do that)

The whole arguing "the user must check what he writes in the commit
message" seems a bit to me as if users would need to think about not
being allowed to use characters like < etc. when they write text which
might be stored as HTML, because that wouldn't provide a quoting
mechanism which an editor could automatically employ.


> That=E2=80=99s interesting and a good idea to use an email header to sign=
al
> the
> escaping.

My first idea was using MIME, but I guess many people wouldn=E2=80=99t be a=
ll
too delighted seeing patches with MIME and the commit message encoded
as base64 or so ;-)

So any quoting should be still human readable (though git already does
use some IMO not so human readable encoding for Subject: lines).

Using something that is already standard would be of course nicer, but
if it's not accepted, than better a simple schema that still works.


> Thinking just about `^---$`: an email header could be generated if
> `^---$` occurs in the commit message.=C2=A0 Then it could suggest
> something
> non-occurring instead.=C2=A0 Simply `-----` or `***` or something.

Should work, but if one has strange enough commit messages, either the
new separator would get stranger and stranger, or, if there was just a
hardcoded list of alternatives, one could run out of alternatives.


If a header would get introduced one should make it generic enough...
e.g. to allow for different quoting schemas, or even to allow for
completely other format information.


> Some niggles: the commit message might just be the subject line and
> there might be no diff (empty patch).=C2=A0 Then looking for `^---$` will
> take you too far.=C2=A0 Maybe just look for the signature line.

Another way might be to simply store in a header just how many lines of
commit messages follow.
But I think that would have also some downsides.


Cheers,
Chris.
