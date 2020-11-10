Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108DC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFA2076E
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a/7vRuIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgKJPSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:18:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:54225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgKJPSG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 10:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605021484;
        bh=CP5A8arWspYN4CgGoxzpECvK9T0vBFODjpf8/jIWfFI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a/7vRuIAnydGOrNiyvtMQGuG9q2l4VjcRrndMwolt/lYwEcCY1LGqrKagPoIDRlxZ
         g1S9MaeGIGpNJmcH6njDuRQvchx8LnDXC9COVZ+hhRd9GcYIUS+VnLrcnXFSznix5D
         W9u1dv7qjhM529nQ6egCvQgA70ejU3d9ktBHAVW8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1kOhgc0rre-00vusc; Tue, 10
 Nov 2020 16:18:04 +0100
Date:   Tue, 10 Nov 2020 16:18:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2402: fix typo
In-Reply-To: <20201109215215.GA1911@contrib-buster.localdomain>
Message-ID: <nycvar.QRO.7.76.6.2011101617050.18437@tvgsbejvaqbjf.bet>
References: <pull.777.git.1604404087749.gitgitgadget@gmail.com> <20201109215215.GA1911@contrib-buster.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oTPc5JUrFn7OJUzaKNcOQ4deFxhpuTfw+D3rzxqdoWbNOBHc69Q
 E04Y2KYNE6GPOPDu1uUY9Q/HMBLwbN6ZsEDGZbOLoorAH8Ra2UaYMCQILQh21EJbTwYQO1s
 /Zp2qWIMR+ftuFNTKi9C9VGXRUljqkS/zmr//hbrAOjuEYu7L/tNsdddJIuWxZInEyIHcdR
 90XyZg24gWroHhiqdE9dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HcelPjFDpQA=:r8xGPEYNKl09EO1QisnIRw
 q7gP2/ZhR5k3fYg9kZ9wqtN1ffQ7R94qfbPKVNUw0CXjOq5RPwv1ct/TlUstDbQHKRq3gh94Y
 9JbpMsArIeyRwnuVkqph8X2OfhEQ2gmawItYxXQ9KqsUoUg38Y8HzILHYOUcl8m3fmUDj/DNC
 +cNnE2V6Mg9uloNMIXUz8oVXL8zEsYZajEsbFrcZnFVuvA0LQFac8pN1tknEQLX6pKKxfQLNI
 OZB8F484QlUy6SqIpQYY5L7eyzsohcaFVu+uPABVf8ueF6CHcEXX1td8KGwU0/vyCWTFAlZ0s
 73J5ISWX42iE4RrGFhOrMSMgnlXONXDLQcEOcT0YFUNlRfuTgBue7ryY4vOFmewqsrznmVziM
 6s5ScxYcU+KqFmyvlmw/+9l4tPS+kdzwxanD9XPnXMGsVhER1jI4X+nf9COCf+uyOGVpwWBnB
 3nF08Mpc93C/xMSfocPtMIthqa9TH8ezsMhRqbmc2zxXwppkL9MWJZTwUDz9AIzn3BAo13Nbf
 qkDvv4Qst/gWHVpGdRAlgUp9wgDVUbqdrtlstAKJ13qgHneEPGqyV/JJS8cCT73WXvzap1Qm3
 9fvfEnSgt7cO79B/jwb0czyL9L9/wOnHWPI0Xw5FWizgRZ8bgOI3I9G/phancoMFu4rmM9Jsm
 CyzcNjUIU6+qCQ5sO7Xt+PgQzVhulbLHet7sHzQ98Ak9E8AwVurHja78Nje9emvOwMW+vZUEJ
 ryGxUggXPNRCTmzvvi++QwrLqOtyYZjiZ8y73ZhwWyADjMDT9F4ux0MM/7Fx0pPBsLjkou3LG
 VKz8lyrm+V7io37O5ljMpzok9Lna3P9oSur4YQTwKIfoRtQyN5PglwcWUxhkD04M36s0QzeUa
 KTz+gK0vX6MtXRkCyBVm4p1VXE4K8VmrGRRgao1BU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rafael,

On Mon, 9 Nov 2020, Rafael Silva wrote:

> On Tue, Nov 03, 2020 at 11:48:07AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In c57b3367bed (worktree: teach `list` to annotate locked worktree,
> > 2020-10-11), we introduced a test case that wanted to talk about
> > "worktrees" but talked about "worktress" instead. Let's fix that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     t2402: fix typo
> >
> >     Just a fix for a typo introduced in c57b3367bed (worktree: teach l=
ist to
> >     annotate locked worktree, 2020-10-11).
> >
>
> Oops, how embarrassing.
>
> Thank you Johannes Schindelin for catching this typo and sorry for the l=
ate reply.

FWIW I don't think that you need to be embarrassed. To me, this patch is a
beautiful example that Open Source works, just like other patches that
were sent to this list to fix bugs that _I_ introduced.

Thanks,
Dscho
