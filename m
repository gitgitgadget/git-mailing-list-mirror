Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC8B660
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752119187; cv=none; b=GXhkPIExH1AXqhyvPc7IimZ7bT0axyrBW/VSjC2CxRlEx+NIpDSAnjlym8BwXq1L9Zs2vSx9Y2EHDYqD/RQAIS6ykgYvc0RKcdqQtaNthVwAHMeTgz2/vtoEypOfj0AEUk8HKKdk64+Pzrol+6Dnxgr7NKvGl1q6PlUNlwMsdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752119187; c=relaxed/simple;
	bh=3D4CSavDj/Ol/584Xm2jgmvMEjlv03xGxqmsRHPPhMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg9/0EtjMlL/WEnWmljSQv5U32/nN4e4fTa56wFgHXEGcxcvwqe5NuesW4MpVj5OtqEtgKogBycVpj4blEY1Mkr8P22aku+kUnH5VeaOcqpdBmPZ9FzP9W9wFY+LT01qtYv48SaGcqcgXp0eGIBuzLiGJdPutd3Uq3aIe9y4Mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dp3xFM3M; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dp3xFM3M"
Received: (qmail 780 invoked by uid 109); 10 Jul 2025 03:46:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3D4CSavDj/Ol/584Xm2jgmvMEjlv03xGxqmsRHPPhMA=; b=Dp3xFM3MVq2WDuNq8+0AmJeOOXSDOOZnkpf8xz6i9NmXsUk3+vDTDlmjAe5abdVZwpnstex0A9jWxlcOrksazr1FPcutAIRzu+OJtuhmf+gaB/EhAVEqnbVZElzYDUq5Hns+qC4DgVr01hS/fKYOY+S5J6ApMzZYlCkfldlTvuHVIVPm0pGNp5fEdKhMNylPq1plCvIsdxEAyiGvVmOQI0KAnurMiB16iM0+uNaGmmBu+9DnzPEkKDKpBrbxLVLS/8qqheHD4aWc+cVjhwI3sFzwbrHh5ixU2no5TW5PVbffcXT7y8kvIDkCXrCOqLfIVcTlKlTwGtEcmzV4ubfPCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jul 2025 03:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21213 invoked by uid 111); 10 Jul 2025 03:46:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Jul 2025 23:46:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Jul 2025 23:46:23 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
Message-ID: <20250710034623.GA2066787@coredump.intra.peff.net>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <20250707204224.GB3115893@coredump.intra.peff.net>
 <CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>
 <20250708225134.GB1180568@coredump.intra.peff.net>
 <aG7wcoy3gTzSd_4w@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG7wcoy3gTzSd_4w@fruit.crustytoothpaste.net>

On Wed, Jul 09, 2025 at 10:42:58PM +0000, brian m. carlson wrote:

> On 2025-07-08 at 22:51:34, Jeff King wrote:
> > Yeah, I agree (and didn't know that before; thanks for mentioning). I
> > think mostly I was just hoping that some of this reasoning and these
> > pointers would make it into the commit message.
> > 
> > The content of the patch looked OK to me, though I do still like the
> > CNCF wording a bit better.
> 
> In case it isn't clear, I'll be sending a v2, probably this weekend with
> more of this information and some updated wording.
> 
> I don't love the CNCF wording because I feel it's too ambiguously
> worded.  What is the "community"?  The open-source community?  My
> neighbourhood?  My friend group?  Can a real name be a username or
> handle that's distinct and unambiguous?  What about communities where
> people share the same name?  (Debian has, or at least had, two
> contributors who both have the exact same full legal name and can
> therefore only be distinguished by handle.)
> 
> I also think redefining "real name" in that way is misleading and leads
> to confusion that might put people off, especially those that are not
> native English speakers.  I know it's common for lawyers to redefine
> language to mean something very precise but different from the language
> that ordinary humans use[0], but that's ultimately dishonest and tends
> to deceive and we shouldn't do it.  Most people take the phrase "real
> name" to mean something equivalent to "legal name", so we should use
> language to describe the requirement that doesn't confuse or mislead
> people when it's used without further context (such as in a social media
> post).

Fair points. I think what I liked about it is that it emphasized the
purpose of the policy:

  The key concern is that your identification is sufficient enough to
  contact you if an issue were to arise in the future about your
  contribution.

I also liked the sentence before:

  Your real name is the name you convey to people in the community for
  them to use to identify you as you.

but I agree that "community" is vague there. I think it mostly means
"the development community", but I agree that we could perhaps sidestep
the whole issue by just saying we need some way to be able to identify
and get in touch with you.

> I'll take some inspiration from the CNCF post and rephrase to make it
> more approachable in v2.

Great, thank you.

-Peff
