Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C015E1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbcKVQEy (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 11:04:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:65203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbcKVQEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 11:04:53 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld0fQ-1cZicO0D5s-00iC5n; Tue, 22
 Nov 2016 17:04:20 +0100
Date:   Tue, 22 Nov 2016 17:04:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
In-Reply-To: <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org>
Message-ID: <alpine.DEB.2.20.1611221703170.3746@virtualbox>
References: <cover.1479737858.git.johannes.schindelin@gmx.de> <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de> <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qu0PKJ9HUe6uAE+Pi/ezrgYXzbLVDz8Q4WluSLxiFOxmuhLFAEO
 mv3sFdla13qJ2cy8SuNHBSgX7JA5Ag3ErACV5QKF80E6TS9X5CFMHyVHXtgNhFEk3ywj4h7
 AO5qA0o8cCvhL0zAw9tyzT7TYA3V0AXlYfq6q/FaRoG49Sow9lJo15GuDXG5euB2FLQcc7I
 p3+KmfTAfqx7tzVXOYCUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9+wwjN/3x0s=:aw0hcJLKNPHS0VDKNzP2R8
 Km+ggUS3oSSKwDi5Z7kxh2+04v1aynIO84K/ZxstoD8mXGoM2F5nHuE/ynPPHytOUJUJSspNk
 MKD3Qg7zimnPuXxm70CGkdD148p07yeKEVT/2x4qqs/BrN/bJSA280tFcAeUum+R8ruA0NS2D
 5g1LUCPH0ObmetaR74gi/peg71DN0O+4oUPFl+hz9FNfvCG9DmlSI8Q9pp8xRJXAC4wY1jvHg
 Bp1qU+mRQwQCJHDsSwsuSshxQPsGb+qlQskvig+oqGj6stGYh8cAvKp9KU3ehO46CcnzYvXJj
 NQXih4bw3KQ/opI3yiMe+XWOx+Kmu4S8W4GFDqh4D/JgcYIi9AF3s1ddTudWrInQa3W01iVtr
 KCpOnm/xHtw9MrKDCEiqF0bg0rvL3D6bAqpZi4B2P10NFr75S2mQiKYP2ywey/XnMHTSz76Zz
 WjP5DPpwYZUWz1RXHAf0zLbpPob1U5tOYdnEVT1CtoTsPHFiTwPNYMJleA+VdaBuVvmq2et56
 xY1LaqT+hk7p9YfgF4KzTUflPfrq8Be9h3IX73kbMbEml643stUcfujyazUxgMiDrf0++nsAg
 q9Pi+ztzNXW0Sop9sOM4yVqK4uccCFwZixuI9KbD/LUazvsM6A2HZG3JDPBhkSu7F8pBBC8to
 HmOp8CtzsvrFX6ohjMjQlPlHQ4Ay8TOvlisz4Kz4QwYcnKkDxem6SJSrryV/cJKA8g6KTAfFD
 4zVqRD4sBFm4g0D9+1qVwP6ctxpffIV4JBJRZt2tH1WRVnKcnYjkpticM8uSu5wav+jqjNPCB
 iYjBRSCCf1sygTLhhXfOBqtactz20v7umZI4tSVwinI0NrHVy6VhRr091FJjbxcAYpvTBAIdz
 YzO1145k9nNwUQHd98dKUQO2DcsgWRHV2oPaQnh1W4HA03aQMKRtmeuVtuLOQ8x/Uv9Molx9G
 Twc6C0mQx/0KBdeKpfGsXGRrhgOFIKwta1ZznmrX2T6rsy0O0ywWd9poo4TUeybEdNIph/iOD
 B37TlKV6794AskGyPKGZHPw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 21 Nov 2016, Johannes Sixt wrote:

> Am 21.11.2016 um 15:18 schrieb Johannes Schindelin:
> > -comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
> > -: ${comment_char:=#}
> > +comment_char=$(git config --get core.commentchar 2>/dev/null)
> > +case "$comment_char" in
> > +''|auto)
> > +	comment_char=#
> > +	;;
> > +?)
> > +	;;
> > +*)
> > +	comment_char=$(comment_char | cut -c1)
> 
> comment_char is a command? Did you mean
> 
> 	comment_char=$(echo "$comment_char" | cut -c1)

D'oh.

> It could be written without forking a process:
> 
> 	comment_char=${comment_char%${comment_char#?}}
> 
> (aka "remove from the end what remains after removing the first character")

I was considering this, actually, but it is rather unreadable. Better
rewrite it in C, to begin with.

Thanks,
Dscho
