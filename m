Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E62C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C546B6124B
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbhDMVKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhDMVKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:10:21 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FBC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 14:09:59 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FKdXh21qkz1s0td;
        Tue, 13 Apr 2021 23:09:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FKdXf1yKhz1qqxB;
        Tue, 13 Apr 2021 23:09:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2M0XHRzzEI4G; Tue, 13 Apr 2021 23:09:53 +0200 (CEST)
X-Auth-Info: p9MC92XnLSB7na4FC6AncquVno8YPxjeAREVnISsLqUxjY7EfSZ1Bjp01EhEaBOD
Received: from igel.home (ppp-46-244-161-206.dynamic.mnet-online.de [46.244.161.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Apr 2021 23:09:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id A866C2C324F; Tue, 13 Apr 2021 23:09:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sam Bostock <sam.bostock@shopify.com>, git@vger.kernel.org
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
        <xmqqlf9lly3d.fsf@gitster.g>
X-Yow:  When you said ``HEAVILY FORESTED'' it reminded me of an overdue
 CLEANING BILL..  Don't you SEE?  O'Grogan SWALLOWED a VALUABLE
 COIN COLLECTION and HAD to murder the ONLY MAN who KNEW!!
Date:   Tue, 13 Apr 2021 23:09:52 +0200
In-Reply-To: <xmqqlf9lly3d.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        13 Apr 2021 13:37:58 -0700")
Message-ID: <87pmyxc2n3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 13 2021, Junio C Hamano wrote:

> It may also be
> possible to add "git fetch --reset-remote-tracking-HEAD" option to
> make "fetch" overwrite existing origin/HEAD but somebody has to
> propose such a change, argue for its benefit and get it accepted by
> the community.

Isn't that what git remote set-head origin -a does?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
