Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D51EAD7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519157; cv=none; b=BQ7Lcns03wb0EXn867Hnc5UyTWHQ7C3Jdi9ueV5nluhupQCupJdcx5/lZX8S6zdkUJ706bsK0FycDu0NGuMG8dnZDMrO7GH4cVFUlkWj3Lt4VJPW7u7gEDqvK7LCtk/89sTHuTqNNBae48Ey+w/1xcIXBFdkRzIgX1cUnY0nAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519157; c=relaxed/simple;
	bh=4wL80RpO4yvegefpL7O+DIiuWVeGWn54VOmnxoX9WSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggfNyT+svRnZuUAPRgTfVnTR+zNs9RD9TZibjk7364B+fx9H4dUg80uTWZ3cQvvZRQPCg8i/h9PTRLJJSkmdf4kWKkuTOa/hAm182SZv3OfCVhfb9GddazqIntjE4CfTkk8PAlRZwOmPXT3SrCztoyBkJmRq2KvC53xOpk4saCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q65qqOzX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q65qqOzX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 330AE1DDA2F;
	Wed, 27 Mar 2024 01:59:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4wL80RpO4yvegefpL7O+DIiuWVeGWn54VOmnxo
	X9WSg=; b=Q65qqOzXxBUYI2J2ZNXOjrceFwPZOthQenpqUU+dLYYzBHlVAD6LmD
	l5mP7JXMbKfC/LUejtNBOC3jHlTdV8KFLg0U8BuhIltIRyO6zFogHV8YI5xgmlRs
	k4wlx93QEdOdyaqgwU0o4KWlIJYJFYRW6H1W1RSVAfy7u6G6AihZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AF881DDA2E;
	Wed, 27 Mar 2024 01:59:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98CC31DDA2D;
	Wed, 27 Mar 2024 01:59:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.txt: perform some minor reformatting
In-Reply-To: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Thu, 14 Mar 2024 20:34:21 +0100")
References: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>
Date: Tue, 26 Mar 2024 22:59:13 -0700
Message-ID: <xmqqa5mk5i6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23E41688-EBFF-11EE-9EF0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Reformat a few lines a bit, to utilize the available horizontal space better.
> There are no changes to the actual contents of the documentation.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---

I've marked this for "Comments?" in a few issues of the What's
cooking report, but it seems we do not have much appetite in this
particular one, so I'll drop it.

Thanks.
