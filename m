Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A804920964
	for <e@80x24.org>; Tue,  4 Apr 2017 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbdDDWqb (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 18:46:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:61458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753352AbdDDWqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 18:46:30 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5tl-1cayc30P8f-00YTFU; Wed, 05
 Apr 2017 00:46:18 +0200
Date:   Wed, 5 Apr 2017 00:46:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
In-Reply-To: <20170404165321.GC189807@google.com>
Message-ID: <alpine.DEB.2.20.1704050043370.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com> <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net> <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox> <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com> <20170404165321.GC189807@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5iVapVol8+ShLIr36jTstvWsqhoERfUWwJvuFI1kOr8gBg5MfaA
 Sum/6GyC3vw392520aj1RAExfH5XhFxCL+2O0gTaWLeXOH4ZYBHMnLBSV63W915xskRNrma
 YDkhaSsQQm6C/huVemPsSd44bHlkQM5RzPSZmjbeXpgBptkcHoFRQ4ddjSmIMoPu0n5lbNK
 43a6WzKALjGHcpc4omhbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RkWJhDgDyRk=:NYZZp9KmRykU9iWtytN03c
 TY4KWn76qH522gUxk4A3KJGolooTW66zp95H9/sldt3m7kNMpGTPER2nFElHNRiqLeyjRBCBI
 W3JYtkvOsOzpYXd9XPEWfKsmGlBXR30V2CeSY6DJha5lB8qChcDKfZfk6Sa+aaUacQOk+0Jsz
 EYtT33ZZT65bwQWdp/m1JOrmBTP3S6oE+nMr5c0Ol51U3oCjad6wkVVUPHl9vDGibvRhVn07L
 vxR1q5akZsozxf+XyIOxfUXkKuPKxCGCsO5YmWDJ9Bu43M1joHkeIKHPhagCPhDfGrKoY3u4K
 lBsAX7cSh5t8qwfUfsTlwfF3UHNnes+WYAZ5jI/shtZ/zYmrpuBjHElrHVDq+WMwMuxoBeZ9L
 UFytboPPEVlyVRopga5l8MahunRRX3zsI+ZXKdUBW9mgByUd88hHxfnhHQLs+J0ZNFojyZ+/F
 lkQWBrC3cMhVJ38KMPFCG4qL5vtOA6Z9BI/dElrMQ1j7NjvFqhnzMhqMb1gYcsbZ4LlHPekG7
 F3iM/dEIMuisAyfa61aYAQ02P+yXu7tYdVvLIzdoWazM1At9oX04LUHR3dTK6NyKdHChK7bjw
 JXiZcc6J8jNqzfDBJjbz5UwPHm5JipYi0qJ+NhD2gIxkw9dNgqdKznVNkGS15QVSbf68ATCcU
 FCwDPih5rEskwn8G5cOZztfmMXgOFaqFhDbF1SD0t14ryOgCXVwLjrKCtHHLX/sJbMmTXruL1
 w9ZTLk+n/r6chvy+P0lYmiaciytM9bgSEdHzxRf/9Bu4GicRyGExr4UHS+3SK6s4diWUo02vu
 eRmH7Nf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 4 Apr 2017, Brandon Williams wrote:

> I'm all for seeing a patch like this applied.  I agree that we can't
> expect the world to be running the most up-to-date version of curl but
> we should be able to select some "oldest" version we will support which
> can be bumped up every couple of years.  
> 
> I mean, ensuring that you are running with an up-to-date version of curl
> is really important when it comes to all of the security fixes that have
> been made in each revision.

I am not in the business of dictating to others what software they have to
run. I am in the business of maintaining Git for Windows. And part of that
job is to drag along code that is maybe not the most elegant, but works.

The patch in question resolves such a wart. Sure, it would be a cleanup.
Is it a huge maintenance burden to keep those few #ifdef's, though?
Absolutely not.

Ciao,
Johannes
