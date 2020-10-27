Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0DC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310F72222C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vayS31FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830603AbgJ0UAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:00:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823131AbgJ0UAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:00:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27C4780425;
        Tue, 27 Oct 2020 16:00:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+ARFxak29JJc
        KTGLId14SF8+NRA=; b=vayS31FQ2tpC5AwcaBqE6CLkdh9H9Ml1r/5q0OBqiHyv
        5rAF56UtJt3gX80HpmnuetQQaY1+Qb3KCvJw4p01xsc4p3uEGreBWurywow6oD/Q
        t3DvMUJ292W+SQASX/vzPBMjouOyWbkG/wV4Mc0eN39DUquistc6xg8B/PFmoZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MefFHh
        O9DVqcYR89yEJ8KfKHdXpdsViDVNEHRvmLHeWz8iZ+NW94KQ+2SzU/vCAD0hJZMD
        6J0cOce+ocCGH6do2mcNzEX9xQQshop5hRsKRmpDi30g2845ddi+oKRG0hykdaii
        RLq8K3j/BF4r+sJZQdsTDvZp1Up+Dz0gxepBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C7D880424;
        Tue, 27 Oct 2020 16:00:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7300B80423;
        Tue, 27 Oct 2020 16:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
        <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
        <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
        <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
Date:   Tue, 27 Oct 2020 13:00:13 -0700
In-Reply-To: <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
        (=?utf-8?B?ItCb0ZHRiNCwINCe0LPQvtC90YzQutC+0LIiJ3M=?= message of "Tue, 27
 Oct 2020 11:59:20
        +0300")
Message-ID: <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07302802-188F-11EB-ACF5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=9B=D1=91=D1=88=D0=B0 =D0=9E=D0=B3=D0=BE=D0=BD=D1=8C=D0=BA=D0=BE=D0=B2=
  <lesha.ogonkov@gmail.com> writes:

> On Tue, 27 Oct 2020 at 11:32, Stefan Haller <lists@haller-berlin.de> wr=
ote:
>>
>> On 25.10.20 4:29, Felipe Contreras wrote:
>> >> The other hunk (adding compinit) is not so important to me; I suppo=
se it
>> >> was not in the original version because most zsh users already have=
 this
>> >> in their .zshrc anyway. But it's not wrong, and doesn't hurt to hav=
e
>> >> here, I guess.
>> >
>> > If you don't have compinit, then how is the '_git' script being load=
ed
>> > in the first place?
>>
>> I didn't say it's unnecessary to have it in your .zshrc. I just said
>> it's maybe unnecessary to document it here because most zsh users have
>> it in their .zshrc already anyway.
>
> As an inexperienced zsh user it took me ages to understand why the
> whole thing is not working.

So,... even though it may look to more experienced zsh users that it
is unnecessary to document it in this file, in your opinion, it is a
good idea to mention "compinit" to help less experienced users?

In any case, the patch in question is the only thing in flight that
conflicts with Felipe's 29 patch series, and the change to zstyle
line is common between both efforts, so it is just between adding
the "autoload -Uz compinit && compinit" near the fpath=3D(...) thing
or leaving it out.

I'll let those who know zsh to figure it out.  I suspect that the
resolution would be either to ask Felipe to rebase his on yours,
rebase yours on top of Felipe's, or just drop yours (if "autoload"
thing is unnecessary as Stefan suspects---I cannot tell what Felipe
wants to suggest by his response, between "unless you have compinit
you wouldn't be using this script so why write it?" and "your users
need to be taught about the need _somehow_, so why not make this the
place to do so?").

Thanks.
