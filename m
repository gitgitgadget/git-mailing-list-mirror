Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_SINGLE_WORD,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6A91F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbdLNSqG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:46:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51759 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753742AbdLNSqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:46:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 007C3C7BF6;
        Thu, 14 Dec 2017 13:46:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Lz3mmQ
        6PqsrsYv1tuMLmI7URp1kcRGVJkb38gaLT8Rmc4sgRFOxCzMDflaEdCAnUygUsNN
        nJrmskBbsdak3XpzV088NW9V+z45nfSSaHfhf6dzsXTbN7yjeaW43gl+2oRYvdMD
        IzFx52VQ00ZTaUOZQMlpKr8XjrFDwIm3z0wRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bSrHE8LoyvBAGcyVG6ne7Gd7X6/K12dR
        CKAWkYAbgzZ0iRLin9TNjVxqswwpU+PR7xVQIzzmIf+fMLE4BIvJsrFUmkK9/c4D
        V3TTlSMH4LGMKdqdYr8laEaL3A3MEYtE94bN5Ktod1ar8LvVF1MJ8e+LA93STONn
        z+UHpBHo27A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDDEAC7BF5;
        Thu, 14 Dec 2017 13:46:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 740BBC7BF4;
        Thu, 14 Dec 2017 13:46:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.16.0 draft
References: <20171214024244.29714-1-tmz@pobox.com>
Date:   Thu, 14 Dec 2017 10:46:03 -0800
In-Reply-To: <20171214024244.29714-1-tmz@pobox.com> (Todd Zullinger's message
        of "Wed, 13 Dec 2017 21:42:44 -0500")
Message-ID: <xmqqo9n1tafo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09DD48FC-E0FF-11E7-8794-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
