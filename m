Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA762C9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038366; cv=none; b=BzQYKWV7OYQlEuVCbjmwrpI2bJIoHU76Mufn2nXWrilY5WWZgXGztzk+IHCNfUBrTge5+FfFI4dCiy7rujAt2Vf8wU89WmDUCF1Uyy/r6D4iNEjwcXRYxcBnAPXX7OIvn6Cmnc5c7Xwdln0tTyMiWYLiG7pmPJVI16Ws8fw3Lh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038366; c=relaxed/simple;
	bh=LpmtXP6zKo9ohzfKtEOqt/+S/8oafi0vMrHDT0AXCJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3ane7EhePsNy+PJGLh56It+lQKNWhaIeoJc80iePHmRRkzTYpjyO0BWaqHaq7S/RVAKOXuHezj5X3aHMnF1eYerbQdQGVNO5N2itqnMmUXawV6xeeUNkJM3uHva1D6TZsXi3njqNEODP4dktJD2+NUgm08mIwL7zo6Q7wstfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cFLW7UZk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFLW7UZk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E34562C101;
	Thu, 21 Mar 2024 12:26:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LpmtXP6zKo9o
	hzfKtEOqt/+S/8oafi0vMrHDT0AXCJU=; b=cFLW7UZkqXBn7qqSKKGPKWpDWses
	hxDXfauB2Eqxk8J6wKdhSVIOBxMWwWWzmpRwhIlcHXQXTDac5iBX/o/XqWJOF4Kg
	/dIfT9DMXv135o4vMZs+PU37xOpcrRVsc0liebtO4HUwZhz2LG8COr7hfP4NMk1Y
	UHWaFdf5feL7pTw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DBD2A2C100;
	Thu, 21 Mar 2024 12:26:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63B8E2C0FC;
	Thu, 21 Mar 2024 12:25:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
In-Reply-To: <519698f1-1daf-4085-9aec-380f44492e72@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Thu, 21 Mar 2024 11:28:01 +0100")
References: <20240320091748.GA2444639@coredump.intra.peff.net>
	<519698f1-1daf-4085-9aec-380f44492e72@gmail.com>
Date: Thu, 21 Mar 2024 09:25:56 -0700
Message-ID: <xmqq7chvblgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B3037CFA-E79F-11EE-B7C9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

>> -'option deepen-relative {'true'|'false'}::
>> +'option deepen-relative' {'true'|'false'}::
>>  	Deepens the history of a shallow repository relative to
>>  	current boundary. Only valid when used with "option depth".
>
> The syntax for describing alternatives is specified as (true|false).

Hmmmm, here, true and false are to be given verbatim.

> Also, in my reworks of syntax, I chose to remove all formatting from th=
e
> term parts of the description lists.

I know we added the _<placeholder>_ thing, but have we added these
to Documentation/CodingGuidelines yet?

Thanks.

