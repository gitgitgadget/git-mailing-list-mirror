Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC578489
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ov44KC2x"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A9D44
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:47:50 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DA6AF29E4D;
	Mon, 13 Nov 2023 20:47:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PzwAU7Anz3MY14wju+8hxorcHdPM88JFUQTO5/
	NXC/c=; b=Ov44KC2xlegiFuvB8N3nwgsXpnWyUCpen5b0T6fbLCGzeSOkm0X/wU
	ZwjwCXMVvzJk8K2BgEPqCnSS+q7DXlRoh5w2GX2nc9z+MExhQQDNMa9Brmq4pukV
	4ypHniEurSTA+J1PP0c25lBbZPBxAwCCmiYpOR9yu9eXIHEL3YNmg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D2A6E29E4C;
	Mon, 13 Nov 2023 20:47:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 745F629E48;
	Mon, 13 Nov 2023 20:47:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Haritha D via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH 02/13] Enable builds for z/OS.
In-Reply-To: <ZVKrWSv7JguKTSYw@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 13 Nov 2023 23:03:53 +0000")
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
	<098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
	<ZVKrWSv7JguKTSYw@tapette.crustytoothpaste.net>
Date: Tue, 14 Nov 2023 10:47:43 +0900
Message-ID: <xmqqleb114xs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF4CF51E-828F-11EE-928C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'd generally want to look at the commit message and understand the
> problem the code is trying to solve and then look at the code and think,
> "Oh, yes, this seems like the obvious and logical way to solve this
> problem," or at least think, "Oh, no, I think we should solve this
> problem in a different way," so I can help make a thoughtful review
> comment.  Right now, I lack the information to have an informed opinion
> and so I can't provide any helpful feedback or analysis of the patches.
> ...
> I'd recommend a quick pass over the SubmittingPatches file, which is
> also available at https://git-scm.com/docs/SubmittingPatches.  The
> sections on making separate commits for separate changes and describing
> changes well come to mind as places to focus.
>
> I know this may seem overwhelming and like I'm upset or disappointed;
> I'm definitely not.  I'm very much interested in seeing Git available
> for more platforms, but right now it's too hard for me to reason about
> the changes for z/OS to provide helpful feedback, so I'm hoping you can
> send a fixed v2 that helps me (and everyone else) understand these
> changes better so you can get a helpful review.

All very good pieces of advice.  I suspect we are missing some of
them from our SubmittingPatches or CodingGuidelines documents and
may want to add them there.

Thanks.
