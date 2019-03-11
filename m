Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E3020248
	for <e@80x24.org>; Mon, 11 Mar 2019 18:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCKSlH (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:41:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:37071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCKSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 14:41:07 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN748-1hA1Yc2jd2-006hS7; Mon, 11
 Mar 2019 19:41:02 +0100
Date:   Mon, 11 Mar 2019 19:40:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/rebase-deprecate-preserve-merges, was Re: What's cooking in
 git.git (Mar 2019, #03; Mon, 11)
In-Reply-To: <xmqq8sxlkcba.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903111939540.41@tvgsbejvaqbjf.bet>
References: <xmqq8sxlkcba.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BBpOWPBu5/fkiZBWJmPP+8YW+HwoZKX3Nrfqa6jibhpTJBbnp/E
 yIaXkQlV2HCHIXulBtjh5Aib2GUvfR0+zRi4AJ9Ny+SAbBbmO6YmtG8gjb3Lp90YyS8sGFG
 IwikO3db8fDAJkr6ZtwibS8YaitTIKkeFeIKXBFg9NjUcy5A6wCNlK1ii5i5NRMoBUZ1rB3
 R4chNPJDyE7+w2akFr48w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DYmrRp5530Q=:SlxauAGSvX1IMP2faM+AoJ
 69Rc+UBd1DTNCveNJa75msl2rKHD3/2Nnw5FS6e+/vnJXT1a0maFMxFrEVL/JxamqqSUGhFiK
 ERfa4lkqcFxTMuNt2PFFccQOmjfCMqAucUHQtBbqZ0ifzry3v0aWq9+yDKbv66k7j1s3MXJWL
 FLMlvx0Pm+l6ZSSfCEtACgg3oo6KR9y+iOvP7ZsjG6ZPgCTTXXr/lnN1yFQx8EQpRn5j7nlvw
 wFQkhsqjb0BePYMutNDfyMxWdYBauSK5SdRpS7GXlrU6bO1x/6WlgyLZDpfV2/UwFDjxCWo4q
 /LQCBK0o4O7j3bf9aOB4StZ8g392TMBZkrIF3jVEyYGV1XXshZCkONWRBJWF7fLwLHAtUkbrL
 499fUoNMdbfHofGlsRwPQIpMJgZGoDanF6z6RCFciRHceFnPrmkhZuaLNESwlhI8Ogg9k6icu
 ti6CvJgA15G5yv1N9Kn/f6VqmCGeN4caOXhu6fcq7E4/FVQJsw2vNsZdYwloN5/elqecJej3u
 piPRuokPz8h3RugqNwqPa9x2wl/foe1maykJaWW84Z0d+zCZOhPclR1cZkS+m7Iucn3tMQFun
 Z0Dn4K2BnpiHemQeIS2ceqyUWtM7I57VTWedDqkZBnV/4ZT0S5HoE09uc8IvxIE/m1tv3hUPj
 vNtob018A+9HWwKGmCBpcraoD+ukjLDyLjgH0a+YAMrOjeWnjnBBNOZs4OwrXPrVPOXw1hG9b
 S5/seEuQ9QJHAmwJ6bN/SAxbTyKPYG5L/S2xfGwnQcywHuiOHurxsfzqI1+nzHN6oyiQriOyH
 erosUuYPUXCqb2ydckzR4M5ShuvRE4ANuftzXrHjDSS2E1A4JXO4nj0sQHc6csj6w+VS7P0Fc
 1Jl5K5U5SV9ofzgK//Bv7JPFUsWGaWTuuGgSmjEcj2e8Q0fF5WD6murmf7dCYREI8a6HTEDMN
 vnojcCc6wog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Mar 2019, Junio C Hamano wrote:

> * js/rebase-deprecate-preserve-merges (2019-03-08) 1 commit
>  - rebase: deprecate --preserve-merges
> 
>  "git rebase --rebase-merges" replaces its old "--preserve-merges"
>  option; the latter is now marked as deprecated.
> 
>  Will merge to 'next'.

There were two good suggestions that I still want to address. v2 should be
hitting the list soon.

Thanks,
Dscho
