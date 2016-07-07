Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BD42070D
	for <e@80x24.org>; Thu,  7 Jul 2016 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbcGGTvk (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 15:51:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751043AbcGGTvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 15:51:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0478C28F41;
	Thu,  7 Jul 2016 15:51:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfsLLlTEfVoR3VHOv0XLFBE9dQY=; b=QXPcCB
	ppQ7xTY7h4rNKbfab6+SPCzXaSFE+1GEN/M896dpkjxXdq5esti/aC8uILWUx5DA
	UqMCF1/9ILi8xSOa8lSyC58k0LIKnRcyVZ+MjlFxuZ9YAPh+uYV0vlvboctv262O
	sWe/JG3wVWDkEBOK10jt5udr70TynalW7UwlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1labykwdin5oWxGxItSohxecwM8OtxX
	mBa6EoSr3pxACgp68jBkxz07sW68DI6iCCOBVpNhFKSLFX3V3g82zac/8RgwewUq
	hm81NWt6VeG+JA0OBUvwJoSQm0CHrth58kACZWyk+5MshuQZ+QsIeqGa+uE8aqM/
	PCaBcuf/Vzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE94C28F40;
	Thu,  7 Jul 2016 15:51:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76F9D28F3D;
	Thu,  7 Jul 2016 15:51:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net
Subject: Re: [PATCH 4/4] add a test for push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-5-sbeller@google.com>
Date:	Thu, 07 Jul 2016 12:51:24 -0700
In-Reply-To: <20160707011218.3690-5-sbeller@google.com> (Stefan Beller's
	message of "Wed, 6 Jul 2016 18:12:18 -0700")
Message-ID: <xmqqinwhp6pv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 314A9C94-447C-11E6-8F1D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The functions `mk_repo_pair` as well as `test_refs` are borrowed from
> t5543-atomic-push, with additional hooks installed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t5544-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100755 t/t5544-push-options.sh

FYI:

    Applying: add a test for push options
    Test number t5544 already taken

