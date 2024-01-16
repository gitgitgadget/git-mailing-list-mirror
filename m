Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE01C287
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jq22umiy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 152F71E5724;
	Tue, 16 Jan 2024 10:38:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N7lci0JnSN61J5yMCKBbxAwpX5OydepDrgv5PT
	g9VL8=; b=jq22umiyZRbc9oTmJVjwiQ+Oiami6HmKwlGIJ/hfpBHu0RdXhnhooY
	kNESyW3v5J6/Z3/Az/gBzoy2kUeRPS/FXCV0LBKjIWQd6oEAkTK1xpt+7IyU2xQr
	H+pt2B0qFcNzt0kv3iCol5nnmj+3VTlI3lnIAEpZmv7h5nBB18VlA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B7891E5723;
	Tue, 16 Jan 2024 10:38:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70F401E5722;
	Tue, 16 Jan 2024 10:38:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  l.s.r@web.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  steadmon@google.com
Subject: Re: [Outreachy][PATCH v5] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
In-Reply-To: <0d18a95a-543a-41de-8441-c8894d46d380@gmail.com> (Phillip Wood's
	message of "Mon, 15 Jan 2024 10:39:16 +0000")
References: <20240105161413.10422-1-ach.lumap@gmail.com>
	<20240112102743.1440-1-ach.lumap@gmail.com>
	<0d18a95a-543a-41de-8441-c8894d46d380@gmail.com>
Date: Tue, 16 Jan 2024 07:38:24 -0800
Message-ID: <xmqqply147bj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49AD3252-B485-11EE-A01B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for adding back the test for EOF, this version looks good to me.

Thanks.  Let's merge it to 'next'.
