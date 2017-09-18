Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86462047F
	for <e@80x24.org>; Mon, 18 Sep 2017 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbdIROlp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 10:41:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:50845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754600AbdIROlo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 10:41:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmwpk-1dCtnE2NcS-00h76z; Mon, 18
 Sep 2017 16:41:40 +0200
Date:   Mon, 18 Sep 2017 16:41:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709181637420.219280@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com> <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox> <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hne/Y1CEXgXRup6svU1GIGv/ReKsO9CdL3vk3dJirSdl5GlknUa
 0XXyormFdDYh9r+8YskN28gXheJY1+kdOZB8Rd9mMOZigtAe0QlU6SubxryjAztd5SAFH0U
 Wie1Re/QT5Wzpx29AS57wG2s+Xvf+ejZJxiowHtHvWj9tbMp7Kdvjb7LXeIuBsE3+qvYtEx
 8LOxIte55sn8Kasflxprg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uq72sgCONig=:t8jJ1iWK8l5liLWYiCcfFJ
 ugxIp3RcQmBkC6mmiwca2fTvmXW0IcsH1m/ZJyPtolNBKGPASxw0dNP9FpYM1rMi6X7d3bvNr
 PTFUd9iQm/9yd9+BwkX6y8vtV47Wuz8vd/2MFxkq7swoKqoOO3xfjusfZFDjsG2mbil6Lubrq
 vbHjIjgGXV0KZeLMOndPamVf3IB1pIww0XTd6Tdgw5xyB6z8rGdOLAEzOtvaXXZcviuYi667B
 bUkteYvpY5PMQ5+xLc0ygFoN67J+zdJXLCX7V/opGj1+W3xrNLkptw5/msmL8OQoVnGCaHyUJ
 fChNEjnW1mxvzTFcKehtSV0eJV4MZU6Jj5aEG1uP7+BnYrS4GaACh4dWVmg4iyuJ6fJCBFxke
 oMQ2ET2CWB1v5OVlTJm07B2gNb3DvvzdSMiwZ2nhh7OZFanPxyaBioB8pnhqhV/s2X+k6m97B
 fZu/lxaxe0NkLuZAYnPDDTTS5bFLS7q7xIJn09uTS62VKam/xkgzoKEdatFVcwJdu0IKi80dR
 4KdX3PVDOjkZMNAUnqGge1fJ+wK7ugEqYgo/I97gyEDQXJr0AHorU2DZeDu/rkZASIhq6zpn2
 pteroLKF7YNcJjOYpeFVlQAHpg8FZXWhxvyQfDGOD2ekHaOLmrWj3wAtEgBrFxm2GsmTK+Kx8
 tFdFRZttnv4Nfmz+5Lq9OT3mZUcARYvw5rWKXOFssCJ7K3w7yXGQ66I86VTgiYbDJk1LC1A7g
 iqKiJ/P14iWM925qK4QlthH2i30X9D3fGVWLwhBC7j+5mGj2qIDEvH68QS0MyaJT/UILFXgZz
 Kci0pOdvkJ22DCixojwxxLKhhMZ4thFx4fbVDTTfr5rFEC+jXc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 16 Sep 2017, Junio C Hamano wrote:

> And as you alluded to, we may need to see if we can help making it
> easier to do the latter when needed.

That mistakes it for "Someone Else's Problem".

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That's what you are buying into by having these "What's cooking" mails
> > that are in no usable way connected to the original threads.
> 
> For the above reason, I do not think this is a particularly useful
> stance to take.

I agree, but this is the process you chose to use.

> Do you have a concrete suggestion to make these individual entries more
> helpful for people who may want go back to the original thread in doing
> so?  In-reply-to: or References: fields of the "What's cooking" report
> would not help.  I often have the message IDs that made/helped me make
> these individual comments in the description; they alone would not react
> to mouse clicks, though.

Oh gawd, not even more stuff piled onto the mail format. Please stop.

> Having said that, I'd expect that individual contributors have past
> messages pertaining to the smaller numbers of their own topics in flight
> in their mailbox than the project wide "What's cooking" report covers,
> so perhaps an affort to devise such a mechanism may result in an
> over-engineering waste nobody finds useful.  I dunno.

I frequently find myself putting off that What's cooking mail because it
simply takes too long to study.

It probably tries to serve too many purposes at the same time, and thereby
none.

In the same vein as "to a hammer, everything looks like a nail": when it
comes to project management, a dedicated tool will always beat a
general-purpose mailing list.

Ciao,
Dscho
