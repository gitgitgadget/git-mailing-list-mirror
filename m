Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2219C2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdGZSsp (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:48:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54839 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751040AbdGZSsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:48:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4549C8FED1;
        Wed, 26 Jul 2017 14:48:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y/RPFzc//EOvmmqV5khY8VnZh/s=; b=hiLp5t
        ubZhXC7vOpy75V9zn3+g7cgR4RAjfsIlLc52z1aHoSe9/Mhd2O/6f0KppOr/MWjX
        QpG2sqqAKWka7yyA7zC/JBHYt3FsDcqqtkokzvsn+yN33KtZUQ9qdsmn+BD81l/i
        v1mEZWvXaxDaUITGQO8UtBqHDRwQvJd7YxjIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tJs9rjRJyjp32DOI33sww531v9UxomXH
        T4eQp2mOFVi2MZAjIfzlRCb0VTn0UQs1B/DCmgwdc79FnN+Dq+2kA20jU2u8zfBF
        herLWbSZfd9zJhNra8/VS/141hKgwunFBJSrElxHkqu+xnyoOYn/+xj6s2ydRY+H
        6XObiZnQtuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8138FED0;
        Wed, 26 Jul 2017 14:48:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A48128FECF;
        Wed, 26 Jul 2017 14:48:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #07; Mon, 24)
References: <xmqqinihbgci.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707252046190.4271@virtualbox>
Date:   Wed, 26 Jul 2017 11:48:35 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707252046190.4271@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Jul 2017 21:22:19 +0200 (CEST)")
Message-ID: <xmqq60efrq4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0856D47A-7233-11E7-AE06-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * wd/rebase-conflict-guide (2017-07-17) 1 commit
>>   (merged to 'next' on 2017-07-20 at c78e758b23)
>>  + rebase: make resolve message clearer for inexperienced users
>> 
>>  Code clean-up.
>
> This is not a code clean-up. It is an improvement of the user experience.

Indeed it is.  Thanks for spotting.
