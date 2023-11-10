Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F3538C
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mT3R+61P"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3485BAA
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:16:48 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BE8561BBABA;
	Fri, 10 Nov 2023 00:20:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LiyVRfis0H5mdP/yHtjaDo+20NVODvDgcbVyv5
	Uy0Eo=; b=mT3R+61PTpMRDRj2ju1EFjg96JlK0uM8C1axBKnc4zZAtBpZUwMtyP
	jBogVtJA2lKynQbp1U+qmcgfMTkpcBlDrcZqkw81eErdffDw+nmcA1erLjZGvz3y
	aCxZdcL8pfrHo3fVOFqmbkFam8eVKPt8Ujb893mBiCwq0kLdIcdcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F51E1BBAB6;
	Fri, 10 Nov 2023 00:20:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D52041BBAB4;
	Fri, 10 Nov 2023 00:20:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] glossary: add definitions for dereference & peel
In-Reply-To: <xmqq1qcyxxri.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Nov 2023 09:22:41 +0900")
References: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
	<xmqq1qcyxxri.fsf@gitster.g>
Date: Fri, 10 Nov 2023 14:20:04 +0900
Message-ID: <xmqqa5rmw5ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0202FE2-7F88-11EE-823E-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I've never seen "peel" used for commits, though.  So another
> improvement might be to say "peel" is "an act of dereferencing a
> tag" here.

I am reasonably sure I was the one who coined the term "peel", and
the picture I had in mind when I used it was to peel an onion, which
inherently was about unwrapping many levels repeatedly.  I think
that is why it felt strange to see "peel" used in the context of
using a commit as a tree-ish, which (as your documentation update
clearly said) is doable only once.

