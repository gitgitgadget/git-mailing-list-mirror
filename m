Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A016208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 21:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdHCVRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 17:17:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57360 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751746AbdHCVRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 17:17:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B38AA86D3;
        Thu,  3 Aug 2017 17:17:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IHbQJS3zrI42JCY55NBcfnyC8Q=; b=wVvAsC
        pEjm/aNPnNsJIG5xBeph2N98nJJAFNZ+aVCghdZkqwB+prbFDpgiyfc9rwAZUOQE
        S0bvzI3UaKpZeCo9c1SkyXDchue5RLUgipxts7KOL2CY+GNMCGoFKgVhwZneVhgi
        LDlLjjm+aEE7raoSzKCLvFdPBvpVwC0Xlttks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qb3vaf9fLULPhKl7RKGBIYxOSUI1DFTo
        TzSoeIdrTxzgy1kAbRbxf1TkxKmkVS5orcV9xwLXxdhX6Hr1YywUbGUS4taEosXk
        ZMc3eDntrG5cApzqjXXCDWn8ahaHwV1MPEFCdojaNKodiKTn4X0oQebzQjRbiG90
        j9GnhWLFE8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42FC9A86D2;
        Thu,  3 Aug 2017 17:17:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B090A86D1;
        Thu,  3 Aug 2017 17:17:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
        <CALiud+nKTNsr_z528Wwv3ELLk+uKoJkYa8hctg-C1dtXrbkvKg@mail.gmail.com>
Date:   Thu, 03 Aug 2017 14:17:44 -0700
In-Reply-To: <CALiud+nKTNsr_z528Wwv3ELLk+uKoJkYa8hctg-C1dtXrbkvKg@mail.gmail.com>
        (Sahil Dua's message of "Thu, 3 Aug 2017 22:17:16 +0200")
Message-ID: <xmqq8tj0wdtz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 318FAACE-7891-11E7-9C9B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

>>
>> * sd/branch-copy (2017-06-18) 3 commits
>>   (merged to 'next' on 2017-07-18 at 5e3b9357ea)
>>  + branch: add a --copy (-c) option to go with --move (-m)
>>  + branch: add test for -m renaming multiple config sections
>>  + config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>>
>>  Will cook in 'next'.
>
> Junio, are we still waiting for interaction with other patches to
> settle down or simply cooking it further for any potential
> feedback/suggestions on this?

No, "waiting for other topics to settle" was a long time ago.
During the pre-release feature freeze, nothing will be merged to
'master', unless it is a trivially correct bugfix or a regression
fix.  This one is neither.
