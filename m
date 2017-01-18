Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B821F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbdARSlt (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:41:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63031 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751053AbdARSls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:41:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 884145E923;
        Wed, 18 Jan 2017 13:27:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W4iH+PGm3AJfrD0b4KgwjAmRmJI=; b=xlrES6
        ZCahbmAYsvRGspynOaUt4XJ1ntGplYNcbheJzWniUk5R+M/DAZ7X+GVRHod4Tvsd
        tRt8bF1jdlSKfir8Kqi+r3n03QhDdf7SX3wkCZ3Y4KrVTBxW87PfHa/an8xy6tBq
        tSucqX50OH8mwidkVkH2U729yIezgoIwlR7fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pVGIgt1Qon0Th2XMbodu7jnLa1eTg8Nj
        ccek42LZTqyHzHp2gw5E6wZGeShLcohWY4f5U7y5qlYhW6AStlbTrEeo/oilmgS7
        e0PHxoOHJ9FnwH/jFPEHE9tpNzYymXr5Y73Iyk2LCD/vA1foRi0nxoBFtaSahjwH
        m0AdHhij4TQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F7AE5E922;
        Wed, 18 Jan 2017 13:27:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0BA15E921;
        Wed, 18 Jan 2017 13:27:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] gitk: remove translated message from comments
References: <xmqq4m0xpmbz.fsf@gitster.mtv.corp.google.com>
        <20170118035245.1757-1-davvid@gmail.com>
        <20170118101515.GA12161@fergus.ozlabs.ibm.com>
Date:   Wed, 18 Jan 2017 10:27:34 -0800
In-Reply-To: <20170118101515.GA12161@fergus.ozlabs.ibm.com> (Paul Mackerras's
        message of "Wed, 18 Jan 2017 21:15:15 +1100")
Message-ID: <xmqqd1fkb4vd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8C29DBA-DDAB-11E6-ADCC-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Jan 17, 2017 at 07:52:45PM -0800, David Aguilar wrote:
>> "make update-po" fails because a previously untranslated string
>> has now been translated:
>> 
>> 	Updating po/sv.po
>> 	po/sv.po:1388: duplicate message definition...
>> 	po/sv.po:380: ...this is the location of the first definition
>> 
>> Remove the duplicate message definition.
>> 
>> Reported-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>
> Thanks, applied.
>
> Junio, please do a pull from my repository to get this fix.
> The new head is 7f03c6e32891.

Thanks.
