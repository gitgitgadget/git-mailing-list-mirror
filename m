Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HFQj93Av"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B09B2
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 14:32:07 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D16F32C273;
	Thu, 16 Nov 2023 17:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H0hyw9PrEFGcK/Nsgh2o5bXQN25WIA7vo2D7G0
	HQYMQ=; b=HFQj93AvpLK39OeAgFjRqHcic+j3sfvd3TjPzPkiNFtJZlq0qkPTb/
	9WO+N82h9o7mZ6ZM+ZuFGXdbmpuSRcPrcySugOKPk4vpGMlmBNIZvigcdDHLJdNJ
	9J/M5zaVoGpy00YRU0rU2Pbfv2kKzR5mS36VeH6unaVRw7ZtN6hVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C99A12C272;
	Thu, 16 Nov 2023 17:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 675492C26C;
	Thu, 16 Nov 2023 17:32:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH v3 0/2] send-email: avoid duplicate specification warnings
In-Reply-To: <20231116193014.470420-1-tmz@pobox.com> (Todd Zullinger's message
	of "Thu, 16 Nov 2023 14:30:09 -0500")
References: <20231116193014.470420-1-tmz@pobox.com>
Date: Fri, 17 Nov 2023 07:32:01 +0900
Message-ID: <xmqq1qcpqqhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F72288DC-84CF-11EE-A6E2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

>> This sounds like something that is worth describing in the log
>> message (and Release Notes).
>
> I think the new commit messages describe the changes better.  I didn't
> include anything in RelNotes as I was presuming we'd leave this for
> 2.44 rather than risk causing any problems this late in the 2.43 cycle.
> If you think the risk is low and/or the benefit is high, I can add it to
> the 2.43.0 RelNotes.

Please don't worry about the release notes, which I'll do only when
the topic hits the 'master' branch.  It was meant primarily as a
note to myself.  And I agree that this would be material for 2.44
and later.

Both patches, plus the stray single quote fix patch, looked good.

Thanks.
