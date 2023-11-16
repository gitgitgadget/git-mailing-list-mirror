Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqTGTA0l"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42391125
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 16:27:49 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C77711D573;
	Wed, 15 Nov 2023 19:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=38EFxBIIoGbeVwnAnf7cDsZ2GP6izn7DBCM0MS
	CShxs=; b=GqTGTA0lLQQoYnBGdYp5b8uPWOpkIR5Hv59vuff4Kxf1F9PWb/yexz
	xXyXIEErpyly3kCzV5sk0zSjT3TvtArlo7ngsrh29E3M6dmOa8c4NUHnmENqn/SW
	o4tNUq/m4yT5GUwIXRZFkDIjLC+aAc4Ya4Ify7BWMJW6xiAIE95cw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BF5EE1D572;
	Wed, 15 Nov 2023 19:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67F2E1D570;
	Wed, 15 Nov 2023 19:27:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] rebase: support --autosquash without -i
In-Reply-To: <eb62435f-08ca-494d-bcc7-2568df2bd7fd@gmail.com> (Phillip Wood's
	message of "Wed, 15 Nov 2023 15:09:12 +0000")
References: <20231111132720.78877-1-andy.koppe@gmail.com>
	<20231114214339.10925-1-andy.koppe@gmail.com>
	<eb62435f-08ca-494d-bcc7-2568df2bd7fd@gmail.com>
Date: Thu, 16 Nov 2023 09:27:43 +0900
Message-ID: <xmqqcywawni8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F67A48E8-8416-11EE-8622-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Andy
> ...
> Thanks for the re-roll this version looks good to me
>
> Best Wishes
>
> Phillip

Yup, looks good.  Thanks, both.

Queued.


>
>> Andy Koppe (3):
>>    rebase: fully ignore rebase.autoSquash without -i
>>    rebase: support --autosquash without -i
>>    rebase: rewrite --(no-)autosquash documentation
>>   Documentation/config/rebase.txt        |  4 ++-
>>   Documentation/git-rebase.txt           | 34 +++++++++++++----------
>>   builtin/rebase.c                       | 17 +++++-------
>>   t/t3415-rebase-autosquash.sh           | 38 +++++++++++++++++++-------
>>   t/t3422-rebase-incompatible-options.sh | 12 --------
>>   5 files changed, 58 insertions(+), 47 deletions(-)
>> 
