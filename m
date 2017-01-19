Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF9220A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbdASQNv (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:13:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:50825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752811AbdASQN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:13:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tU1-1cJLAx2JAn-00xwBW; Thu, 19
 Jan 2017 17:12:42 +0100
Date:   Thu, 19 Jan 2017 17:12:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <xmqqfukg9o7u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701191711310.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com> <257b4175-9879-7814-5d8d-02050792574d@kdbg.org> <alpine.DEB.2.20.1701161251100.3469@virtualbox> <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net> <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <677a335f-889c-2924-b7bd-93c2b6663175@kdbg.org> <20170116214411.a6wnp66vxydmpmgw@sigill.intra.peff.net> <xmqqo9z5fqdj.fsf@gitster.mtv.corp.google.com> <1aa4a8b0-4bda-edbc-7be8-1ffd9f74eef7@kdbg.org> <xmqqfukg9o7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0nsHYXfSgTctFzfNIdIhjSMXthI/EPDQ9vwiz1CiVIJacvaZmIM
 +5/BZmmOM8waIAz+C+a93CEAiAVBuNVCdTg1Xuggp38jf39tQYbSh3bX1begGP1K30cBkvF
 uFjL7W5fTG1sQZul6vGShtJJnqzCBDvoawh/ENsBDsUGv3EwVx3SSjShEuH3KRhS4B94pcD
 kEmwDbRyLVt4QaaQtZYkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ktQDiVQyG6c=:N2X3L4CgA32iuLpCTqn+NI
 NYXQE0bfIBfctpVNuSVwNEnrvGjohAZHBHAUMqKMbDBT4Mgx1nzVepsSetbuAAGKHJk6mNUXq
 /H0x0kfg5EzCfbQJ5VdX2bPb6yQRNexJai0BFVgHSmh4B9u6jOOV8GYgWCCaCgetGflYPPf2V
 AzSGOcoHtT5uIi3elWkBaMHRuDbgIW6tvFkMHrGquJ1luWU5WjCKKIT3tuk4Zt/LkPO2iiF1Q
 z4m6udVrFAMqfOyxXzWvPAGgsHKhUyxGc6vVETc0CT4ZLJz4tiw2t0YznRnyvvbhlR4votfR1
 lL2bQFqC7CXofohhTgd9WDKpE8kupt+EI8+ZdyYYETnAN4kbQ/pckGJXd7chR2p6B5nu7f2DJ
 Oeyji1S2+iYw1kjvq97+vt0acO6pOdw1eAM6pspPZeeI8DJ/ap7pr9eG8FV3eM33rNj2cDWQU
 oRpIKBQDC5fNpTNxz6/FWhkuCMwfzIbFMQ1Go5ROh4jeRibZ9pupvluAF0DwTAEMD68ZP32PX
 5bzfjHATD30taj2QA3rbRPEgqLju7s/2rrzW3FlvRHjUEd+nNhTxKS+fmtR6MqCpDDJk0Mg30
 HFFJGy9+llJ/xlmbX00P7H9GkrOYDFvluUoUXP4EOfbgnJIyxvi/29JQ0INnIOPxxZ97lK2eO
 Kkpv2gdCWAj0gpeYLaLUAq9NcYq9Vn5H3W/p9OhsqPSd4aLsRUuwfbxYkvDSaVv1V9ZTQq46u
 igdys/o6MZ3qmxK9CfU0YZ5e1W6UsPUJ2PwiQvTQ3HtpbPqeAmSc8j480Po0ofg2kzm83DSx7
 1SvHJUz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Jan 2017, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 17.01.2017 um 20:17 schrieb Junio C Hamano:
> >> So... can we move this forward?
> >
> > I have no objects anymore.
> 
> Alright, thanks.  
> 
> Dscho what's your assessment?

I still think it will be a problem. I'll address that problem when I get
bug reports, to unblock you.

Ciao,
Johannes
