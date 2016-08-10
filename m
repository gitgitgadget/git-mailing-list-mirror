Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A221FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbcHJSEx (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:04:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbcHJSEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B01FE35D81;
	Wed, 10 Aug 2016 13:49:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vkLxdYvoAcSiftSYJCp7elryGV8=; b=XGB4Mj
	xJbrr5IOV0O5n7W38LkvxvaVNJy4xZvnyJEEWaNnZz2sjjB70wykk/qGMo12fv2q
	tK/Sqt377NKCWXsrMnbdyXMxNqCwDFXtOC82YoFGkdQ/jFwOXpHunpC9ZHwRBdb6
	NRYPYFIW2IjhTEdSxIehkGUAYrnLs1Q3C1CxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DaN9Kz4C8zRdPTU2TREK3UaWkURchUXE
	TZn+TI2ng/BNtkvD9r+V6qZQv8AKGb2VvAp3TfC0aqtFxwqk/u65ClPMiFwpukls
	8vNFoqCy28ic4eFYESl5KUFhC0/B4tCgshsUXW25t9ooqNzIBGUtUlmCeps8ONBI
	wEpoqwoqcMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E8335D80;
	Wed, 10 Aug 2016 13:49:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17CFC35D7F;
	Wed, 10 Aug 2016 13:49:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
	<A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
Date:	Wed, 10 Aug 2016 10:49:05 -0700
In-Reply-To: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com> (Lars
	Schneider's message of "Wed, 10 Aug 2016 19:30:29 +0200")
Message-ID: <xmqqh9as5xbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC1F64EC-5F22-11E6-A988-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I think "t7406: future proof tests with hard coded depth"
> breaks the tests on OSX:
>
> https://travis-ci.org/git/git/jobs/150779244

Thanks.  "| wc -l" can probably be replaced with "--count",
if the upstream is "git rev-list".
