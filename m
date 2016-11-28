Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2501FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbcK1SIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 13:08:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61895 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751635AbcK1SIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 13:08:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C64D552702;
        Mon, 28 Nov 2016 13:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5d8CKmGe3jgecIUR5THvPjsghls=; b=cJajx4
        /g8h3xbKid0RTudI4cOsjGW0Djv2w6ALO1yu7bmh4wf0pe3D4v3YW629qDICccmz
        kQwVoUPV62OZfm2JwFpQO+klSRE4DkpepOX9v5nWS2Yo7B6hxk4ewHgDIpU7n8di
        ZKpEuzhgLbX2n6LmcrTGC38raPDzD2zPBfhK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cyi2Cl1cQjCI0K8JydkeiPm38GWr4q6N
        BB4uabDnjRIDT2vrW7P8pjBBBXDxhz6sDNZPeLjMucANXuXbIcVo47//e3wsE/Ma
        x2TqPq4GPvOPIr2lj8K5iAFMQjn25NXtJ7pkHBc8OCvnvhonGW6K9JmTMlGpnp+c
        c7Jo/YgN6OA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDAD852701;
        Mon, 28 Nov 2016 13:08:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2984C52700;
        Mon, 28 Nov 2016 13:08:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
        <CACsJy8DaOB=ybWFbcqFgZ_U_JYWFUXNDJRmG6_-S3raWh6AWaQ@mail.gmail.com>
Date:   Mon, 28 Nov 2016 10:08:27 -0800
In-Reply-To: <CACsJy8DaOB=ybWFbcqFgZ_U_JYWFUXNDJRmG6_-S3raWh6AWaQ@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 26 Nov 2016 16:42:45 +0700")
Message-ID: <xmqqr35vjx44.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A99E47B0-B595-11E6-A720-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Nov 24, 2016 at 6:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/rebase-forget (2016-10-28) 1 commit
>>  - rebase: add --forget to cleanup rebase, leave HEAD untouched
>>
>>  "git rebase" learned "--forget" option, which allows a user to
>>  remove the metadata left by an earlier "git rebase" that was
>>  manually aborted without using "git rebase --abort".
>>
>>  Waiting for a reroll.
>
> The reroll was http://public-inbox.org/git/%3C20161112020041.2335-1-pclouds@gmail.com%3E/

Thanks.
