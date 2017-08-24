Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7AE208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 20:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdHXUTe (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 16:19:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50116 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752855AbdHXUTd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 16:19:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B62C9E379;
        Thu, 24 Aug 2017 16:19:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KItIIMjeSZVwcu5qSwgGbdcGD9Y=; b=qGXjEo
        5NA4giSU4QpnS8PtDnau08bTbZxy1oqeeup4oWumx9bLVJkaPVuVPZNt8Y3UsYqN
        T/+rAY7jSQZnbEX8hlNCUymSDZjEoJ8w1YxE6Y2Bue49+UBH/dLNEngwptmr/NMg
        VDM8NJiZjaXqYTZLC3aqf+rnYgEpHVkBpKsrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ou7AE1kuWY/YR6YaBGmDZ8XtILhTLnQx
        XQW5cNkV47TzseHdPAAGvoUWX1JKa/0z6B6vqMRtvSNgt+ISasASKoChdv2PCc+V
        Y4bYdRO5U4i9GUVTliu45TU5fYGu4ywitdpukKejq56DFw8eFPKbK34ScAMk68fX
        plZAUDrET5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 129AA9E378;
        Thu, 24 Aug 2017 16:19:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E46A9E377;
        Thu, 24 Aug 2017 16:19:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2/RFC] commit: change the meaning of an empty commit message
References: <1500107583.1850.4.camel@gmail.com>
        <20170821140528.7212-1-kaarticsivaraam91196@gmail.com>
Date:   Thu, 24 Aug 2017 13:19:31 -0700
In-Reply-To: <20170821140528.7212-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 21 Aug 2017 19:35:28 +0530")
Message-ID: <xmqqo9r4vhv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A37462C-8909-11E7-BCFB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>  As has been noted by Junio, 
>
>      "It would be a backward incompatible tightening of the established
>      rule, but it may not be a bad change."
>
>  The "It" above refers to this change. Expecting comments from people to ensure
>  this change isn't a bad one.

FWIW, I am fairly neutral; I do not mind accepting this change if
other people are supportive, but I do not miss this patch if we end
up not applying it at all.  The latter is easier for me as we do not
have to worry about breaking people's scripts and tools used in
their established workflows at all.


