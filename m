Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B65207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbcILTgK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:36:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932362AbcILTgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:36:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7E5F3DDF3;
        Mon, 12 Sep 2016 15:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1MzhYiEbiUi0e4lBTHoSgIdt34s=; b=us31ue
        0rKc9rSQuoM6RCRnWMj0vIF4L3E4fm4llv458mbDm992IpKjKrgqQLg47yswE/7y
        PIQcAUk7H0pcZPkgi2Yf9jgfPsCKhkDf6sS43aG3iUBwF57XfnvPQnOKi00opaac
        HT4Y7d2zac/nKnprspGNI4ialObReFXJck+Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSlDDkQSp5jecXFyg258fM9paip5g4X2
        iEJqBN1y79dGvQJUddqU7Qg+qFKKmaXau5X+MgX7odrgf26YxNYedeGuJW5E3iSN
        H1G34l5eQ5FqQ4jWEed2AbFSY6TiFyDcgRxURvhI5cpmJA2QCN95vsFx4KSi4lx2
        NBSeynuxMN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D10FF3DDF2;
        Mon, 12 Sep 2016 15:36:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EF5A3DDED;
        Mon, 12 Sep 2016 15:36:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Pull out require_clean_work_tree() functionality from builtin/pull.c
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <cover.1473580914.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:36:00 -0700
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sun, 11 Sep 2016 10:02:12 +0200 (CEST)")
Message-ID: <xmqq4m5k3o7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 239131DE-7920-11E6-AE2D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Johannes Schindelin (5):
>   pull: drop confusing prefix parameter of die_on_unclean_work_tree()
>   pull: make code more similar to the shell script again
>   Make the require_clean_work_tree() function truly reusable
>   Export also the has_un{staged,committed}_changed() functions
>   wt-status: teach has_{unstaged,uncommitted}_changes() about submodules

Other than two minor things I've already mentioned, this round looks
ready to be queued.  Thanks.
