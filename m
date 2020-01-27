Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E8C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF75C206D3
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tekgGT9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgA0TCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:02:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53020 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 14:02:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84B653A76A;
        Mon, 27 Jan 2020 14:02:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9xvrfm+/LmaHsrdSnU6GZFGAtXA=; b=tekgGT
        9oMLL82f2IQc+R+qlZsAeCdymBKAPCXOCwMph6EwnXaE+qdRaEfi50UYj2dR+PKu
        HU76UkcQg+PBJL6GzFeNDG30iKacBOd35msHajK8XbQDLx2lMBkzdCyaIqhdTZY9
        KQpoURBrLpe8rd2RrSunK2K3pa/fWn+olGxD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ERMUCNtA1HsgK1QhXqXQYxA/NDaiU4nY
        s1srJsMRrFgkdBSLL6G7F9HiTToRLXlKlcy4pN0IuZhC/AmKyLVWsIrkKgpisEP/
        ySUyTl8kj8wqK/hzhp9pC1URsMBky2nnlkV7LYJR9C8OPwYeG5c7NNvVBRhVRr7B
        AdMpsu0o69g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C2663A769;
        Mon, 27 Jan 2020 14:02:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1F233A766;
        Mon, 27 Jan 2020 14:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Stimming <christian@cstimming.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-gui: update german translation
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
        <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com>
        <20200125165629.55hsywaqojsdpqik@yadavpratyush.com>
        <1910399.tNsU6uBNYh@ckiste>
Date:   Mon, 27 Jan 2020 11:02:44 -0800
In-Reply-To: <1910399.tNsU6uBNYh@ckiste> (Christian Stimming's message of
        "Sun, 26 Jan 2020 16:52:15 +0100")
Message-ID: <xmqqimkwbu3v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A77B0BA-4137-11EA-8BC0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Stimming <christian@cstimming.de> writes:

> Dear Pratyush,
>
> thanks for the first evaluation.
>
> Am Samstag, 25. Januar 2020, 17:56:29 CET schrieb Pratyush Yadav:
>> > Subject: Re: [PATCH 2/3] git-gui: update german translation
>> 
>> Nitpick: capitalise "german". So, s/german/German/
>
> Of course I can do that... however, the capitalization of the headline is 
> somewhat different every time in the repository. The first word is lower case, 
> yes, but e.g. the language adjective is sometimes upper case, sometimes lower 
> case. 
>
>> On 24/01/20 10:33PM, Christian Stimming via GitGitGadget wrote:
>> > From: Christian Stimming <christian@cstimming.de>
>> > 
>> > Switch several terms from uncommon translations back to english
>> > vocabulary, most prominently commit (noun, verb) and repository. Adapt
>> > glossary and translation accordingly.
>> 
>> Can you also explain _why_ these uncommon translations are changed to
>> English vocabulary? 
>
> I've written an explanation in the cover letter email. Do you want to have it 
> copied into the commit message?

It is unclear to me how these translation patches were split into
three.  I am sort-of guessing that 1/3 is only to cover the new
entries in .pot that have no corresponding entries in translation,
and the rest is to update/fix existing translations, but I do not
know how these changes are split between 2/3 and 3/3.  In any case,
"we must update original translation that does not match accepted
computer lingo" you wrote in the cover letter sounds like a very
good justification to record in the commit that updates/fixes the
existing entries.
