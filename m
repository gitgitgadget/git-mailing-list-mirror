Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF284AF64
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ntQ4XqUq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D68942FCC9;
	Wed, 20 Dec 2023 15:56:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=maXAh2uH9mLdiRwITGfsJ7Xcha4djoK3W+v028
	nwV/s=; b=ntQ4XqUq1b3QNUOSMGe0YMArGORYn2lmhDeI8S67HYmt5Bp0wozVfG
	8w1GHWaJivuxJKy8k4P4jwthKkpiyTlYvQINBhXjtySA81fkRl0IC/O+GRGB+rQq
	Lju/LXF5e8mqrUZbnrjZnnAcc6N9RZWFiQYkO0dEkrRxBBzLhhq9c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CE8502FCC8;
	Wed, 20 Dec 2023 15:56:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76E772FCC7;
	Wed, 20 Dec 2023 15:56:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mial.lohmann@gmail.com>
Cc: l.s.r@web.de,  Elijah Newren <newren@gmail.com>,  Michael Lohmann
 <mi.al.lohmann@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation/git-merge.txt: fix reference to synopsis
In-Reply-To: <20231220195342.17590-2-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Wed, 20 Dec 2023 20:53:41 +0100")
References: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
	<20231220195342.17590-2-mi.al.lohmann@gmail.com>
Date: Wed, 20 Dec 2023 12:56:22 -0800
Message-ID: <xmqqy1dor3t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3C81BE24-9F7A-11EE-B5B1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Michael Lohmann <mial.lohmann@gmail.com> writes:

> Also the previous version did not acknowledge that `--no-merge` would
> result in the precondition being fulfilled (thanks to Elijah Newren and
> Junio C Hamano for pointing that out).

This does not belong to the log message.  Please write for those who
only read "git log" output after the work is merged and nothing
else.  To them, errors in the previous attempt that was pointed out
by reviewers and corrected in this version do not exist.

It is perfectly fine to write something like the above after the
three-dash line.  That is the place to clue reviewers about the
context of this round, reminding what happend in the previous
iteration and what the differences this round has, etc.

Thanks.


