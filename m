Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05491F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 21:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdCBVoq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 16:44:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52382 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdCBVoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 16:44:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C231B83CA3;
        Thu,  2 Mar 2017 16:40:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G514siWAo3M2LXEpS5xUunyOH2I=; b=wkNU53
        IwS7dKmTOe3whW5rKzBD9c9GqDYUJ7l+KpN2vomUs34GDZlCk8ezmAIrhZk56T+a
        AUfa9H3aWzVu/C8zS9d1/s7F6+GM6fzylQm2N3kpKbiydIzP0sr/+zcQdIq4s2S6
        8NKWRxZ5S03WePU5+QUa0WrP18sCb1PaUGKso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PhOR1FpMAc2nSyyowsrhgZudtsxQwOqN
        tpYKFB0oJKlWCJt5px/EwWbZQ7lzqjLVMfQwefSnM5Z6Hi9Mc2TEe6KJ870mlgvo
        ChxrBU0Wg3D0VcJmNMvmd50ExP6JqbuGisW8OckILrbRuhu5EAoPPVcIWorPWPp4
        DoN8loEVmqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB71783CA2;
        Thu,  2 Mar 2017 16:40:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FAFA83CA1;
        Thu,  2 Mar 2017 16:40:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <xmqqfuivbcz0.fsf@gitster.mtv.corp.google.com>
        <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>
Date:   Thu, 02 Mar 2017 13:40:32 -0800
In-Reply-To: <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>
        (Jeff Hostetler's message of "Thu, 2 Mar 2017 21:18:41 +0000")
Message-ID: <xmqq7f47bbn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD306F32-FF90-11E6-9EB1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <Jeff.Hostetler@microsoft.com> writes:

> Sorry,  $DAYJOB got in the way (again).
>
> This is still on my short-list of things to take care of.
> I should have something for you next week.

That's perfectly OK.  I just wanted a newer articule in my
newsreader I can bookmark so that I won't forget ;-) No hurries.

