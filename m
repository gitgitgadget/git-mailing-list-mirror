Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C4F21841
	for <e@80x24.org>; Wed,  2 May 2018 06:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEBGx3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 02:53:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:35029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeEBGx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 02:53:28 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDn8s-1f8ocn07PK-00HAX5; Wed, 02
 May 2018 08:53:23 +0200
Date:   Wed, 2 May 2018 08:53:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
In-Reply-To: <xmqqr2muwvvq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805020850400.73@tvgsbejvaqbjf.bet>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com> <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805011439580.79@tvgsbejvaqbjf.bet> <xmqqr2muwvvq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h4i/HsXbkhXjmFPA4IeMxwHffPSYZSRqx6Z7Fua5HeJIphFzg/z
 28/WcQXVPJruCrDmC8/r8twvshMRboJxDN2EHk1/mEQc77FhXtFtfHia9KpWlplkzSr8kaY
 wyfYntI0PuSXdao4LU7UhJ59ob2ZFZnoM+EeF+HsLrzWNPsM3v+j3l/yMBfBVOqwXESKvux
 hXmtRIMgK9gDW85goYuLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G/fupMLNi74=:4ZyVuFHJta/Td4emLk9YLh
 vK0jeFWAcdK5X7JiQvCeqSiptzQk3Esq1DdTaF8nHLWOe6N5HD90J/vVTythPDLVzYNYoJ3x7
 LsNoF3KRLIZGeBC94CezktcKIaWRxNFQ2/YIAndR29poLIfVGWwoBZoEsElVEamOIkGtJb9yr
 azfu1MHXgnMXbCWZarmL7LhP9K0KJNwHOdtnPWcuELRj4DAcALPi2ZcqFSHf4mnR/4YtuXMxL
 u/RDeaGxAxSWted5+6CcYSEbyuZB4eraFcZQcyTDVJyldawmQnjj4rMGLpxozU2pbmb+ZY8bK
 EFb0phpiGjmgr2F5CszgNCOAYDY+Jfpi090lOM7/R1e9nBjjtr5UjddguZ9MEjqIVNRWMprTu
 8aagLoWfyJJ5GYkVKb2NHyAgX8uF73LxCP3t1XxDAkGW3Qt7bsj9c2VGfkqH9VWITqyKk2aWq
 bdYDjAYSndcZSLJsX9TQ7H+DsUFPxC7yhsJeWU1RZf8PHqNrLWGv6vm/h3Cnh0iyNKelTPgu7
 5wzMAkPKSCaxiB2n2tiMHzPGXu9KFkMF+d1sbV1zwex4V4VkBcRHV1VoWlWZFvuUyqV+BEskP
 CZKiEM007NliIhtK1KYAd+CgpmZNBCpnHpn1vxomfG3F4BB1Qv40kzZwVJon7043uVhvIhBX/
 T+3dcxlW1VLhCIpS7ds1GDUoU1tUFvhFLiVTRhnP9eg93oPl7Uo9v7ig1nGQx8DN6jkkfxnth
 e0JEjSB+BDZYFttd1yU5bmg8ODkterBwq/woDrVbJaSd+nMOzWOW8NsuTnVyYm2a0f9qBT7p6
 Zf4D7iH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 2 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So the problem you found is not a problem with *my* branch, of course, as
> > I did not fork off of ...
> 
> Correct; there is no blame on you with the choice of the base.  It
> was my mistake that I didn't check if the series could be queueable
> on the maintenance track that is one release older than the current
> 'maint'.
> 
> As I wrote elsewhere, for a low-impact and ralatively old issue like
> this, it is OK for a fix to use supporting code that only exists in
> more recent codebase and become unmergeable to anything older than
> the concurrent 'maint' track as of the time when the fix is written.
> Even though it is sometimes nicer if the fix were written to be
> mergeable to codebase near the point where the issue originates, it
> is often not worth doing so if it requires bending backwards to
> refrain from using a newer and more convenient facility.

So do you want me to clean up the backporting branches? I mean, we could
easily fix that bug for the release trains v2.13.x - v2.16.x... Of course
I do not propose to release them *now*, but if you find that another
critical bug fix necessitates maintenance releases anyway, *and* if the
branch ages well in `master`, you could simply merge them at that time.

Ciao,
Dscho
