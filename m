Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8582D20988
	for <e@80x24.org>; Mon, 17 Oct 2016 08:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbcJQI54 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 04:57:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:50109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbcJQI5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 04:57:54 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MB2G8-1c3nVz39jo-00A1MV; Mon, 17 Oct 2016 10:57:51
 +0200
Date:   Mon, 17 Oct 2016 10:57:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
In-Reply-To: <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610171056170.197091@virtualbox>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com> <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Sok9/2jsE3jM/qHDBoqWQ+iqYIlGQjlgBP8IhZ0OKjIF2p5/f6F
 kn3cTD6pOoaIaTJrw2ydgc60gBBxZRGuNat3boQiSiCwKG8v7xCSKlyRLI5RPNoBAj4roPN
 kiuiwTDpVurkZaqhX0iHBdPqkBirQacfVMho7zSi7cQH9UEjCeJrY+Happ+JygK4SdSZ38t
 Bgvdg6bnEW8MGzKoTJ78A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:30uOqvKEFb0=:7Jf/egSrPgqtG++Qm0dXnD
 SPOj95+WiQlQwfIAomHDNcNGsaudJqlIlQLnIcb/x7oFibTY3eFb/j0MBHVyQ7GDSJEJ9fDPp
 vqdL0InDTQWK02mmEcuFmyliWPD56YSqRKnot8BfVwg5e4JjwK+CXd1iZUsAl5yQi4eIypPOl
 3qKp1SfjvwU8yhu+f6exw0sCddsAlAzVzngGijafG6ozPMZi/XicQCMRQu9bRin1f4YewWGU7
 0PPyXKti7GWXMZXXxVVnA3PnfT2HsFt/SEGQdTHL633JTEInSnLiuUokEzpAO/j4wEERu7ZKG
 +njXrQahXVcg+B8QEFXZLHp++C0w6/RGakRyzGH8HD4xMrilC2pONPvVP2IBc0yaVpCk/kSQ5
 NCiQaF+0xtnj2GmuCLOFh6sG3ZY+nKKgz32jjWLhTwf+J67T1oNoawJQkiPBo4KQeXVaeRASA
 DpIEBjhTc4yO6l49jt8rNl5o5XvI0XTV6OhfhH21UfBA1o/EEqNdHblBrq0rqIpY478jlWryA
 qb3QkKW9pUsHibsdbjbVU9MPwTkZR6BcoaTvorJq8122bWnF6Pil0yc67KIHWvqUez9cmfsdI
 sd3ORgP+XWgY0/gsYiru+eGNFHBLmqSM0KRUkUGW8sP9HUavhw5rLPwVHmMR8TXuFFucc/rVn
 brjuG6pnfNaoJR412NTJziJnqnQqRazk6r/JVblpxixKnfiQ/7svq7yv9Lra5WsxiiOO+z0hi
 iyhfKl7e6lUHK0UAjV9ztrgqIxWd8fg8/ydmM1i1msvxSAWy/YxjPu0Poh18T3YMynjc1j/5l
 L9Asde0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sun, 16 Oct 2016, Stefan Beller wrote:

> Conceptually I would prefer if we had a single switch that indicates a
> case insensitive FS.

AFAIU Lars' use case is where the FS is *case sensitive*, but he still
needs the .gitattributes to be *case insensitive* because that file
originates from a developer with such a file system.

Otherwise he would simply tack onto the core.ignoreCase flag.

Ciao,
Dscho
