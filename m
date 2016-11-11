Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A1C20229
	for <e@80x24.org>; Fri, 11 Nov 2016 00:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966119AbcKKA0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 19:26:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965311AbcKKA0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 19:26:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8EFD4DC1C;
        Thu, 10 Nov 2016 19:26:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LY5iUVfGdKsQKg1ZPoQC11FgsxU=; b=nV7+Qw
        W4u7Q3QQyHrDElLNh+pVmJPZ66KOCcLCdwS8Owd83unit6CFUu3bovQlwJBj8nL9
        muK029mFEFPASj2Fz5lEca4Y4JnkWagdLERa5Wh0u0686RgzDfopYvGIaGQVmF8K
        vOMGKDvEtEd35G+jZZUqkbYuI3rlMMaB48T60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O94h6NWiibhR4IR1/jWDT7IYRX1LGHeZ
        DT3asLy8FfORc3kR8CmJJg8Ou4G2cGN4lgwTNXrsc6q9wgCTJLxjFHCMX8YvZVeR
        aUGNt7r0xMnK5/jWqNBmVLRKcHN3+I3TYTm3yNvkXSu6170St417GYkapMSDdo8p
        vPHg049McHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0CEF4DC1B;
        Thu, 10 Nov 2016 19:26:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CE064DC19;
        Thu, 10 Nov 2016 19:26:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 10 Nov 2016 16:26:06 -0800
In-Reply-To: <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 10 Nov 2016 13:43:47 -0800")
Message-ID: <xmqqbmxm50bl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70A4A01A-A7A5-11E6-819B-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I'll report back an updated schedule when able.
>
> I pushed some updates out on 'master' today.  Between 'master' and
> 'pu' on the first-parent history there is a merge 52975d2b1f ("Merge
> branch 'ls/macos-update' into jch", 2016-11-10) and that matches
> what I expect to be in -rc1 tomorrow (modulo RelNotes and the actual
> version tag), unless there is a showstopper regresion reported, in
> which case we may want to first look into reverting the whole series
> that introduced the regression before considering to pile on fix-up
> patches.

Please make that 71d1bcb661 ("Merge branch 'ls/macos-update' into
jch", 2016-11-10); among the three extra topics that is not yet in
'master', as/merge-attr-sleep topic has been updated with a better
fix from Dscho.

Thanks.
