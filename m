Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8618D
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DFd0W4x2"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6D1B6
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 17:12:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 177251B1ED;
	Fri, 27 Oct 2023 20:12:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=67nj7mdjEE/zlOE2NAMqeGNLNVX4TLoiVn5soY
	LkP40=; b=DFd0W4x2+CnO/Wv256SHA75rKNUOFeMwy4vtRiYRe5tGk5O/MC55xz
	jb405fLIr2dlCDgvF8xnFxPKZsq5BMJ26/4GrMP9L1XJWBeYWLCPmGjRESZHjWym
	tGedOmfkAN/CXWA6tJkoABlzKghvqfXcDf/lYGpufqWYflrxAVZLQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 111DE1B1EC;
	Fri, 27 Oct 2023 20:12:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ACFAC1B1EB;
	Fri, 27 Oct 2023 20:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Liam Beguin <liambeguin@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
In-Reply-To: <20231027184357.21049-1-five231003@gmail.com> (Kousik
	Sanagavarapu's message of "Sat, 28 Oct 2023 00:10:30 +0530")
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
	<20231027184357.21049-1-five231003@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 28 Oct 2023 09:12:06 +0900
Message-ID: <xmqq7cn7obah.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A1B4B16C-7526-11EE-9161-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Liam Beguin <liambeguin@gmail.com> wrote:
>> Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email addresses
>
> Since we are adding both '%aa' and '%aA', it would be better to
> to include both in the commit subject, but since it is already long
> enough, in my opinion
>
> 	pretty: add formats for domain-part of email address
>
> would convey the gist of the commit to the reader better.

;-).  Very good.

>> Many reports use the email domain to keep track of organizations
>> contributing to projects.

Grouping @gmail.com addresses do not smell all that useful, though.

More importantly, it is not clear what "Many reports" refers to.  If
they are *not* verbatim output from "git log" family of commands,
iow, they are produced by post-processing output from "git log"
family of commands, then I do not quite see why %aa is useful at
all.

Thanks.
