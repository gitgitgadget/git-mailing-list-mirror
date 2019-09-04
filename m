Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321BD1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 23:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfIDXiK (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 19:38:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56023 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDXiK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 19:38:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12BA922B3E;
        Wed,  4 Sep 2019 19:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPRyVsrJl6aC/aMSMWj9vkkY18A=; b=qqX1qN
        rHowvAea2ij2jJ5jVPc8qwtzvXgkfmef4fzr3/zF3hcDhpu+M1YJ04M6cmFlK4Hg
        QTitT4M1VLZckJRzS7CpywSMeOXhkTrGmKSE7cuhWFlR/1phqNd910KQ8noXPaHj
        X4d9pMU5Ir0PnT6kTMlR1Vj+1D4fHyfamPhpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R72uhG9pjpyiSaEIzSqoYj9URzH7GoZa
        q8G58figOXtnG0oTiL047Lzw81zo7rOX4Ium04e8Xsusg4vfrBb5Eom87JNeSu87
        PqQTI8+Y+M1QnGsXPcni/E1NnAVL+4Vd3lyuJLtFJeDXyXTsrZYswyLhmw4S5hQM
        qRD/CTkID+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AFF322B3D;
        Wed,  4 Sep 2019 19:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FD6522B3C;
        Wed,  4 Sep 2019 19:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
        <20190904143055.11400-1-birger.sp@gmail.com>
        <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
        <CAGr--=LY4JWdms3GtnKAtN6z-2c-jpXE2HJ5_dMM5gEFayrj_g@mail.gmail.com>
        <fcf52af1-dc57-fb58-f52c-7581910a28d6@kdbg.org>
        <20190904223102.webntwh5awsl2m3i@yadavpratyush.com>
Date:   Wed, 04 Sep 2019 16:38:06 -0700
In-Reply-To: <20190904223102.webntwh5awsl2m3i@yadavpratyush.com> (Pratyush
        Yadav's message of "Thu, 5 Sep 2019 04:01:03 +0530")
Message-ID: <xmqqy2z3r5sx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C35ED58-CF6D-11E9-822E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> On 04/09/19 11:39PM, Johannes Sixt wrote:
>> Am 04.09.19 um 21:20 schrieb Birger Skogeng Pedersen:
>> > On Wed, Sep 4, 2019 at 8:59 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> >> Many keyboards do not have a right Alt-key. That means that Alt+1 to
>> >> Alt+4 combinations must be typed single-handed with the left hand. This
>> >> is mildly awkward for Alt+4. Can we please have the very important
>> >> commit widget *not* at Alt+4? I could live with Alt+3.
>> > 
>> > (RightAlt wouldn't be used by Europeans, anyways)
>> > Are you suggesting to keep Alt+1/2/3 for the files/staged/diff
>> > widgets, but use something other than Alt+4 for the commit dialog? If
>> > so, which one would you prefer?
>> 
>> I was suggesting Alt+3 for the commit message widget, but my preferences
>> are actually Alt+1, Alt+2, Alt+3, in this order. My preference for the
>> diff widget would be Alt+4 (the awkward one) because I do not foresee
>> that I would use it a lot. Use what remains for the two file lists.
>
> I wonder if that binding is very intuitive.  If we do 1/2 for the top 
> and bottom panes on the left side, and 3/4 for the top and bottom panes 
> on the right side, that makes some sense.  Doing it your way makes it a 
> counter-clockwise motion.
>
> I am not arguing for or against this proposal, just pointing something 
> worth thinking about.  Either way, I suppose after a while it becomes 
> muscle memory so I'm not sure how much difference this subtle thing will 
> make.
>
>> 
>> > The initial propsal from me was to use CTRL/CMD+1/2/3/4. What do you
>> > think of using the CTRL/CMD key instead of ALT?
>> 
>> I would not mind Ctrl instead of Alt. Take your pick.
>
> FWIW, I vote for sticking with Alt.

Can't these differences in personal preference be solved by
configurable key binding?
