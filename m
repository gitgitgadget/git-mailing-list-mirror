Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5DD1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 20:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLUBy (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 15:01:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:51177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLUBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 15:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573588897;
        bh=LdfA8rzqsgivL3cb0B/EWQ915A7vjIHUr26ztWXddxU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pr/Rfip1oXAC9cRCqW5+DnPN8UGdWmkpIuSfjIHTupytS1M7gobNxjt/Hfomyd4mw
         6AGPwzRsLCCUNrzKeUOyF75p8izX0sAvXcrc3vA/6kmMc+qFDBvf3ABz7XqkXa2Z2k
         bNpNILabcti6AXYyPJouuG8LGeB0VTkoq7/FI7Vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1iQL2n23lI-00UnpX; Tue, 12
 Nov 2019 21:01:37 +0100
Date:   Tue, 12 Nov 2019 21:01:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
In-Reply-To: <20191112184547.GA38770@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com> <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com> <20191112184547.GA38770@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wru/i1A56klMIR79Wb6aD5yzKubLlX3RTJK4/hIhORyJUwo0UFO
 GjONsXFuFyeEN2UcYnCXf3v/AcffUHKOr7WgxldHwuqfquC0/NuHurIIqpB0WWLtlff55E3
 lrON3yYiPsvnLXR+Ku+gPtbRzTrA4GwPcwnN2DZqDqck+1PDHcLGCEY1pNXyO/Sx7GyHihy
 +hU6VVDYSUiZDhTIeB54g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2tU1iIYxdA=:ylGZqbCj1xb4WZFK9ivDkj
 OnavXmsuZwtghBqYurOkpljfCYdw5Uj/oIhX3L7b2lelH84RUNIC/CfLx1nPC1e+ZdspjXioB
 uq5Wnkeo33EGBARp+fYAq0I3GDOeP/BRdudp/B8VlDrW6FFbY231yRZI4VMr77ADokGplklcZ
 19vE/Uc87j7CqYn471mrE1qwDqIDsWXe4v3W60T8Lt0pZ5bvf++Kwwf+jBVB4WLQtZFKSFHO2
 9+sJrQDQTF+nS2R9l52fZshjHnM1YM0IGxMK0A6humJ6r1QSV0yEbFKpODYhsuHbOtsi4l1vc
 QqPoDzHh/RgkzkClMynhpOmRl3qs5Hdx4ShnDD9FAxteofSIUa96RVav0WFDAisQF8mPjXJC/
 SNuFukhJFd0r+U0TI+blXSxpOoDrHCo6nR+kFPCjBbXp6KpA1faXBXWDxPTK3jukBQ3MgY1g4
 Hpw1kkZ27mHcx0s1iX34OKPuECo1mChWQGHZOP3AHnPRDBhpi2/j40q0VSYqHBQ75xdwVsAKU
 3kEE3gr6xifFsRKqg9MYBw7XpU8HGzFWk3pec36hJuYATYZhpJeSZpzkhkdJ/QADuGFIJVq5i
 YNCwfWyhmMyeoEqKiJ1ae9DXD3sYNXyFFXWxBXbeZJQbhPZbgGY6jTc9PljNxew/i9+JYUJsJ
 /N+qNaeQE5kL4tMgJ280Uk4AQb/FVCYjZRugJPTpleaZPEm6aw+nDyHqR4XFBE/XeH/wgN9hp
 J5YdvCOH3LIFb9LcOh3AMdizWtT09XM6wB1QqkCdlLBD88d6b39idfEbwvtyXvVt8Ky3eRzwg
 lVcKB830X6Ux1RGva4NNx16PUkIYzZxPFiilu8FkSCB4z0Xni4SeasX/+QOp4oEO11eTWR3se
 8Gamji0pMJ0eWqGLaa5HQzArhMe+HWVPayxBhz25e1KrdpRJ3/xLNSxeKJ2WCAqoR4fhoBO1C
 8BQMU9of8kxt28iTlDdvJRUsDOglxbnQdA7VJd1fmphvU1gX6RKEKaizfUEQyZiigE6NO6ZU+
 VA/f7QGeDiEZdLQIyjhY6hhp1Y2bTypjxthp55mOsx9J11D6TUCUJ55PSUTZ/5ZymNkr+Yvgu
 itfZohCgkwLHOucc9E6o0qeIOCv3VZUKP1BddS6Ad1E8JRD3d2S4eWm6CmwaP6557CGqa4HUb
 YniU8kzGXOdKDVPXvq+TE5tLoxj5mloVdNVlGMrV4stl0ua6iT1KdlIGssAfWPIsL3Usofgdx
 hEWn2lRDE/0PXeSa1e+S9jEiRZhc0XEXZWGnhUVxkdeVMg29K5J5sOuYBqyg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 12 Nov 2019, Emily Shaffer wrote:

> I'm still really interested in participating on a mentors list like
> this; can we set one up?

I would subscribe immediately to a Git mentors' mailing list.

Thanks for bumping this,
Dscho
