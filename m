Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF941F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbcJNRz6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:55:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65528 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751537AbcJNRz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:55:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81A954578E;
        Fri, 14 Oct 2016 13:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uz81DqBuawSdTkY33cBjPqKFE70=; b=GkYKXV
        A8VBuLHRfV7vN4GW2VFLfRxpeSMYx6Z8UPrqhX6T1fo3Basxd95gB1r8rks6QoQi
        2plQBigJLYqPEgSJzwKkHqXXV4WV0khJFAM7nmRbbGsixReGYIoxZy85BbAgzKHt
        Iway4994dpBTwIsWlb8BdleLRXYn9Wiu8wM04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kOLi7nwNVZKq0LXYsg6WhuQRjDt50It7
        w3nh5o4eggbfRpYTW8sKJjzS/uVGbTrpCrRPfhOCQx5+KWWOERor3MwjqUT3otDx
        RswzXdPdjkjm1MKsxqxH7L63fKlNcDvTOWo1WFjTDK+Ik73iKgKs0l7pIoCQKKc4
        B+BtG5L2Jy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 776684578C;
        Fri, 14 Oct 2016 13:55:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFB0D4578B;
        Fri, 14 Oct 2016 13:55:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH 1/3] i18n: apply: mark plural string for translation
References: <20161014114337.18684-1-vascomalmeida@sapo.pt>
Date:   Fri, 14 Oct 2016 10:55:52 -0700
In-Reply-To: <20161014114337.18684-1-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Fri, 14 Oct 2016 11:43:35 +0000")
Message-ID: <xmqqbmymzufr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74180C88-9237-11E6-865E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark plural string for translation using Q_().
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---

Thanks for waiting (patiently) for 'master' to become ready to take
these three patches.


