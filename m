Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F661E523
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2/kkEsy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 79E611FE3D;
	Thu,  4 Jan 2024 15:49:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TFAQaRnxzWu2G5lp98jHUMysKWr6yBD5pvvUJs
	cbvOs=; b=J2/kkEsy3ZE6lCOi8+tvd0ccmBikdYPZqdR2tdwoC3wujj5m1ORwCM
	hb7+gELhXL06qGFUEGLFDL+TAhptWraT0zCQCHd0K610NhSxUoxhJ6UlHf3BGv3/
	yADC70H3QNGisBtn7X8Q+5BBx1JoL2DV/MeJrJZQprISddrIDRnNs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 65CE71FE3C;
	Thu,  4 Jan 2024 15:49:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06C3C1FE3B;
	Thu,  4 Jan 2024 15:49:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch: add new config option fetch.all
In-Reply-To: <70f17f0c-2226-41eb-ae08-348c794a3411@tb6.eu> (Tamino Bauknecht's
	message of "Thu, 4 Jan 2024 21:18:02 +0100")
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
	<20240104143656.615117-1-dev@tb6.eu> <xmqqv8896jqo.fsf@gitster.g>
	<70f17f0c-2226-41eb-ae08-348c794a3411@tb6.eu>
Date: Thu, 04 Jan 2024 12:49:16 -0800
Message-ID: <xmqq7cko7rjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA83A0E8-AB42-11EE-B84D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Tamino Bauknecht <dev@tb6.eu> writes:

> Do you think it is worth adding a flag for it?

Otherwise I wouldn't have pointed it out ;-).  It probably has about
the same value as the fetch.all configuration variable has, meaning
that we either have both or neither.

Thanks.

