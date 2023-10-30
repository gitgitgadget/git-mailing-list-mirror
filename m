Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5196190
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hDeEbERo"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABA9E
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 17:23:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 964721AD8E2;
	Sun, 29 Oct 2023 20:22:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+3YIhi8x3+jujbsCAaSKSwCgPjGeeJ6oT043hI
	IdN7Y=; b=hDeEbERoNVgPY57RiRHPmTPqEzPQnHELkp0Li7ayIS2MWutfuuJg5x
	szXYUSrntefsmeh0loNan6IR9LSh5HB6Xd+LDhbwIbJYSg8KNZlZGZ+54dZbzeWk
	dQOqolO86qFwwADwtO5HaHDVeqeXvw9QFAeWy3OWBXbuVyMAUZFPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E9901AD8E1;
	Sun, 29 Oct 2023 20:22:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3BB51AD8E0;
	Sun, 29 Oct 2023 20:22:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
In-Reply-To: <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com> (Phillip Wood's
	message of "Fri, 27 Oct 2023 11:19:04 +0100")
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
	<37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
	<0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
Date: Mon, 30 Oct 2023 09:22:57 +0900
Message-ID: <xmqqy1flez6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7ABB6BA6-76BA-11EE-B8C0-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I agree we don't want to support too many CI platforms but I think
> adding support for GitLab is good as it helps to stop us being too
> tied to GitHub Actions (which should make it easier if we ever need to
> transition to a different platform in the future) and provides an
> alternative for contributors who want to use a different platform.
> ...
> Having someone committed to on-going maintenance is great.

Yeah, it is great to see that stakeholder companies are helping Git
in ways they can.

Will queue.
