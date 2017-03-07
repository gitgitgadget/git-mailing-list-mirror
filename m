Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8471FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 22:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbdCGWm7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 17:42:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51073 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756494AbdCGWmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 17:42:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7037680BB2;
        Tue,  7 Mar 2017 17:42:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=a0Qf22iAp5OiQTh2ZazSdLMLI2g=; b=s7Jl5Z2bYhfa0EsNXHPK
        IzBbWP2NNtRFlfTvP3jv1CC4dBjY4lfg5YC0Z/JgDqsj9P/FO8wCIp+Kg9opNme0
        0JIIf3E8Rem1iwTm5SHZpQ4IjxAHCjAGff29O6TeNrlXKYxPCFMpYnIZam5DI4Hp
        PFzF1OI1dV4SR519yEfZEQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=UwK49VtPXHGtRtzZ3DyvPZ7evyhkk0u+Pcc4OGDY5ZZY1H
        KBw83DeDVO79BRUUWMrxiTrA//W+qaNr7eCEjpxuay2/ZUYnRiSrIYbtm9jgeOkp
        BDW96o/AIR8fI8QkxxHhpUZqpOzEZyZDnWjE3cyzBotgIEBxWOpaAYx9+FdpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68ED880BB1;
        Tue,  7 Mar 2017 17:42:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA84480BB0;
        Tue,  7 Mar 2017 17:42:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 18/18] builtin/read-tree: add --recurse-submodules switch
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-19-sbeller@google.com>
Date:   Tue, 07 Mar 2017 14:42:35 -0800
Message-ID: <xmqqmvcw6750.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CACCA40-0387-11E7-9D20-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A new known failure mode is introduced[1], which is actually not
> a failure but a feature in read-tree. Unlike checkout for which
> the recursive submodule tests were originally written, read-tree does
> warn about ignored untracked files that would be overwritten.
> For the sake of keeping the test library for submodules genric, just

generic

