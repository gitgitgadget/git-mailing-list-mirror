Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2EB2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdHDVVF (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:21:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57447 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752350AbdHDVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:21:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4577D9F7A5;
        Fri,  4 Aug 2017 17:21:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ocZjhWQIYTIm
        XdwN4rxacJR0+/E=; b=obMELV60nEHThdAhtHgidN3ORY5eWjlh5d30A0n4ouMk
        XT4kV7jUUrW/2nCUTSdyCaa3ZxyjXLCaLxrgT3yhRrKWsyvv+HO1U4DG9gxzf015
        +clTMkGIpkJg/lAjX4dmI6IzsIS7/j/DmxishWHa52uljh3vZuYtXFczm7qJC9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=drUpFk
        HKaMWPvStCxba2sshLIm9a8aiFFM00cIpcFhMg5Y2Bo7ebfupJDAjxaLhTRFvVTz
        7C4YfUF40QCci5hiLRkIIAnHqbL94JEBetOHz1OD6l3s0RWk4mp22Ruj61UEApve
        iyplfBDa3AMrJ5MABUnK32U+LM7aIBWmMQFiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C48C9F7A4;
        Fri,  4 Aug 2017 17:21:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A94AE9F7A0;
        Fri,  4 Aug 2017 17:21:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Bj=C3=B8rn?= Erik Pedersen 
        <bjorn.erik.pedersen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: bug: contrib/subtree: Commit message title should be in imperative mood
References: <CAAM6cWfYfpX+8iK+SH=ukPutB18UAafXOZ3fuKQBiQ-4arp-8Q@mail.gmail.com>
        <CAAM6cWenBUL6rNva+KmwnPhUwzGZeFs53=N8yOkyyTXOmXC2jw@mail.gmail.com>
Date:   Fri, 04 Aug 2017 14:21:02 -0700
In-Reply-To: <CAAM6cWenBUL6rNva+KmwnPhUwzGZeFs53=N8yOkyyTXOmXC2jw@mail.gmail.com>
        (=?utf-8?Q?=22Bj=C3=B8rn?= Erik Pedersen"'s message of "Fri, 4 Aug 2017
 23:05:23 +0200")
Message-ID: <xmqqy3qzrpvl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D21A7F2C-795A-11E7-BE1C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bj=C3=B8rn Erik Pedersen  <bjorn.erik.pedersen@gmail.com> writes:

> I.e. "Squash 'somedir' changes" and not "Squashed ..."
>
> See
>
> https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh#L=
463

I do not think this is necessarily a good change.

"git subtree" (in contrib/) is not a tool limited to be used on
projects that follow the same convention as the Git project itself.
