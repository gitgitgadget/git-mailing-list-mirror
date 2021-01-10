Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD201C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831172388C
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbhAJMEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 07:04:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:50641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAJMEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 07:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610280174;
        bh=Gw4wdHoiDePsJV4JExF1IbS0nCOr0Fv2aIdeSybJW54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gwpNOgOThmChvPzo7AjmJoLpoAQEc23jprTvQ6TO3+lSlySYG+4D2WD4/GaS4oR78
         pK+juWIKWjc14sK5ryZvEtq7/ysrUlOM1w+YXFl3K/INPBI6n3M5nvVfTcstJzRiAw
         DVzzmDZOXrdsE4S8R1OmDZYOYdGdMqKbELJ0dp8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.250.66] ([213.196.212.28]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1kFHuc0XsK-00lTR6; Sun, 10
 Jan 2021 13:02:54 +0100
Date:   Sun, 10 Jan 2021 13:02:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
In-Reply-To: <xmqq8s93i506.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101101301280.56@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet> <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet> <87wnwordzh.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet> <xmqqft3cl9rw.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
 <xmqq8s93i506.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ks9fZi7gjy60DTk0FkLScyf+8jEDVdII8YmHv+bqL3GopNiGG8B
 U0AeLavza6T7oebv8f6weLPYNHK9ZbmLNRTupfrjWO288ED9aLDl/VKljHEl1YWORiQB7cC
 okN1Ier+iFXpke0MuTH4uzlghtz6fCF9+Ws0+YaZagOwes5G5P2/wpZggNWxl1vj+CzSSly
 KzQfVF+GFis8PHOaGTBsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j0CUKH+7zuI=:OUl1XVrL+OmSPM/2euWu/1
 LlkgzI32csXcKp0ljmDqgm1gsx98prvE6hOxN5W9b2hT83s4XFV0zi1hF1d70jjEARKRefptt
 XQrJBcmZejhtC9LC5B0s8EGL67t0h/ef6JjMA9pPRRJNh+bUR5WLOqmp/aAfxbKgf46nZF8MZ
 K8WN2h+uNMUprITsaalFDI+V41P0Fqfn7DTBXBZyrqf+hfUkKXIrfSV/Aq84/J+wYIR8iakE2
 wV0pyFu1lsSN8lk7Hh8PtdgJXoBlpY374eVYSvvzFQKbrNBTZp4DqFf5t8qJPP3OHgN8lArqR
 jSxdkCaEKz+318klM1miJPLOB9EIgLtDuraFl1zo2x0jzXffMfW/+d8CdJJHKfLXXPtIcvIqC
 JxiyBXYkHI8A2UV6zJEA4XWVyq2u9Ar+8hOUQI6/6T+QqVPxqjIbuSYpWutflCPJI/NIdkR9J
 P6covg9o0R4NfWCzhi4+3p5NIcpkn4wd9bk5HZeZLLyhUF1lcNDUNTJpcfb8fjpZlUOHWCcvy
 eysAhjxdZ1a5/gLhfAjAG7AjQzP2l1QfxwWY2Ss2Uie+Ot/9lUB0KKxW5fBxHcMLnsr7/bw/o
 4rPPzuwAaH2h+rZ6pR/WobYyPu7ip+AFrxl5QwO5xFl+PefT4QL0gMhlAzW/aGK+QqSYNSEs5
 1jVPqokIC86v5/7467QWmyhlQRnhNpQKGLrQOuSQjgrjkrpVWaq4X0RaxQa2MEdga5WYppkVT
 PRVh0wfeAoxUpcjtOYvwNfPU+57bOHDjNuTqX88i3jD+CWO2PnoHq/n2jMEJ7tOdGvMf5c+Gg
 dGPV8fJIGkQnS7Up761agdO8fAvesVm87hyYaVVdN/sOX+vTnuvtud+/kGydL+3IzAuDrWECO
 ZYCc3/4NNGQSWgIjb+s+EqS5oUr68cnIBs/utlP6E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> One attribute of a quality patch is that it is CC'ed to the right
> people and at the right time.

That's like saying that a quality guest in my house is one who does not
have to ask where the bathroom is.

I want the Git project to be more inviting than that.

Ciao,
Dscho
