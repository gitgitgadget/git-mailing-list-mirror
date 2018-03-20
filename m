Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358651F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCTQJK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:09:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:35767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeCTQJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:09:06 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikE1-1eSIWF2JLx-00cwgW; Tue, 20
 Mar 2018 17:08:58 +0100
Date:   Tue, 20 Mar 2018 17:08:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] rebase --keep-empty: always use interactive
 rebase
In-Reply-To: <20180320111057.23862-4-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803201707560.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180314111127.14217-1-phillip.wood@talktalk.net> <20180320111057.23862-1-phillip.wood@talktalk.net> <20180320111057.23862-4-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:H6qZ66Qrf91No57XmIB6EvVsn4ZtJuYs5Hy2hd7RqHhQYN+i4TW
 TPNr7/UrMtLmdJlK5Ax7sqrmCOv5CQQ/nUVLdi7bRG8jcPZpQnrXiucMw9bFgysqrlrT6+J
 /ZlVsZNwG00PSQmmc8e0YNx+0CeznImMxhgtAvA+hOxjqtRmQskq0a9PyN97iN1TcPye6Oy
 Um471LeDvSqWtQOGCX5+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YpSqPrnOkCk=:4poq3zO6duZLMTUjBossQE
 jSnOl2typiRtISJ1bcqArkejn3HQJZZCja21M3TfdbCg8GWQXypiatRIN7sHbuAUaaiJHw+Kk
 NYV2BUXiwc7nENpOvFgiDSNvVuJ9mDEU3ustwSEBuvHYhF3FOuWEkxezrKP5yAJD04nwU+nr5
 AsHpG5IcGyRakJ8DW6fmjEaCtPcW5o0BZQY7W0egjb/eUXppYjqH2DMC9Vt8Qi27kF+ODA3mC
 P+HkuT3CIrySF6hFZH87xntpwECnm+Y04vb+6/OUaegO/JTP0ShOQI0vAy+sfjaIGyS/h/xJ1
 tr4exUO23N4/NcyjjuxljFp5FYbqpJJs2gEPQM3CrNgBw22OlVPOON9OEEoN6JXZwFFWm8AnF
 qL/po08vDb2/brsp4wvLiMUf53E4AFcDwTxHdvElnQFjgX9IRuf3jTqRF9oT8TU1wmgxSmIaD
 duMvToKYF7zwgTMGWlgutTQRuz16TOEUTuStGROsISg70wF2t9cROPFI89hgpe+D92akvAdCi
 gCoGxvztg+Pnn/tTrc1n8QmRupBcmrfBXLqkbAfQg4BUrDo7f/uLK2jE+OjAmJdjp/Of4jM6U
 oM7V6sfBnBFliscZJb0qLgayS5tQz1hZRtak3xUQPFUmCZOTxINNw6ysZqTKDwxwk9NATkTwN
 JMaJH9Tpkzpq4Oa2Bi+eouSw9q2FObeBzHdmcReoGJ3UbcLKoB6HKFxfL52woWUIW9YuJz91A
 Wbv2vb9RVL2YoMCXc0AD9VGna2y9vwsaDM1Ag+krDoBsFPdZvfLCDwYH6kASkfXoEnqyK0C1W
 BveUBbUI30JqNG71N68KID5edfRo1u0SjjdMSwYvrI8orH/OdE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 20 Mar 2018, Phillip Wood wrote:

>  git-rebase--am.sh                 | 79 ++++++++++++++++-----------------------

Those are a lot of changes, but pretty much all of it is a change in
indentation.

All three patches look good to me.

Thanks,
Dscho
