Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906221C6B9
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="huLJnoU0"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE50FE
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:53:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 726891B05C7;
	Wed,  1 Nov 2023 19:53:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QYqkf9UH4dJj
	hELtKwXyVrOHS1QCgstWICD3IiN1F+c=; b=huLJnoU0JUd0HvQ4HjZPiNLZTQlZ
	XNB1u7C9h0Hri89TaOkb9O8SL6a4rJX95SYBOny4uH+nf5QC6vu5tjM9KCFkRb8n
	OxDCitHnvaEACEmychx84qZOIQp8v6/ek2ZjaVs8oo+d6Bp1AQGgKfAjgB//0MKq
	JvbfmeDCydBqpqU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 696C81B05C6;
	Wed,  1 Nov 2023 19:53:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1BE51B05C5;
	Wed,  1 Nov 2023 19:53:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument
 placeholders
In-Reply-To: <20231101192419.794162-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Nov 2023 19:24:18 +0000")
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
	<20231101192419.794162-1-sandals@crustytoothpaste.net>
	<20231101192419.794162-2-sandals@crustytoothpaste.net>
Date: Thu, 02 Nov 2023 08:53:25 +0900
Message-ID: <xmqq8r7howsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D9A812F0-7911-11EE-96BE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: Martin =C3=85gren <martin.agren@gmail.com>
>
> `git merge-file` takes three positional arguments. Each of them is
> documented as `<foo-file>`. In preparation for teaching this command to
> alternatively take three object IDs, make these placeholders a bit more

Minor nit.  Don't we want to say "three blob object names"?  Unless
we plan to grow this feature into accepting three tree object names,
that is.

