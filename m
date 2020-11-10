Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B212CC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D32206B6
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q2V8JIPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgKJWmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:42:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:56093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732100AbgKJWmw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605048169;
        bh=KEBdgjIpUHfhmJQcXDZWcZpAjDSt5ZqW359Yjx56iWw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q2V8JIPHjeWQ7MbS8NDTPToKK1rYwjY22+0V1HehKeZP/qq3bvj7NzsW1Kh+efahW
         t6bi7s84FRDErgRbKlWysb0MMiTxo8OD6qcB6rNE06cLUAB/w7O3v+H9m+ZNJAJhTp
         soYyjMPXzFA9m+OTjSXyh6yQyenZGLBxyR5RadN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1kCBSq0Ddx-0102XH; Tue, 10
 Nov 2020 23:42:49 +0100
Date:   Tue, 10 Nov 2020 23:42:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ryan Wilkerson <Ryan.Wilkerson@microsoft.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: Windows Color scheme not preserved
In-Reply-To: <MWHPR21MB01435E001D3B779017675B1297E90@MWHPR21MB0143.namprd21.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2011102341460.18437@tvgsbejvaqbjf.bet>
References: <MWHPR21MB0143F3E8DA25D35AEB0DB92B97E90@MWHPR21MB0143.namprd21.prod.outlook.com> <MWHPR21MB01435E001D3B779017675B1297E90@MWHPR21MB0143.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+/YgsI0lGxEdfFQDbxxwAiGB7N75E6WXZDyenOWY24pq6FMaM7Q
 6p4/57jRHme4lLo+Hz7hTCmcX8RvDI0+d7JIZoR6Jx/MpvW5WwjWts5x9+QjCkZIr1SC05t
 fMibMG0K+UnbkMQz6YTFc2choOcn4TxWhG9cibQbE0S1u4i6JYusf9NkasPRH0eKQLzMX0X
 ytSoA1Cnfm0h7clZwuXLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hSX3NdHqdm8=:gJBDhl2oqqlmE4yYf3MrEB
 /vxsHFKW7GfnFnb30I7kjAbsO9huIU/fEWnOsOr4uMRcKbMBU6gCTQnEh+VfeDpBSpUNOllky
 nrYKH3Nf4ZhukGmuhRR7vRLMOiPwmiHn7UvDzDiUeHv346VTRHzvbV83jqrkHuSt/ENjdtE+8
 x/jecXx0jcGBUbBcJ45nlSdFQb3Kcdt7guAeUon3tez4LVrVH95u9hhw/xN5mg5wEgSV9EH1I
 EboJhaB/l47k1ouxQ03kAlRgqP9KkNaTIO6WDcEGaOdaEDw9pg5aOKXembS9wxMJCg8p28/BA
 UkwVoumyOS0t7Nqe/c1H85i/MOzgtJkNcVpmFDaAtp2zAkK+8hPC4GG/5pgPSNZi/l4a6OUjd
 SFZAk7m9R9XfTrwas6SGaxwwyK1x4/mFySFpjt/yDnWV7xY4BEs/FG4H43U305zDyiPGGsCzt
 crqfEn/6yT1481teqhotCZ5DXoVEqM1YO5fooqgrda/mLgcNDHdUsnpuSeaY6l9nLvCw4i24U
 KsSCRqSNlQAl4VfUv6QiaWaXMVYkgrQreg6Fl1gaR9DSSs3BVHAWWyhwAIso1Ejo35iJho1Or
 7ktZYU1a+xX5niRaeRsQhH+ebrtveqcGXmN0qatz+kGwaOVX66pXTVLKSEIiTkPakMoHU+xO6
 6C8cJ4yYbiZpu4r8j49rOSnBhEX3Ym9BfmdK2CDRoY0pO+z0jMWG6gUJtsP6otD905QNwPSWT
 nPO5vOd46p8ENAS6VIlINg03DXlirAfHfMV7BUn4OU3JQGr+YVq5W7zlMEAq4GgkTdUD16roy
 wFnOGBiQ6JZFuSMQk2bTdeW7YPiM13XFOnyQ6PJJU7bijzlAKoJgwgmzAG0Px8pic7h19uV/D
 hMxP/KW+HMEE7yZ/G4Ct3VZ7ztm5kWbaImQF5ZLwY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ryan,

On Tue, 10 Nov 2020, Ryan Wilkerson wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I set the color in my Windows cmd-line window to something other than
> the default.

Could you describe in a bit of detail how you did that?

Ciao,
Johannes
