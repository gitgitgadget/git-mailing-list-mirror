Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EA28DD2
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nEWDD13I"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764910A
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:02:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AD7B2F239;
	Tue, 17 Oct 2023 19:02:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u+WREj1HfzSBXNICEBceCaD2QWauN4E71wShaz
	8IJ/0=; b=nEWDD13Itf/U3h6KGmaHX5lF8QLfMQ6EwB5Kq2ZEFBcz2plcaGObJN
	DSVHJUQ6W6shShmFOoZjGSsP9jD6XdqroMX7Hkz9/+kA4fa0aq88tHpibKyXL12T
	8EcmVwlMho8fvsqvELeK5vXRqpncwdJPeZxZoc85ZJPtOR85aNsw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 635C32F238;
	Tue, 17 Oct 2023 19:02:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C528D2F237;
	Tue, 17 Oct 2023 19:02:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  Joanna Wang <jojwang@chromium.org>
Subject: Re: Supporting `git add -a <exclude submodules>`
In-Reply-To: <CAMmZTi8swsSMcLUcW+YwUDg8GcrY_ks2+i35-nsHE3o9MNpsUQ@mail.gmail.com>
	(Joanna Wang's message of "Tue, 17 Oct 2023 18:48:03 -0400")
References: <CAMmZTi8swsSMcLUcW+YwUDg8GcrY_ks2+i35-nsHE3o9MNpsUQ@mail.gmail.com>
Date: Tue, 17 Oct 2023 16:02:12 -0700
Message-ID: <xmqqpm1cx37v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35D0AECA-6D41-11EE-BDB7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Joanna Wang <jojwang@google.com> writes:

> I will dive into the code more to confirm, but that's my current
> high-level plan, in case you immediately see something very wrong.

Nothing I immediately see glaringly wrong in there ;-)

Thanks for digging!
