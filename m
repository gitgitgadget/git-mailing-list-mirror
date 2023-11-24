Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4tSGqxi"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE6D5A
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 17:19:26 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8412C1AD0EC;
	Thu, 23 Nov 2023 20:19:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LnsQfjRFBONJapPb/svrt5g1yCIhMrCaAULFR7
	LQTfI=; b=X4tSGqxi1ijWoHlGZEzTkVc0sY+EkIVihIxq0+aCn8ALRjI7saihFe
	+b+bfgDcLkKVgrtVsKEBDgBWwMsAzXHsqDvQLCZdgf0o5RweaRpezMaiVNu8dG0C
	mds8J962jNj6oq1/d8QxkLiFZL7mtuegPZld48vfZzO/1D3aZwFMs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8B21AD0EB;
	Thu, 23 Nov 2023 20:19:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC30E1AD0EA;
	Thu, 23 Nov 2023 20:19:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood@dunelm.org.uk,  Willem Verstraeten
 <willem.verstraeten@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a
 branch used elsewhere
In-Reply-To: <CAPig+cRdQW-DG8PFb-P0U_44pFWxskVoOtjbGfD_OiHHDk8DdA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 Nov 2023 12:09:38 -0500")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
	<xmqqpm01au0w.fsf_-_@gitster.g>
	<bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
	<CAPig+cRdQW-DG8PFb-P0U_44pFWxskVoOtjbGfD_OiHHDk8DdA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 24 Nov 2023 10:19:23 +0900
Message-ID: <xmqqh6lc9cdg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8136F3EA-8A67-11EE-8FEE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for digging up this link. Upon reading the problem report, I
> felt certain that we had seen this issue reported previously and that
> patches had been proposed, but I was unable to find the conversation
> (despite having taken part in it).

I am surprised that I did not remember that old discussion at all,
and I am doubly surprised that I still do not, even though I clearly
recognise my writing in the thread.

> I agree, also, that this two-patch series is simple to digest.

OK.
