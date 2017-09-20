Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB262047F
	for <e@80x24.org>; Wed, 20 Sep 2017 04:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdITEoc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 00:44:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63986 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750888AbdITEoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 00:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A2895DE1;
        Wed, 20 Sep 2017 00:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YwKlYMqRReE1MDfHnU05SMfJPWE=; b=oCWmJk
        q3XLFGH2K8uw5tPtUOX3LuEBrf/IKsFJKRag5T3jW2dPHgqb4AHWZDGUQzOQdmtn
        iYC6+y42Nn6+zCXul9fSIx6gPT1xbtL1rt0N7Q7WTugr5ujM9rtHTuRppCgwDk51
        Zzc0iqlRDV1rktOIZI0KKPM4E0BKH/cO8ZDVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nFXCM8LELlgLpOtPV6kIT8ZOTV3mmWP7
        H93oYsjAJmO0g6zEeGwmTmmaNSsw6xWZIosXOkRpLmM83D5Mz8Del3eJdcaxRAEv
        R9QJOjzbcVHhgIeCDoX1uhv96U+VBC9hI/1l7gNeJVxqicVtkSZ6pN2gnAK3+md+
        b7033Jn4jVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E03895DE0;
        Wed, 20 Sep 2017 00:44:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3BD395DDF;
        Wed, 20 Sep 2017 00:44:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] Win32: simplify loading of DLL functions
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
        <20170919180742.GC75068@aiede.mtv.corp.google.com>
Date:   Wed, 20 Sep 2017 13:44:29 +0900
In-Reply-To: <20170919180742.GC75068@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Sep 2017 11:07:42 -0700")
Message-ID: <xmqqvakenfma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 642EC09E-9DBE-11E7-8B76-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...
> strerror(ENOSYS) is "Function not implemented".  Cute.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both.  Will queue.
