Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962781FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbcLIT2H (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:28:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:64078 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbcLIT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:28:06 -0500
Received: from [192.168.178.43] ([88.70.156.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mh9yT-1c22gi30pF-00MMFd; Fri, 09
 Dec 2016 20:28:01 +0100
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
 <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
 <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com>
 <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <6ee77e7d-b93e-107b-c3fb-519790453b59@gmx.net>
Date:   Fri, 9 Dec 2016 20:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BLIK4OtP8lhJtvbjPpwyofxStBllyhXxB+x/vvD4FyevV2Py/DX
 gW8ytx/V4Vc1mGgklM71z5Wv7YLd6Ab+Q+3I1TXHkBVoBgvCbn4d09lSAnRJnmYhox8nNoT
 YllnZo2IsFltfvOBCWbOPwX2I8oL1zWxZf+SpILoHBNfKW55Q2YRlNCouayVLSe46wYb4Ql
 qIifqa3Jb9hwN75WYWqyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OABoXDFYEak=:6WGS7P1SiBPgjoBHTlbF0e
 PyBHzVMPoGsuHkoUhrTpYtYuWSmfKqQeEH82i57diO0nfdblasgDMrQjFQJIxdnjJJKOAH8Ii
 c8H4XxWVwaM/nOdyC1TFUGnDIZga76CfSyW8zX9T3+T0phvZpIJnGOQXE6GPdjZiW9zipkFjl
 +aPM4hoEXWFm/Pk0SoiWWzPab2CsfSCcGlbS0aiKtm4VX0LYP+XScTdXj56cNFdRMh1H4/+aI
 vGcaknDT2A3IO6vT6MXBl6QCE3r32M6clJ+UfvjtCCBCa3wRRg/MqSNZ9RfkB3IfjeQEeJwj0
 BCI8TDkRM8atJzeUhAxWwGNeyQEXESqz+h68gxB+j+/LeRG630A+sw3wvwcMq1qe+n/S7cH7u
 +41ue20XX+XUNdoFL8GVVN3byfV3zzFQ702vvV7YUDizYKtxhmKjCm+39ybOf9xYx2K3aItn9
 v8gxdqZAmQ539Om6QWKu8rEE7w0O3BdfN9/iP17Y0egkMDJgl3shddxC2e7esNOKJSWKaYLGZ
 78/CDOUyUoNcyBSEOQcCE7U4Qb2axLgsao2epBHltnTfxi4PJCe04obLsRsXYnHAzHyJ3gpq6
 zHDAFPYbGbxhO4JB0CNu9Ga1PxOMgVCcnkEKCzUMyGNEW+/oBjkT4AWBZUiFuVLwCvgSzPnzu
 2FBPNHx8MIdb+WEY58HRg4GTAv57OL7ACKotMldEh6GVj57zA4JFsp3cHZz54Nwb8M0q/xVyg
 bUP1A4/BKuB3yDm8VvqO/iemq4yuALqwF1OEBAjqGW+88wV0rJu/+z7pjm73qqbP+rEvPqUtC
 RL1Rq7j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2016 08:24 PM, Stephan Beyer wrote:
> t3510 also shows another use-case for --quit: the title says it all:
> "cherry-pick --quit" to "cherry-pick --abort"

I should've read what I actually pasted.
I wanted to paste: '--quit keeps HEAD and conflicted index intact'

Sorry for making no sense ;)

> With this additional information, I'd vote to keep --quit/--forget and
> just make it consistent.

Now!

~Stephan
