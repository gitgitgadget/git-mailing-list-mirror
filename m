Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286E720281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdKFBO3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:14:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbdKFBO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:14:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFFFDB5005;
        Sun,  5 Nov 2017 20:14:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zf7f1twa64eYa/9BtXyxl7eUsP4=; b=mz122i
        1poRSsOJo38UJyyIuoXNsOY0NZgAJspDGrsRcj/mUuTDG9hmuI/e2dPbv4FmiTue
        Rgg/q838GKn2i28z4xD5F9+MSXU3sCxyV4zcPl+FP6o3d4kokRT6b16p+y0ivvGA
        1zk4Cq09KZ6rKd3kPWPzAuPCwzHVtaUwdzRuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jrX6GlXKf33TfObOC+mtjqvdGzkuM5v5
        dS1PisaxW0jEhYoRpibRwVO+bGkrH5rwo6/bIJPrL6woAXGTEfZxGmkDovgHOmib
        pghPUdsPrDLG7PxgV46s0BkVIckZYBXzIcsRkZtDml55AvHelE8sGD0eu+y6069p
        Ks8r9xdExQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8D48B5003;
        Sun,  5 Nov 2017 20:14:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2862DB5001;
        Sun,  5 Nov 2017 20:14:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH] config: document blame configuration
References: <CAGZ79kZaCwU8S8R-nAzCcV=izpTnsbZsBjJLpoWkid2AF54f9g@mail.gmail.com>
        <20171103192158.1669-1-sbeller@google.com>
Date:   Mon, 06 Nov 2017 10:14:26 +0900
In-Reply-To: <20171103192158.1669-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 3 Nov 2017 12:21:58 -0700")
Message-ID: <xmqq1slcky31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D53DC83E-C28F-11E7-B090-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The options are currently only referenced by the git-blame man page,
> also explain them in git-config, which is the canonical page to
> contain all config options.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Excellent.  Will queue.  Thanks.
