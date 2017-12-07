Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E17620954
	for <e@80x24.org>; Thu,  7 Dec 2017 16:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdLGQP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 11:15:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:58789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdLGQOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 11:14:51 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mcmmn-1eeEgp3aeP-00I0MK; Thu, 07
 Dec 2017 17:14:46 +0100
Date:   Thu, 7 Dec 2017 17:14:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [WIP 04/15] upload-pack: convert to a builtin
In-Reply-To: <xmqqr2s7frga.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712071658120.4318@virtualbox>
References: <20171020171839.4188-1-bmwill@google.com>        <20171204235823.63299-1-bmwill@google.com>        <20171204235823.63299-5-bmwill@google.com> <xmqqr2s7frga.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nDUVwCLkKOu7KTUCrSsL/I/WwWACodEINsBB/jsd0xpjrYsGU6r
 14MmZSSRYzkAHmZejSbQe/FbhVczDNUIqAxMSSguXxo8QldG5oFQvOMnqrP5DijhJ6B4wt8
 Q37O9z1FPBp0bgfQ6GpygDDap+5B54XQgCrl5FTuCUlebcyrO6pRBWDl1HhtL57n3wm+ViT
 X2ORSaeCKiYjDqAoKQW4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MlHaSQP4FIY=:5U4eKeEfkhqXnU6ko/bAgZ
 yQYW0vRojIxv29TFjkqY6lYiF+2tCZITtd+43xpJKi1UqYCMWL0XMxJaruEXkAvThqYN35XvQ
 jOYDnazPw8p9v1SmMTIRboIVp7DaRx5un3OB8R+/WHu7XM7QEE1rsQ50/6CBfFe2xrjs6QZDi
 kgnuf31h/9rd2VaWRLB6sWm3/SDf5Dz9LE/g0GiHvfgZvm90He64BmhGBGqDKo9TBcL88WhOn
 5+kuWILuUUZzMpTaeOLXph40zTzFMFwfyTQjteQKo6yBkirKdgqj695bHyLCn1zseyz3+6c06
 Ty0eU3V6T89J2U/43UjUCKsiUISXDFBu+4ZmIxnqxRNncobOKlXFoxOJtipOEnT4vkXmNRlsh
 pyxRVsYleNaSclzdsw0KH2juR45KVpDg5NXdFUKczkC2p8EWDvqE9Du01mmUWwxxzKPCgvX7d
 SSoHnuDwg+F4+YqF2xVWm/Vhq3O57CPiqEJW0kIB6UuUoLflEYOrJHzExlqxXhnkmOyU6k49F
 zwzMzwysYWAar3GmZ+l6x9FD1OmoYqo2ltY2iZEClSf3Bi4wOhuLBbZ53JwnMhvEhGxWAxErZ
 WdzfqUvqSFyCWtUNM8A4C1ztQmjRM0HxNCChTkeo7qiFJ5iDWKT4gGSdDJ1gKOrb/F7c0PsZT
 fdTTsWvnFPVGSlv+KUuHQe0RU7epwI80SJHw+vMc/HYKf9B98n4BsNRZq1Joltoej6e68WPHE
 /z7QRpFyFmcVNj6SVtti96PPk93Kiqr2eJE2EaYrZMXxXW12nxejY4V63pTjfhtvWa0FYM9UH
 V9H6S/ZjbnzfDsSMKYpbEXnut7SnPWFAhPWK4NVYKQ3qkv1EUg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Dec 2017, Junio C Hamano wrote:

> Brandon Williams <bmwill@google.com> writes:
> 
> > In order to allow for code sharing with the server-side of fetch in
> > protocol-v2 convert upload-pack to be a builtin.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> This looks obvious and straight-forward to a cursory look.
> 
> I vaguely recalled and feared that we on purpose kept this program
> separate from the rest of the system for a reason, but my mailing
> list search is coming up empty.

I only recall that we kept it in the bin/ directory (as opposed to
mlibexec/git-core/) to help with fetching via SSH.

Ciao,
Dscho
