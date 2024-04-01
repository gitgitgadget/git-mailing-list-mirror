Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF04683
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009614; cv=none; b=BwS/CtRrgn6eIhdcbyfmEXrv3PJqrcSMxm6Ws/JwgV8BQfJK6ziQkQZlh6/a6HP0NkfQbG8dex/oF7mqR+BAJNt5Ot3DOB3mvxP9UQ4tq2wJg+QlE0pXqFkw1BGWoyYXIPJV6zbIdFkwE2VdjfDV6CcGxyE3Ud+YMPEFUTS9Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009614; c=relaxed/simple;
	bh=6wcxfM+mRKDHyEgd091wVTG6sCEph0RH/Eam2ExWQGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HXTIwC4G5BhK3j6DWkC9mCFfuLiNpKMZ14RfpB9Uq8fquPB0+kaAbuWysrJ8ENqHNKNgfdaTkmSZRr5GlZqqdM0Oe5OAHK/vFi2T9v+Xt4GXugVhWRbQPMB0O1Hrnciyw2mvjsg+WxCSRZFGOa2rkgZHGgoJp4qAMyQg71do974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nFSuePpd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFSuePpd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE1F4231E1;
	Mon,  1 Apr 2024 18:13:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6wcxfM+mRKDHyEgd091wVTG6sCEph0RH/Eam2E
	xWQGw=; b=nFSuePpdVjtOKvGbVitPBQHkkPIRbXmqkCYz8PbHab8q4cKRi/lRGE
	4UPAAxG8/mSi9OSayr3n0kz0IvgH9D5jGUvUfd5cKMd94mzXZhuTdDju27QzawFl
	nP9k3sXe7kWnRHe8u8p++zPehMbK8zXHbRpoNHZZrV6Z+twgzx+Qg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A7D68231E0;
	Mon,  1 Apr 2024 18:13:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E3B0231DF;
	Mon,  1 Apr 2024 18:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <ZgsoOnle3CC8DqUR@nand.local> (Taylor Blau's message of "Mon, 1
	Apr 2024 17:33:46 -0400")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g>
	<ZgPIEgFGVokYWc-H@tanuki> <ZgsoOnle3CC8DqUR@nand.local>
Date: Mon, 01 Apr 2024 15:13:27 -0700
Message-ID: <xmqqzfuc7muw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 118DA114-F075-11EE-BD87-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> I don't think of this as "big enough to require this". I rather think
>> about the onboarding experience for new folks here. Sure, we can ask
>> them to "Please run git-shortlog(1) to figure out whom to Cc". But if we
>> instead provide a nice script that does it for them then we make their
>> lifes easier.
>
> Do you think that the script in contrib/contacts does a sufficient job
> at this?

Yup, that was my first reaction.  If it is not sufficient to
mechanically mine history with shortlog or blame or contacts, and if
we can add a high quality hand-curated input to improve the result
contacts gives us, that would be a progress. I view the MAINTAINERS
format just one way to give such human generated input.

> Perhaps we haven't been as good at advertising this script as we could
> be, and that's why it isn't as widely used as it could be? I'm not sure.

Good point.  Do we even mention it in MyFirstSomething docs?

