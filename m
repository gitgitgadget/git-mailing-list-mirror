Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F428C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiCDPxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiCDPxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:53:47 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBE6E7BC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:52:58 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4K9C6x28BRz4xVyF
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:52:57 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="q9JuvQrp"
Date:   Fri, 04 Mar 2022 15:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646409172;
        bh=Wooit9YmGtEZNBdiFBJZjDgJXzllVsf+huxYfvzjItI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=q9JuvQrpC2lcSHi+yo5OrhKbC2ziJdo0Lr4oC26kxDif7NlZHr8QWBJzDpQ8IA8xu
         yo5Nk1Dwz/lTzNb7f7fLCGEcPdPPk3F+faSPFm14n/R+yVk3CPFIqHzJ4dS4VGhSxh
         XvNm+MKBlCfyBmORpMHXJCUrxyIqVv0XJEqD32BAJNdEHKCciqE0iBco/pzyHg1/b8
         HW1cFLBhND6IoAB+he69ZbBH2mbmM2nikOR7J/JgATGjhUYGp152bMS4ELsYDx6F1g
         dPZ+e0bsumxYwkoYffo1zLinWNY565gduiCGpJXhV41KTwGytHbmYWxkMUNQ5jl7/I
         io3/xfWeAbuSQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Matheus Felipe <matheusfelipeog@protonmail.com>
Cc:     Matheus Felipe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Reply-To: Matheus Felipe <matheusfelipeog@protonmail.com>
Subject: Re: [PATCH v2] fix: include the type flag in the cli docs
Message-ID: <wPjDF_MqZ9RmGuEcyP_8axDVW9K7gfBaiycvgu6MM0UeW2ovCLDD5PqOVf7Q56aNGdFqaKUQvnOsoPW_0lj7matX-HmMGaL-uwhE8hrcPyA=@protonmail.com>
In-Reply-To: <xmqq8rtq2may.fsf@gitster.g>
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com> <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com> <xmqq8rtq2may.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> One more (hopefully final) nit. By reading the above alone (which
> is what people will see in "git shortlog --no-merges" output), you
> can not even guess which subcommand the "fix" is about, or if it is
> even a fix to the code, or just a documentation update.
>
> I'd retitle it to
>
> config: correct "--type" option in "git config -h" output

You are right, this title is much better. I will update it.

Thank you very much, I learned a few things from this contribution.

