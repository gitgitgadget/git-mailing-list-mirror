Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCCD1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbcLNRus (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:50:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753463AbcLNRur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:50:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1B7A55493;
        Wed, 14 Dec 2016 12:50:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZUMFgUULfm2vhxFhIQ7U4Me3J00=; b=uzseqk
        Yromvmd6qoCCPDyx4rnk5ir//EDwK4pMw5qkRmY5O/USBmIXq29DsC/9FFpySpUR
        IbduSvSdioKJtz7r0LanLszWwq4FRdSI0+nK3GRMKjp4MYg0gErzHCMOPpIhMQOL
        k0RAyX3+AiXGBCWzzMZrM0ezNy4Cn34qRyP+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SK0M3QxssWsbspWm1x01i1Q273qwTF/r
        wam3JjmIY3nl2FQwchVp1LpZqZ9tZ1Oc6fNbHzLB8Ljf3+bIDlQuWBQEVuv0qdTN
        LDL6icuG+FMAisHaiz7pvQZ57ItGRd5Nbf6sdYXPNQADPDxwbJXiH9naRNjYBw5R
        l89jM43jUB8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9ECF55492;
        Wed, 14 Dec 2016 12:50:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D13955491;
        Wed, 14 Dec 2016 12:50:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] update-unicode.sh: automatically download newer definition files
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
        <1481671904-1143-5-git-send-email-dev+git@drbeat.li>
        <b137249e-728a-5d3c-4993-5ed5a1593737@drbeat.li>
Date:   Wed, 14 Dec 2016 09:50:43 -0800
In-Reply-To: <b137249e-728a-5d3c-4993-5ed5a1593737@drbeat.li> (Beat Bolli's
        message of "Wed, 14 Dec 2016 18:40:48 +0100")
Message-ID: <xmqqvaumxuvg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6B82436-C225-11E6-80FD-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 14.12.16 00:31, Beat Bolli wrote:
>
>> [PATCH v2 4/6] update-unicode.sh: automatically download newer definition files
>
> Dang! And again I'm not capable of putting an underline instead of the
> dash...
>
> Junio, would you please reword the subject to
>
> Re: [PATCH v2 4/6] update_unicode.sh: automatically download newer
> definition files

Will do.

This is an indication that the script is probably named against
people's expectation.  We may want to rename it after the dust
settles.

Thanks.
