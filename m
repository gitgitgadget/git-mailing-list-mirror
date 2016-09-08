Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FAF20705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941023AbcIHTMb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:12:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753682AbcIHTMa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:12:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 858393C80F;
        Thu,  8 Sep 2016 15:12:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5csmQnZyHXR9YL8WiHadyyd9Fuw=; b=P3LunP
        7ppvMOVrf9vhsynr1yEyNjPN9JYUR3m9f0y/R5N/MlljbPgjk3P6Yp8PUv42bMmC
        2B4LXU4wdxqav53BB2UJIzo4pyjYArH2mh71yZv0423E/eyuYCGhbwIpQyK9BX5s
        TrrVDKPl9PHGu/xjYga7akTBrBxebQ8t7Jt5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GF0bZSnBR4kZ3Z85lC04UTsGaDck10Lh
        NiQw5qPgcDtJTv/TDXYWNlPVQKBQSj94ILSZGC+6mINRW/GJ1E59TKg0c+rIV8n5
        6YzUtgZVNJXLnVOxDLvLtxDaj09av7PLu39N/fiIVQbGm/IrFjOoa7Nmwbb0sXbS
        O4g9b0HbrHA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46F0B3C80E;
        Thu,  8 Sep 2016 15:12:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6716F3C80D;
        Thu,  8 Sep 2016 15:12:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
Date:   Thu, 08 Sep 2016 12:11:59 -0700
In-Reply-To: <20160908185408.5qtfnztjbastlrtw@x> (Josh Triplett's message of
        "Thu, 8 Sep 2016 11:54:08 -0700")
Message-ID: <xmqqoa3ygq9s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F08B7DE-75F8-11E6-A3ED-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> If any other change ends up being necessary, I'll split the patch in v2.

Thanks. I do not see anything else offhand myself, but other people
watching the topic from the sideline may spot something we missed.

