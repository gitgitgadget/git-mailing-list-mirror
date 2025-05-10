Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A0199FA2
	for <git@vger.kernel.org>; Sat, 10 May 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746866095; cv=none; b=t0DAv1BzHrtmbxZ0eu+WiI/v1L8wn1WArfdfsgAcT2vnzmojGDAuLhFEEU/4EhH4b+tn7pxBkz1ey6q9XIfKHaIlirAijs/6LEYpSGzG0+UHweayQSkdnSLW2baTpU7wd1hBCicwLtE+TI24hF3hmuZcaxFpn9wiaFMFuNPvhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746866095; c=relaxed/simple;
	bh=kKqfJ0lUyBICN8FljAyn1Wgs2C1rl+aPlTzXSUeIdR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqW4Fou0NKHXMnhZKJB0RsBoUCVsOkWVdhb5EJww6v3g+PYDbOzSEFef3EqQn6jhtWzRA6WOh3+YfkBALhItKtU8g2DHEEezC/Qeaj3Z5GSWmHxZ8NBoLlwege9iz6PiXshlgdn1be9uM86uW8D8eVy6u+5hyK1lsVN/gxIQ8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=eKD5wLlh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="eKD5wLlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746866091; x=1747470891; i=tboegi@web.de;
	bh=kKqfJ0lUyBICN8FljAyn1Wgs2C1rl+aPlTzXSUeIdR0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eKD5wLlhCEFIToTxAOeM1hA6JYpDG3t9BHdpeCJSzbtah1kGwe7NKy40gfa3hvL4
	 Omgc6vXJAIWs2v5F47teE/WDAdVa8/2+ZYGf8m+l/J5M3sInBrp3VFaYBpuCO1Gr2
	 9Y0BCWC/7iStbdy6VegxYLtkcdMaDXt99NiDODb9uK66uKMIo96GX/IYyezTJhNvb
	 xxL1OXRoGJbwCRDEvZgkasCnhNz7WZV4M+WsoHGqgeNUExJgjp0WkZbfvvdwsUkEL
	 62GdQO1hDADJ75cgh/7+JmHkkGiuIvXTkygKq0kkhgssfYHspWQ2AFgGE/26n3Gsp
	 y+2tg8B8fnnyV4t9Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6O7-1uoQ0k333D-00k4rN; Sat, 10
 May 2025 10:10:05 +0200
Date: Sat, 10 May 2025 10:10:05 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Mr Bill <billc56196@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report for pull --rebase
Message-ID: <20250510081005.GA4318@tb-raspi4>
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
 <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:j7TD9+vXyE7FjURb227AQKnAvazNthWp/B/b/JXgOT8jt1SEDCN
 c2eMp/W95pn2HLiC6DguL+vOcd1PxlGTTbXhjb1OWkNA6VNoeug8S8YhXGt3xd0ZsdWcujb
 mVEVo4YT0cCN8jQFIj2PjUm5POtRnQcP9e/w7hvKoQB+mXVDmeLEjX/43EEjcrlapB0lFlw
 91uXjWOjiKRPYMlNgE9xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NTY152osdL4=;ESKhUo8GJx8QVhrY1mkRME6qQGD
 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

On Fri, May 09, 2025 at 12:41:47PM -0400, D. Ben Knoble wrote:
> On Tue, May 6, 2025 at 5:44=E2=80=AFPM Mr Bill <billc56196@gmail.com> wr=
ote:
[]

> P.S. I was having trouble building master (something in the linker
> with _false_but_the_compiler_does_not_know_it)? Revision 1ee85f0e21
> (The twelfth batch, 2025-05-08). Log at

This has been fixed the last days.
The fix works under MacOs,
do you think that you can test the patch, please ?
<https://github.com/gitster/git/tree/tb/macos-false-but-the-compiler-does-=
not-know-it-fix>

Or look into the seen branch.
