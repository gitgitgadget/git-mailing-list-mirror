Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68802C0015E
	for <git@archiver.kernel.org>; Sat, 29 Jul 2023 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjG2CMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 22:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG2CMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 22:12:14 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251B4498
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 19:12:12 -0700 (PDT)
Date:   Sat, 29 Jul 2023 02:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690596730; x=1690855930;
        bh=GOw5jlyz4rPTHj7jhgIbu+QNyd0796noxpPY8gZ2+8E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DVXWAi0U0mn1KP+UzuW9/R3qimKzAtF/Z72uyGGcsDDRCT1nam/UR8bu7pQ6ibExD
         oCTIA2src9T7zTH/yz/fN+lbopSEkzVXw0XxTvKsIzWHm0JgMY/2ABtydOPpRuK8L3
         LgbbivkIYyxCpmmlemWysgHjyjrLr8v/7bYaL8Tm7+lsz+XKaOzzf827/mQXtuolIA
         mA9GEiUD5D80ZW4zGRoVs7Ys5I0D33bwb6/gXuXyowcUsMNJQYh+WHY7DjjVQbAauq
         9U0dms3JZ93V9dbI6ggcBHKk7yGXirfayyIgZmh14qNjTaoPjCI8Am7E4Crmeza01r
         oM6opoJ69fvOQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: Re* [PATCH v4] MyFirstContribution: refrain from self-iterating too much
Message-ID: <ivxtqzb46kp5uz5luuxkow6fjzwqrnvxu6f7mgu5a4mnatt6hc@djeykymbumn6>
In-Reply-To: <xmqqa5vg59ga.fsf_-_@gitster.g>
References: <xmqq3583uyk0.fsf@gitster.g> <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4> <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com> <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g> <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5> <xmqq7cqk8vuk.fsf@gitster.g> <xmqqa5vg59ga.fsf_-_@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/28 08:42AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Jacob Abel <jacobabel@nullpo.dev> writes:
> >
> > [...]
>=20
> On top of v4, we could do something like this, I guess, but I
> realize that this is talking about minimum waiting time to allow
> others to even notice-see your patches, while the original is about
> them needing time after noticing your patches to process them, and
> the latter heavily depend on many factors (like how involved the
> patches are, how many people are likely to be interested in).
>=20
> So, I doubt adding this is a good idea.
>
> [...]

Maybe something along the lines of "wait 24 hours after any discussion
regarding the current revision has settled before publishing the next
revision" would be a good guideline even if it's not included in this=20
patch?

But I'm realising now that that is probably outside of the scope of
this specific change so apologies for what was likely me stepping into=20
the realm of bike shedding.=20

I didn't mean to hold up the patch and I'm happy with v4.

