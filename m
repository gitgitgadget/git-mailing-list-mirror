Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F017F4
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sz50Eyba"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0C11C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:32:32 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D5A31C50AC;
	Mon,  6 Nov 2023 20:32:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2gqcX6Kjp60OVNMNBsCUfjFTO8pkiL3aINMd9x
	Zi6bA=; b=Sz50EybavPNKBLAj2R2QyUcgIdCEdQkZKeyUrAm9RAawFVJHytuFff
	SqLokwFwPytQYfTPhJpV19UX5dklRKhtGoC7dwKjOEtIsx1r7/rOmqtejrt3cJrH
	S7pwYHBQDjtaECc+V8Dv+/CdjHcdA1AA6t2ZUm7lUI4LVKy0lcfuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 94B181C50AB;
	Mon,  6 Nov 2023 20:32:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E7791C50AA;
	Mon,  6 Nov 2023 20:32:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] RelNotes: minor changes in 2.43.0 draft
In-Reply-To: <20231103141759.864875-1-tmz@pobox.com> (Todd Zullinger's message
	of "Fri, 3 Nov 2023 10:17:49 -0400")
References: <20231103141759.864875-1-tmz@pobox.com>
Date: Tue, 07 Nov 2023 10:32:27 +0900
Message-ID: <xmqq4jhycpqs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8395B7DC-7D0D-11EE-BFF7-25B3960A682E-77302942!pb-smtp2.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> These are minor changes from a quick reading of the 2.43.0
> release notes draft.
>
> Todd Zullinger (2):
>   RelNotes: minor typo fixes in 2.43.0 draft
>   RelNotes: improve wording of credential helper notes
>
>  Documentation/RelNotes/2.43.0.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks.  Applied.
