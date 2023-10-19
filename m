Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090AD354EC
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0pEDdUB"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8463DCF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:20:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E42129C53;
	Thu, 19 Oct 2023 15:20:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hiodw/q66vJkOoGUDPMv1pi/fVeu5+zMdbEtfx
	MsiUQ=; b=P0pEDdUBtFpIBdTiS6NoRt0hSZp5rRDzDHX6F495w6oaGZsmmbuDxv
	IEVSh4na6U2c/h0U+fYcOcIuUEBzpURlBhqQwfOSx6VfAc8pmmHxSEW7djyKwL8z
	jHNRZOKV1aszFhLnw1aakNKJewdCXvw+xWb6tZiLdwXiF4BnFrcQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2725C29C52;
	Thu, 19 Oct 2023 15:20:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F2FB29C4E;
	Thu, 19 Oct 2023 15:20:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: calvinwan@google.com,  git@vger.kernel.org,  johannes.schindelin@gmx.de,
  linusa@google.com,  rsbecker@nexbridge.com,  steadmon@google.com
Subject: Re: [PATCH 0/3] CMake unit test fixups
In-Reply-To: <20231019152726.14624-1-phillip.wood123@gmail.com> (Phillip
	Wood's message of "Thu, 19 Oct 2023 16:21:48 +0100")
References: <xmqqh6mzwe24.fsf@gitster.g>
	<20231019152726.14624-1-phillip.wood123@gmail.com>
Date: Thu, 19 Oct 2023 12:19:58 -0700
Message-ID: <xmqqfs26whb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F442324-6EB4-11EE-9D26-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I need these fixups to get our CI to successfully build an run the
> unit tests using CMake & MSVC. They are all adjusting paths now that
> the unit test programs are built in t/unit-tests/bin

Thanks!  Very much appreciated.
