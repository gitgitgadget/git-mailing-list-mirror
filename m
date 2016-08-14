Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39581FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcHNXCz (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:02:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751772AbcHNXCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:02:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35E0735E06;
	Sun, 14 Aug 2016 19:02:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8L3b1GRAbci7qotGWsKuUc0mDs=; b=VR8qrM
	jV3/RhCb5nXJ1GE5AvRvtLdDupaKhv2gJHCh01wWo4NEz1QVK0PBe0/0IwRCgHNc
	An0ORgzKYxVv/vN7M68FVTMkKnHBpKWLy3QXIQhqw2ruV6eF08BEto2YSUvznenP
	WjU3YGGp0ndb5h6vb6DGumJu2T3OSJSeuMBnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tc989uwx+QZHGlM4TS4K4T2ncm49eOQl
	reP1Kc6hZ6pWv02aHXUlLtDJURb0adWgsca8U3PI6dFV4pLgM0IvXjVkDd4ByvnH
	X/HgOc45V6N1Ycg88/goJ25fVMmQ3s73YQQzyQQAZJz9VInMXq3U60U2tT/JEwqq
	zoBqwSWgy38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E59F35E05;
	Sun, 14 Aug 2016 19:02:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5BBD35E03;
	Sun, 14 Aug 2016 19:02:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"GitList" <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] doc: rebase: fixup! can take an object name
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-3-philipoakley@iee.org>
	<xmqqziofj90b.fsf@gitster.mtv.corp.google.com>
	<BF74616BD9694719A6C0D6E75ACD9CE6@PhilipOakley>
Date:	Sun, 14 Aug 2016 16:02:50 -0700
In-Reply-To: <BF74616BD9694719A6C0D6E75ACD9CE6@PhilipOakley> (Philip Oakley's
	message of "Mon, 15 Aug 2016 00:00:15 +0100")
Message-ID: <xmqq1t1rj6n9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AB22940-6273-11E6-A6E8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> the 'standalone' is that it must be a single (standalone) word on the
> subject line immediately after the "fixup! "(s).
>
> communicationg that one cannot have any extra textual notes after that
> word was the issue that 'standalone' tried to address.

Perhaps I am slow but did you mean the same thing as "it must be a
single word and nothing else on the remainder of the line"?

