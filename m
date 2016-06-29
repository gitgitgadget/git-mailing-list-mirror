Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF4D1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbcF2P0Y (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 11:26:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753098AbcF2P0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 11:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15BC826BCC;
	Wed, 29 Jun 2016 11:26:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pqrsNu7xRbq00KlwSqwHTHZCsjY=; b=PM7LbX
	PLTx5qgbQs4rNPHIEM1f4wK55nGxonUY6GtRFiHYcDPfZC6i9Nh8jDqBD8enCqJA
	7lZHuj1TyxolfmxecRc6Sad3Gxf85jLJEi25iKMcgRCzM+oUpsCJDNHZwvG/DlNa
	gIVnseuib1kW1Q6vpkAEZCqKgcREI5lWOH2/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JFatOFOZfCkYOhNsU6PDCWMxBSYp/B0I
	txIKpiQBiQ/nxry2Xvq1Rk1oH3D4W4NpuxuWqXX9KbEdV3tUgR4zQ8ew77YZiPKq
	tfWFBRXqFwydF8xWLzNKCn2a6vR4egJji3vzSY3AJw1nJnims29tHjXQyMk96SmJ
	Q/2lzhANoBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0562926BCB;
	Wed, 29 Jun 2016 11:26:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EA0A26BC9;
	Wed, 29 Jun 2016 11:26:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3404: fix another typo
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 08:26:09 -0700
In-Reply-To: <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 16:31:03 +0200
	(CEST)")
Message-ID: <xmqqlh1o584u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF4A8690-3E0D-11E6-89FC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The past tense of "to run" is "run", not "ran".

Actually, past tense of the verb "to run" is "ran" ;-) The reason
why this patch is still correct is because this is writing in
passive voice, where you want "be + past participle", and the past
participle of the verb "to run" is "run".

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3404-rebase-interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 66348f1..c7ea8ba 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -60,7 +60,7 @@ test_expect_success 'setup' '
>  	test_commit P fileP
>  '
>  
> -# "exec" commands are ran with the user shell by default, but this may
> +# "exec" commands are run with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unsetting SHELL avoids such non-portable behavior
>  # in tests. It must be exported for it to take effect where needed.
