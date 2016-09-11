Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BE51FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 21:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbcIKVwU (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 17:52:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbcIKVwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 17:52:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B21563B524;
        Sun, 11 Sep 2016 17:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m9uH6ZydgMTp7mXTyIsO6fFfdkI=; b=YRYxAC
        VxSfS7PrgTZQFoktIQ6RX6ONOXcxCfHYh0y/8dCcQAHsCcYtXxCQ5JLMNQmHz4TL
        KLU9mdy86WPYa4eu3CiBIDNzo79pw6zlj/CKMbZa3N0QLhJLFPdcrLL104vO7Clh
        zEcMbIaUKqlEyBMz+8bq7zawfwFSUHprEBj3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z39q0XT0Q3s5j2PG5UUtccjqPhQbzidv
        mu/vZUwEPGuKfUnMgxsAOkytpsXwRMW4yTZRHfGq2Rd0AesipbklBTXp486AC1UU
        ZKXahu8jDgdo85lIJcCL1KP9M7UMdf1vD6yEX25NGJm+wbErSDraHeIsoF2kz2Ug
        +/9P4m+T4H4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A96033B523;
        Sun, 11 Sep 2016 17:52:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3379B3B522;
        Sun, 11 Sep 2016 17:52:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: respect commit.gpgsign again
References: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de>
        <xmqqr38tapv0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609100903010.129229@virtualbox>
Date:   Sun, 11 Sep 2016 14:52:16 -0700
In-Reply-To: <alpine.DEB.2.20.1609100903010.129229@virtualbox> (Johannes
        Schindelin's message of "Sat, 10 Sep 2016 09:05:32 +0200 (CEST)")
Message-ID: <xmqqr38q6r5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02531DD6-786A-11E6-BD0C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks. There are a couple more git-gui patches waiting for quite a long
> time. So you prefer them still as patches to git-gui.git?

I prefer not to have to worry about them myself ;-)  That means that
even if Pat steps down, the next maintainer for git-gui project
would not be me, so I wouldn't be making a unilateral decision to
re-root git-gui.git project one-level down.

> Also, I just noticed poor wording. Would you mind fixing it up by
>
> 	s/committing/& with GPG signature/

Ouch, I didn't notice.  It's not in 'next' yet, so let me see if I
can futz with the history.

Thanks.
