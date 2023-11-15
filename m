Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00213394
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRare1KE"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E7C7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 16:48:50 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 731FA1D1F19;
	Tue, 14 Nov 2023 19:48:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xusq8dG1C+BhUb4Z0nYANH8R7v5MnMfPBtWeFI
	DXiNg=; b=BRare1KEdXbQWmNlIVkPlZJ4Egs/q0hkJ7GQG852wchXlR6p7IcoOz
	I+suC08hJfOP19FDOBtqbGLsF/2QDug0yAjigDJ/FnHYCSy/0+itMasB9S3swe0I
	JM9nVhsxY2BjB61tedhnMlmz2rdvJms++gjROjWCIv1cMeNekiCF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69D801D1F18;
	Tue, 14 Nov 2023 19:48:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB8DF1D1F17;
	Tue, 14 Nov 2023 19:48:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH] send-email: avoid duplicate specification warnings
In-Reply-To: <ZVPfvjoXyGVlKqvr@pobox.com> (Todd Zullinger's message of "Tue,
	14 Nov 2023 15:59:42 -0500")
References: <20231114163826.207267-1-tmz@pobox.com>
	<20231114200009.GD2092538@coredump.intra.peff.net>
	<ZVPfvjoXyGVlKqvr@pobox.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 15 Nov 2023 09:48:45 +0900
Message-ID: <xmqqy1ezx2mq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBEC1B96-8350-11EE-A963-25B3960A682E-77302942!pb-smtp2.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> Since this isn't anything new with 2.43, it doesn't need to
> be fixed with much urgency.

True.  Unless the new version of Getopt::Long is quickly spreading
through our user base, that is.

> Thanks both,

Thanks for spotting the issue and acting on it quickly.
