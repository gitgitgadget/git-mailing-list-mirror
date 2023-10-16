Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAD381AA
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBlF3xyR"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A8ED
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 13:34:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0226932BAD;
	Mon, 16 Oct 2023 16:34:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c553Ml8oBEqhNUoMcFIIApK9fYFt9O0qPX8szo
	WJf9M=; b=RBlF3xyRFm9bvv9vH/xLWMfV3ZuT024WcD8qsHMOFg/2OqZM/B0nNt
	U4HgpycXm+7UsF0TgWOMn/O/4ZBXRKivQ7j80QJkYwAyhss62IYEy2bsSFoQVkN5
	/Hn7y2vTJkO0HUn2RznM/ItWN97yTbiLLgOw6vmCtxxrGmClKxLds=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EECA432BAC;
	Mon, 16 Oct 2023 16:34:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 609C332BA6;
	Mon, 16 Oct 2023 16:34:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <CAOLa=ZT4EuoB8GHMe+a2nfq8Pfg5x7xzrEa_qV39U1HqUyS+Eg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 16 Oct 2023 21:01:23 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
	<20231016103830.56486-1-karthik.188@gmail.com>
	<xmqqbkcyo7ro.fsf@gitster.g>
	<CAOLa=ZT4EuoB8GHMe+a2nfq8Pfg5x7xzrEa_qV39U1HqUyS+Eg@mail.gmail.com>
Date: Mon, 16 Oct 2023 13:33:59 -0700
Message-ID: <xmqqwmvml32g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 571C9906-6C63-11EE-A9B1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Karthik Nayak <karthik.188@gmail.com> writes:

> Well, actually the newly introduced tests t6022 require this block,
> but this is specific
> to when commit graph is enabled.

Ah, of course.

> Thanks for the quick review, I'll wait a day/two and send v3 with the
> changes to fix tests
> and cleaner code.

Thanks.
