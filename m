Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822C55760
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iknilHzt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 132AB1E35DD;
	Mon,  8 Jan 2024 13:39:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X99kfB5Xq1wAKr0GVpMv2k1EuFWB5PaJzE3WI/
	3/fXE=; b=iknilHzt/QwEqSGHNUSA0Iidx6gsZ0xYEgE2S+TS9vGjwQWa+e+dFw
	rbqxwX4LhctuUevxmVhz3KtvpxoAudZAdx95QxF1jTkJePdxj7945pLJaxgLPGUi
	tLs/5KYxtUFqEP7OgGQhDd5YKgGoHuOTbNryrIwwd7FXMYMdayZQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 046F41E35DC;
	Mon,  8 Jan 2024 13:39:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B2E11E35DB;
	Mon,  8 Jan 2024 13:39:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Britton Leo Kerin" <britton.kerin@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] completion: don't comp revs when --no-format-patch
In-Reply-To: <ce76a31e-d435-477e-803c-92d0532174eb@smtp-relay.sendinblue.com>
	(Britton Leo Kerin's message of "Mon, 8 Jan 2024 00:36:01 -0900")
References: <20240108093601.136370-1-britton.kerin@gmail.com>
	<ce76a31e-d435-477e-803c-92d0532174eb@smtp-relay.sendinblue.com>
Date: Mon, 08 Jan 2024 10:39:54 -0800
Message-ID: <xmqqplybk6th.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 514D6ADA-AE55-11EE-94B5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

>Subject: Re: [PATCH 1/1] completion: don't comp revs when --no-format-patch

I suspect "comp revs" -> "complete revs" is what you meant, but
if so, please spell it out to help folks who read "git shortlog --no-merges"
output, i.e. without help from the body of the log message.




