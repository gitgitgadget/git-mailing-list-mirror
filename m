Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F70620D12
	for <e@80x24.org>; Fri,  2 Jun 2017 10:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFBKMQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 06:12:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:57659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdFBKMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 06:12:15 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUDXS-1dQ7Sg3DcI-00R0KR; Fri, 02
 Jun 2017 12:11:57 +0200
Date:   Fri, 2 Jun 2017 12:11:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: preserve untracked cache, was Re: What's cooking in git.git (Jun
 2017, #01; Thu, 1)
In-Reply-To: <xmqqfufj47oz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706021211300.171564@virtualbox>
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706012052480.3610@virtualbox> <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com> <xmqqfufj47oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vq5ioKi/hlp/5jIzrPfoBAZ2qxkea8Jmk1gUlcDUS8xx16DpBZO
 mMaCDEmkDKiaTfeKkVq5uPMXew9eDb2vk7oZ8LrAesi9s4Z/yX9Al+53KJN6oktcdE6PvRk
 Px5JQTf5TPPb7AOSeONPSchRguXDNWNNNqPwP0BsEXfS4nDZ57pt3qQs4/26xZBl/RpyM7x
 4yCWmOcZZjlbFl1pHdBSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+Ra1KbXG8z4=:Jd7V6Ibh5V9yxamTAPWlIK
 fc+v7UWYLRju3Kv1+casUwcSvUvdB9PYSWdAYAn/mcLUYzLQao4xTHZhWGPoo7KNWoYZ8KMDM
 dnPrJonKhnuwfhmjNOKiiQYfxBpjlRDiFvyr/L1GoBjtMrgkdiYiPOWijfZ1yJIBgj7zsUFGI
 1k2kB8OsIJNbsuHWNVjYxfNpVdI3uwV8RKQMFfxN6mbzagsQ4WjCkjcmKGQcKSfSWmS+zibgl
 U7Zbv/D0J8+LvmuCL5FdK7F6j2cLd4PFO/Qm6SNek+3jhGUkMoz40dDS8R76pQpKv/L7lmvpD
 LPQObpFk2zQAbEidoGU1t16mRyDxtxTvOSq5YzcGMcmZ/D8gGttWo95hyFv2gSRFZ108+YF1+
 8MKOJp6yo4Gv3BVZtM29LwG6sHr9iVOol9KLb72YdheF9g7EFtEGr/iwoXKxpSU9h1KLC4tQs
 7qujW5WmYqfyMFfEtmlQDcs8YpTGEUdsaTD6tS8ZoyQ0xQDmgN4vmFHoq1hHq3xlJkQf4I+CR
 BCQ/ZjCQ1bH+0u2Qa0RzTEeh61gtFEaEg4ZfZNk7Xe7MnN9gME8E0J6ABG0kNklB7bXUcU6yp
 hPDjEIulWg2pbj7OOytaTSEzCIDyyTZ41EtkW0WjNmP40w8W1q3W7UFtyzbnzfFijOjEBKIdT
 MAR2v9Ia+cFPbLQlojNrJgN+sdxWyipfiGmU5M2t7W5SpMbeJTYT7EpETLw5HIJFfi5mD+joc
 78S/LmhNtfbK8VwaWpzQ1TzzJacOzRRo8q4yTuDJxKhsUTlOCn3MRS29+zmoExs4xdb+kXDPh
 AZ1sqx6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Jun 2017, Junio C Hamano wrote:

> Samuel Lijin <sxlijin@gmail.com> writes:
> 
> >> What is holding this topic up? Anything Ben or I can do to move this
> >> closer to `next` or even `master`?
> >
> > It's in `next` right now (3196d093d6).
> 
> Thanks for pinging and checking ;-)  
> 
> I think the topic was merged to 'next' on the 23rd of last month and
> graduated to 'master' in the past few days, together with other
> topics.

Okay. I never saw any "Will merge to" message, so I got worried.

Thanks,
Dscho
