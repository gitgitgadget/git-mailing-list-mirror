Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5F79C2
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQpEAI6A"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCC0AB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 10:06:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0436C1BA61E;
	Sun, 15 Oct 2023 13:06:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9qzADm2m/gtJj3541tLWefBcPJqO7qSAse1MAN
	viAZU=; b=ZQpEAI6AfuNphV/8WpnMUMcjD/9wmcquzIjtYTYF6y9yOYkv+d7+BD
	MfXHrjFIZnC4wFPY9FvwqnmLFaaYbExH/sq8FemACl/TrXPGs7mUohnXoH+qyfag
	slmmIrWgJyzNzNUcMcX3imn2eZFGW3BpvGfm/V87gn2CfyEccB6EI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFBE41BA61B;
	Sun, 15 Oct 2023 13:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A2A21BA61A;
	Sun, 15 Oct 2023 13:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <ZStWB1/LX7cTbVGr.jacob@initialcommit.io> (Jacob Stopak's message
	of "Sat, 14 Oct 2023 20:01:27 -0700")
References: <20231014040101.8333-1-jacob@initialcommit.io>
	<xmqq4jitw4nk.fsf@gitster.g> <ZStWB1/LX7cTbVGr.jacob@initialcommit.io>
Date: Sun, 15 Oct 2023 10:06:54 -0700
Message-ID: <xmqqbkczstld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E17F86A-6B7D-11EE-99E9-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jacob Stopak <jacob@initialcommit.io> writes:

> Lol! By saying "calendar" I mean "falling on the official boundaries
> of", like 11:15:00 - 11:16:00. Unlike the time between 11:15:30 -
> 11:16:30 which is also a minute, but it's not a "calendar" minute
> because it overlaps into the next minute. I guess in this case it's more
> of a "clock" minute than a "calendar" minute though ':D... I guess
> "calendar" terminology is used more for months/years...

People use "calendar" days usually in order to to differenciate it
with "business" days.  It may take your package to come cross
country and take 5 business days, but if you ship it out on Friday,
it will not arrive by Wednesday.
