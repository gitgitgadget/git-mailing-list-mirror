Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF13B20281
	for <e@80x24.org>; Mon,  2 Oct 2017 12:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbdJBMDH (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 08:03:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750903AbdJBMDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 08:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 160E1A82D1;
        Mon,  2 Oct 2017 08:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aTebDtNmOWxy
        BKDPMgZgSXR3PaU=; b=IyCf6uwvC6Npm0CTYYQdeCDt8vDgHaY9t3eliZBdYa3a
        n79nEoAIrStE+1ORkcywTJvXPejW1X9iNPAU5zJNsZMdduj7FfYZ15N0RDDU1NSb
        YQnkTRJftYteXCDxFBWZHXHoNnvL36ZbOsHjBygjKsybow5bg1CFPXMsyJqJG8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rXhGUD
        w5VcF3sW1dZbEzf2DgB65no7gdq+C0gMD+CiUZd3m7QuhGqJifhzejdc599bBGdc
        GVdiqx8QRTisP7NiAjYo59PimTbOO0kwQF2tBCuySvXoE9mSKHTbwLpYKjq5eZss
        B2EumjY5vaer1gpV0WnAUTnKNJzCUNf5Y7MkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D105A82D0;
        Mon,  2 Oct 2017 08:03:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 783E4A82CF;
        Mon,  2 Oct 2017 08:02:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqqKZeNQ0Je5RgmKXm2poTyfw7cCJiTYweOtOwMHqncgA@mail.gmail.com>
Date:   Mon, 02 Oct 2017 21:02:58 +0900
In-Reply-To: <CAN0heSqqKZeNQ0Je5RgmKXm2poTyfw7cCJiTYweOtOwMHqncgA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 2 Oct 2017 12:26:57
 +0200")
Message-ID: <xmqq3771oiz1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A256F238-A769-11E7-956C-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 29 September 2017 at 06:34, Junio C Hamano <gitster@pobox.com> wrote=
:
>>
>> * sd/branch-copy (2017-09-24) 4 commits
>>   (merged to 'next' on 2017-09-28 at a6eceefa02)
>>  + branch: fix "copy" to never touch HEAD
>>  + branch: add a --copy (-c) option to go with --move (-m)
>>  + branch: add test for -m renaming multiple config sections
>>  + config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>
> s/and switch to //, I believe, after your finishing patch.

Thanks for careful reading.
