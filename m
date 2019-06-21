Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75B51F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUUnF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:43:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61571 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUUnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:43:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E65BE73459;
        Fri, 21 Jun 2019 16:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F5jsj9iKaylod3obyEdXX9GT/sM=; b=UiYUoQ
        aWSKjzbC+BtXNyNGTZ575qRlzTToqiv11fPAwi0AssPGq3LJVCpyQWQ1XnrbpMh9
        zzJrCf16MujgQZc7/+dvpyH/l/lSkIiztGlxhRsw2+nWSvJDoXa7bouxsIA47jr6
        ztPmgC2IVRs2kWbb4SdriZjnfRGJnY8GIpcMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GYz8IhM/ciA8XF4GfeGIgX7dCcUxNNAE
        ktVidqc0FpeH5BdNqfz7B9EpetoScZRmuNtYXCrryyvFmvw4FC+JzF7bEd4L2FT8
        xBTdHQ+Gys8bPlmoyVjdocKnusblDZ8RQx9f0MYaHOBtWeD6RsQeAT3ftTi3GEUc
        jAT41LcPKzA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE06273458;
        Fri, 21 Jun 2019 16:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DDA573450;
        Fri, 21 Jun 2019 16:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: sg/rebase-progress, was Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906212127500.44@tvgsbejvaqbjf.bet>
Date:   Fri, 21 Jun 2019 13:42:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906212127500.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 21 Jun 2019 21:29:23 +0200 (CEST)")
Message-ID: <xmqqzhmaisa4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29855FEE-9465-11E9-A708-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 19 Jun 2019, Junio C Hamano wrote:
>
>> * sg/rebase-progress (2019-06-11) 4 commits
>
> No, it seems that the Windows-specific problem with this patch series'
> tests have disappeared (I want to believe that my bugfix is the reason,
> but I lack the time to verify that suspicion).
>
> From my side, this patch series is therefore good to go.

OK, thanks.
