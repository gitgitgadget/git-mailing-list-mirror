Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214441F404
	for <e@80x24.org>; Wed,  7 Mar 2018 12:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeCGMeq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 07:34:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:35353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeCGMep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 07:34:45 -0500
Received: from [172.16.5.73] ([84.88.84.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQhyf-1fGKS50A9N-00U2mx; Wed, 07
 Mar 2018 13:34:40 +0100
Date:   Wed, 7 Mar 2018 13:34:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Dan Jacques <dnj@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
In-Reply-To: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/O8mSbbRONHgxAExvnjl08ZcLC20Yo1Q57MUvtn1a0Tv232hlXa
 G4SO7MYDjQ2nhbbjhEDnpaDG4drYX9EnqsyrDSb1W4aPim7hHKNaCWVuH8MwlZHbfzoNjg9
 ktfzsbHwSUzsUh44ooTQbTYel0gJq0ypl2l1UA673fcwnnlGdRcjohMwAdACZ6/X+7JL2X6
 io5AHI92d+kp/3lyjoFRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TRaclOdFVKg=:nHIoNEz0w3SlDS/MVY/2+t
 jXNPNUVgOz9GtATJl3j1S49EG0DeOMVjQyNejFsJ8PlS27RHm9u2vynWp/8Vmzj+eIAI7Xnxt
 ecigMA+OFMb0urJAuhKanFxvXTk9HKKmTc0fk/3bPpVHG4tTO4IOlGwjhOVuvaUpZEBhLpnLe
 EOjo4TcyUZxb8hyVt1rrMBx5TKQpjm3/Bhp48KQDr0uY5iJkzq/gd1fYTXCB1Oq/Wv+kGrxGX
 sq2iU/aseAR32HWxvmiSTeaqwJFWF480xrEc+bdSOQBCCEGbr8i1C+7eLXGshl1XgtFjrMBKV
 R+30EWnuqP+h/99+N1galW34I/kgLqUsUdEfGThw10BP11AtLp964Ej+jVC2gQ/spQSv28lJt
 I83Rrc85VP+FUZHvrONbUEwztejDJt7vg+nCi0CREDcS3pq/KoIXrJbIeBiRfW3ITypvP1WLJ
 FnDc+sL6XM60WFoFs2MuSVtM/v5wDzgXuVIvu/jW5sYWG6PepGD+ZArGSunSYBYePImkhVFSu
 CIL/gWSTZCgzPlUVFnfBDH1j3tMBIG+D6fFf6fcyduLUqbWqHPpGPrPMeZFzayjcXOGWLUIPl
 kkPCVb4w44QsaoOtAu5OpiexaDxYaBKvawtn0rNUTmm/e+SbVEnq59MldZp8PJah2lgRh5O+s
 PEpkyAiwl/VRwZw9H1zYFTl7fhx4Snn9n73oHYjI1+R7aK2I5k3i0XpU9W+Vjgo+xDSiVp2Zt
 +1E1bSu46fMAKOl6cvh5biVPcsLdXqCvy9vk35dqFYxhIc0Q3rMbq5yAOaL9a8B5YdqkWeXAC
 oAL3/DWBxfI7TBAxilqkl3IX9mxCWYFR5JchNRGSrNWnAx2V8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dan,

On Tue, 6 Mar 2018, Junio C Hamano wrote:

> * dj/runtime-prefix (2017-12-05) 4 commits
>  . exec_cmd: RUNTIME_PREFIX on some POSIX systems
>  . Makefile: add Perl runtime prefix support
>  . Makefile: add support for "perllibdir"
>  . Makefile: generate Perl header from template file
> 
>  A build-time option has been added to allow Git to be told to refer
>  to its associated files relative to the main binary, in the same
>  way that has been possible on Windows for quite some time, for
>  Linux, BSDs and Darwin.
> 
>  Perhaps it is about time to reboot the effort?

You probably missed this in the huge "What's cooking" mail. Are you game?

Ciao,
Johannes
