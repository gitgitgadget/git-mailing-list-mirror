Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2BB1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbdARMdw (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:33:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:52099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbdARMdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:33:51 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2Glc-1ckOsT0dXg-00s7jw; Wed, 18
 Jan 2017 13:33:41 +0100
Date:   Wed, 18 Jan 2017 13:33:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
In-Reply-To: <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701181332230.3469@virtualbox>
References: <cover.1483373635.git.johannes.schindelin@gmx.de> <cover.1484668473.git.johannes.schindelin@gmx.de> <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de> <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WGxM1F4/CE/QGAQYZhfdoTEJhkvb4x8H9GOdhztBZI82UQvv399
 y7KDXOGjQm9XuJqRyV901N6NQQej5RJ6eQlMTAyeh6G5xmgl0CqpMsMm20Cnlums1U6cZ7T
 3EGBtN7WTEE4ffdAuqjXhzCMMMsLpeSQgIAPl5Yrta4lLUiB6Y5kAShQpB30xVG5WFoNlWQ
 IITItU9T2Z/eXCvpp6j0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LnBsND+P6EU=:sSuKk3F8Jm24xrbP0cOyaR
 260FE7S2r2Ysa3eQoZXAlSa5wmhSccQIYyqqcDkRDNL7Y85qkEtPDqiRa7fdFK11mpzCzAqX8
 jPD0vPFV1a8tsGnz+9Rb5ZvepAkPjjXK5FBL9XJSwi0AgGO7sfIHfC47j+FeIfPEmb9ES6vsI
 H/OoRnMUP7ZB4imV5LrGVzDMee4Z9yl7qN3CWchz7ANEVdCMfiSXEOKfylFXwmwlYnLNWHu0L
 /zfxHgwxrbB4dVA4LgIAJ6Gf7DzQFCTI8hSvQPd/+3AZuXWWCK1IHxTQX/RbhuL3eDVV/6bCj
 7s6mpSXZJDbaH4nPRuI2RnIhrJaf+EgQ7t1emXNp8dfpw6O/jZhsMImigego+GFk2EVunb93y
 ESQ9ZiCmINgO8MPnPMLrT3BRxEFU+qwAnPCKiyZSYIaDC5q62FNs0pFU/n42pDOT4jtN6EQzL
 Lj1xVbnvp5ZviJW7mLyPKqWK3dW9cVBAl1JL95hXwOSszapuKInOpWtGMxhRIqYsULTuepI3w
 NgLpSiHS5Qpqt6YDc2x4t+zK3CL/Gwv+oWCiio33nRd6gdRjIPv7v3SVISMSj6cA8oCt8E1Wz
 r5PD0kexXFEtLUYyvT51vnIvsMhJWtUvqejxQfsQ9I9BlhYXabeMRrjxxFvJQ0mwre+6utAUP
 l/WQZ5ePKgbb7Wa0rvI2lUrSwXlKOfL6p7hgzP59nkjQiuquDQKs26RSnHEj4rUNbyDFC8b39
 p7n4bxcCvo/jo91aG26s+9Y+8xbSBuUbxotVX8RYIQyQgeQGbWlKTUw+Pgcjo7kKzzTkAtGHS
 pTIVYCtpbNSo7L/9IDT7MJzYaJLDDJ9q/PH9Q07E8VGVfxKFm2oEK3rOH5HzeOtUpYWjK+8R/
 pcCaxCqbar445xrxfeFNm0OBan9jA/+6TSEaIhjUg+6MeYtguKbQo0HHWmSuIZOKiyX0r4PQO
 181xVqcjglSpkp7QG3HcHcEZ2wZyLh/fGbaQEaIwbpVdl6rSeB1Yu5Hw29ZgL0Vaav+CE8LK1
 4b/7c9Hi0A7iajqH8IsxG5LDp66dNje770XJHEhnwPvua9LAlyDQuHAA+WuoKB3ozg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > It served its purpose, but now we have a builtin difftool. Time for the
> > Perl script to enjoy Florida.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> The endgame makes a lot of sense.  Both in the cover letter and in
> the previous patch you talk about having both in the released
> version, so do you want this step to proceed slower than the other
> two?

I did proceed that slowly. Already three Git for Windows versions have
been released with both.

But I submitted this iteration with this patch, so my intent is clearly to
retire the Perl script.

Ciao,
Johannes
