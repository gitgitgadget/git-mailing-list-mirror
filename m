Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4201FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbdCJT5J (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:57:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933921AbdCJT5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:57:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F8B69369;
        Fri, 10 Mar 2017 14:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T5y7obM5hDS3m/pETNT1aQCtXxM=; b=iVu7tG
        nreg+7Fu9DZO7ApNbpvrnJfhQ7tb4nBLsn6bL6/xnf1QGYiw7hreXSya46URiT54
        5p1pabnYgPLh9vhwPgAiV+GNCoTu3G95grifKTBCu3nsa/MJcW4PjpTzVZdGsIEw
        AYlgerJRBlCNhQ3rSZxHyaDibUoQ3VtExcOiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LbJd05xPJIiBHAOWmdMQazIuaPtuut2B
        ZhXqYMwsaJFxFK1mLtBNc05kp6GbFODOKvx7gVx+gvdNXYzBufMSZadMDypnDXmf
        C4Y/51JRJnQSZqunEJTPfvzjYdRngttZPSDZmDcWrjt8V/1EoBGRoM2xzXPhxGbh
        cv3j/di5ztU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D58269368;
        Fri, 10 Mar 2017 14:57:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7205069367;
        Fri, 10 Mar 2017 14:57:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?J=C3=B6rn?= Hees <dev@joernhees.de>, git@vger.kernel.org
Subject: Re: git commit --interactive patch-mode no longer allows selecting files
References: <8C99B562-9194-4227-B40D-F64BBECEEE38@joernhees.de>
        <20170309182320.n77lvytjh7u2b2a2@sigill.intra.peff.net>
Date:   Fri, 10 Mar 2017 11:57:04 -0800
In-Reply-To: <20170309182320.n77lvytjh7u2b2a2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 9 Mar 2017 13:23:20 -0500")
Message-ID: <xmqqk27wykfj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC5D87C2-05CB-11E7-9367-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's a bug. The fix is in c852bd54bd87fdcdc825f5d45c26aa745be13ba6, but
> has not yet been merged to any integration branches. I hope it will make
> it into v2.12.1.

Wow, you got me worried.  

It has been in 'pu' (and my private edition 'jch', which is
somewhere between 'next' and 'pu') and marked as "Will merge to
'next'".


