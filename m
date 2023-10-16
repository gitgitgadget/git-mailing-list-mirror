Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900420B01
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="jfRQXqkt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjBURZjs"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E2AC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:30:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 308695C039E;
	Mon, 16 Oct 2023 06:30:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 16 Oct 2023 06:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697452204; x=
	1697538604; bh=yd+qx48NKGT4gafwq7qjUxxHvptDTLN3gZ5FDQfM6KI=; b=j
	fRQXqktXm3JtjdwmHpsbgNN0SueiT3JUG8B2nXpTpcuLlJXqcEq275j2FWd9ny/a
	Zbzpc6F+V8hQGhxKE7PJlRAD5MXIvnK6kzJWQU1Uam1FKKFlZb8iesC0JGh6NGPD
	87mFS5D+hbMONd/aTMFyhWezM1eqGaFWnupC7KdKZslDUa0LQJR97hX6ZzEWUJxJ
	/rap6YCcTIKmwebIPzKmW9hEgwkLVsI94o4UA2eIEz+AD7Pu/aP4uTov7pnFl0a8
	vboevIZNQe5BmkZggfsWmOrpbmA+BsFuZf/RA2SenQqvRcDm4EXb+Vvog/DDjQR9
	JcHY/C9pzLBh/lvN/2bgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697452204; x=1697538604; bh=yd+qx48NKGT4g
	afwq7qjUxxHvptDTLN3gZ5FDQfM6KI=; b=PjBURZjsu/Xz1Jx4e2MnidkRWdIor
	0raCuhtRucdlYm5VcvVW3V+G5kPri+T1d2yK1i5ZpIgfDJ+h5GdMncIlrdrdYwkf
	TlTtRV8fhwLo2361W67ep7Q2Es2nkdew+LzmgKLJT5Y8fGaGwcuEY3Llj/0G9KQh
	qxXtTMlrv0rQu+Y6hWmSh8Znve8dksxstZ6BEYALMhmQlXyiEZWnhk27rQxnc4bF
	+drLsEN/ed+RgqwYhAkBN/xCXziPHu1xRPTy0XQdGeuwR7t8nILkwY429sBAfwqn
	42xijsrpdGm1VFIskm1ibOq/pE7+84nuLlPQ9ozEwP7Nb6YRoNbSVsXbQ==
X-ME-Sender: <xms:qxAtZWVwWZlu8AutWvmxtnINk7msPfMzycfYPkES4MU3b8GqYChGVRs>
    <xme:qxAtZSm1ISHG681c8K5WX8Jc-Z9kwnxQgJUHQU0jIf1LthmWZ3BmS1i0Q-K5VsT9H
    gVeSN-RFk29-RQ8-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefhkeffjeehtdeigfdukedtheevvdehtedt
    veekgfetffehgfeigeduudetgfekheenucffohhmrghinhepshhtrggtkhhovhgvrhhflh
    hofidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:rBAtZaZQSeuHUmCqHxjbRg8NOt9V6HcGqvg_m8hu1arjZrjrtJdZDw>
    <xmx:rBAtZdXml55jJisFoI1k3GREjVdES7wIXpJOJee2Kef6lupSpT8CgA>
    <xmx:rBAtZQlrsL6t_dN1VYgfw-PfRN00Sf3u65uzfOYmZT74nbzLO1FENw>
    <xmx:rBAtZSQEjkoOU75nEE34hyw09kpJ9cELidX0ZwJadtm-R0nVP3jbFQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D320515A0091; Mon, 16 Oct 2023 06:30:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d34d9b64-4760-43e8-975c-a3ef53048530@app.fastmail.com>
In-Reply-To: <75545e1c-ce62-4b49-983e-1e7b1afb2fab@gmail.com>
References: <75545e1c-ce62-4b49-983e-1e7b1afb2fab@gmail.com>
Date: Mon, 16 Oct 2023 12:29:43 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Victor Porton" <porton.victor@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git log --patch for a particular file
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

On Mon, Oct 16, 2023, at 12:20, Victor Porton wrote:
> I want this:
>
> git log --patch -- server/src/api/docs.py
>
> to print changes only for the file server/src/api/docs.py.

That's how it works for me.

> Currently, it in some reasons outputs nothing (this seems not to be an
> intended behavior and could be counted as a bug).

Does it output nothing on *merge* commits? That's intended.

Try using `-m` as well.

https://stackoverflow.com/a/37801468/1725151

> It is questionable, whether to output commit information (commit hash,
> user email, etc.) for commits that don't change specified file(s). I
> would vote to indeed output this information, not to confuse the user
> about the order of commits.

You can customize the output with `--format=`.

> More generally,
> git log --patch -- A B C
> could log changes in files A, B, C (only).

If I name two files I only get commits that touch any of those files. And
diffs only for them.

-- 
Kristoffer Haugsbakk
