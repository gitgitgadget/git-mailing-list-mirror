Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281782093C
	for <e@80x24.org>; Fri, 13 Jan 2017 15:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbdAMPV6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 10:21:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:57764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdAMPV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 10:21:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSx9-1cQhA72Aax-0032im; Fri, 13
 Jan 2017 16:21:40 +0100
Date:   Fri, 13 Jan 2017 16:21:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Pat Pannuto <pat.pannuto@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
In-Reply-To: <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701131621170.3469@virtualbox>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com> <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org> <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com> <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com> <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WVN9F14KYb056uIHT99lSoTFtVi9LG19tjm43XgORblFMh7Mmsa
 OqM6ltcKdepNO13+U7V1dVFSfqdEwLWAFbdWAb+IlETjck3jQNIUxf5PGrvkKiXT5FkeBdW
 RuN2gz0S83UaKiwzvnZFbF5r8+TiNbSVI1b00434ZJ4C8sa/aaP06SIwKQWP4jnZRbVjH9m
 Ot+kFTgbXB6HK2RgB301Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wponCLr2RPg=:t3yqfN7QBuNDhvoUgspNsv
 hb6hW9kaJO+8mtCam5x71i/co/sZw7br0v+F9nWPigrCXm2ptcV4hBgpQOnY+a3B7zzxXNkJ9
 JO6gBXhENfMNChS8QeuLeaWg1AGjpcu/iUrU1eQWBinpqLV+yLU8Z+ntLqGH4fT14YttMW7GH
 zZh004FYqEtwue8AvN77lrnIwhnRmlk0vNWXUnKa9VVNz3VztLarSCUFL6Lj6VchRGgVr5RZG
 EpQVroQ0962Fk766yJ46IwG6KcGlvXhQHyCaxBVtcz4VfRB0sKUDSrfMQ3dwGkwVV7KVuR9aV
 vLNp4yjuqxOA9XVnW6ntKq1sjbViQyeIeikMK9ASyUoE4FUZqZqKizLAyEC2EsujngzM/D8pb
 I6sXIV+cRQx+clMwIp18V7M3U+qqTaPsEGRMZb/kgiTksmFIF9JkCGSgpbrmKGfdDEAbMjOT1
 hlWw+9A4Mp7P8fH9K5Jd43lCW1Jp0LpM/NUGwnd1kKwUaaxkstqhmMefyunsMQ6s6rDR5GyAC
 kbdADGd0ZFSDvDd3l7XnL591NGfWF/EQQafI9peyoYUSIopZb+aZJ9e4Z3+K8EQa68BPnyLjH
 Ek5XnOVEXca0EhFvB0+o1J2QnmzWAfVkD6PilLIVhic2PaeLXmSe4OCIrnvbE4+2ZNYVNS19l
 +CDc0Gkc1djc47KE0nsEB3TnktYEXF9Ji9jTS701KOE0ItP3UgWYPF8PM7e+7JzTBNpoBd0fK
 5aYItpvB2Akt2BKf3Xa5pf55e3KlF2s6IejdJm0B/gLysdlVan7iWMLEfn1PBbrghYbvcVhdr
 kItqUab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pat,

On Thu, 12 Jan 2017, Pat Pannuto wrote:

> You may still want the 1/2 patch in this series, just to make things
> internally consistent with "-w" vs "use warnings;" inside git's perl
> scripts.

Yes, I like that patch.

Ciao,
Johannes
