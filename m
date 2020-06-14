Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2664C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92685206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uV0UKFZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgFNVjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:39:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62806 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVju (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:39:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA880C2012;
        Sun, 14 Jun 2020 17:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EPomqV64dNiKRB2lDKv4DhaTlyY=; b=uV0UKF
        Z5m+Oc/tUkFbBFYr9tOWNQXMRJgyxg7bold3kC0RfAbaun+FksYjN4L7pCEzgDDz
        j252Kau44lah05NM94K2trtDlwZZ5aLWN3HhdzA1Rqkz/+N5EK5n593KtpDBzmeQ
        gYxROipmr8iwWciqe6MKndii5Bw0Vec9BJoTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nr3uGU6JXZ4M1upEYV5e396eRttrpKAR
        XdVCNot7mPL0Mi1rOpj5C90lihwIOps9/tn7g15Q+SzmgBToXhqqT+vcMVnkISNe
        Orxo2hHSegtMKwgSdR2pEqbFUvqvcwKrL3z0sA3JePAQ7lijr46q5x1DHR3h13el
        EOwpMdI/LlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0F6DC2011;
        Sun, 14 Jun 2020 17:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2C5CC2010;
        Sun, 14 Jun 2020 17:39:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <normalperson@yhbt.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?utf-8?Q?S?= =?utf-8?Q?=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, philipoakley@iee.email,
        Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
        <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
        <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
        <xmqqmu55xsqd.fsf@gitster.c.googlers.com>
        <20200614211500.GA22505@dcvr>
Date:   Sun, 14 Jun 2020 14:39:44 -0700
In-Reply-To: <20200614211500.GA22505@dcvr> (Eric Wong's message of "Sun, 14
        Jun 2020 21:15:00 +0000")
Message-ID: <xmqq5zbtxr6n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90AFCB36-AE87-11EA-82D5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> It of course opens a different can of worms ;-) Even though we can
>> please master-slave-haters by moving away from the particular word
>> 'master', those who cannot stand the very idea of one thing being
>> special among others will not be satisfied (and we shouldn't even
>> try to please them, IMO).
>
> As somebody who does not like the idea of things being special,
> I'm considering renaming "master" of the few projects I maintain
> to "unofficial".  It fits my anti-centralization and
> anti-authoritarian mind, at least :>

We probably can teach "fmt-merge-msg" (which is what helps "git
merge" to special case the message for merges into the primary
branch) and "fast-export --anonymize" to honor some special value
for the configuration variable (core.primaryBranchName???) so that
they treat that NO branch is primary/special.  

Perhaps an empty string would serve the purpose.
