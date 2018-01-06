Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63BC1F406
	for <e@80x24.org>; Sat,  6 Jan 2018 13:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeAFNAA (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 08:00:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:49618 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbeAFM77 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 07:59:59 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwrwO-1evqHj2Jyq-016LwB; Sat, 06
 Jan 2018 13:59:55 +0100
Date:   Sat, 6 Jan 2018 13:59:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
In-Reply-To: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qgpr6C/vP+gFz6sdKoNKqJjT/NW7AqG/+w2lilwWr9tE7pir8B8
 iPlDoTZnoMl2HO2qexq8fql/v+fmYniWMT0EBTbDszPfApxAW8R8smMP5UwuqtBn6NeFjzv
 RLUHNqL9P2K7boxUSI9OrEPUtOEudZ2xD2WUdy4+/7EM6+9UQSYJfr0V5okxMAQOc9BetoH
 74M9o1I3qWSKRbByXn8AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JHYgs7vvv2g=:H95BDAvthRU0ioaVmxEJsI
 PlxWCSekLLQL0YkQ+1tJ3bIQblSBTZVg1kcdF5ln4Q0eFkMeNAnZ7nWIc0DjECr93L81n2Hmd
 M74+WCAyIzK92isktDOO4KSt0Pl3z2AZQ3zqyPPPytDy0GR1fhGukVqj4n1+azM7UZdTTzxeS
 QksdfrSarDQEv084ckvtEToOZGKGJ0F3xcrHGR2d8/bfJHKiClKzJizt6K+N7XAa0nLu8gqkD
 V41Puu784LnhyJSjxzukBcfYyjmrDoZ06lMO0JVevbyjEmR0kX5IUMPsbr/J1VHi4TeZRKNyv
 /8MHXRa50DA9Vsi02g+Iu6rgecpPePEn9qh6ExieDHgNSzDYjf3sG62oPGsIgLmKlOnOmUEDd
 JZJwlawjlaj7IhrdokUe7eaBr0HeIhWwOeuzv+bYFUoegDHcbjYxrKHhkILTQxU1ITnX9SFi0
 HdYE3qs7xv+O3aMF7aBZdtPe5OxZVsN73fGH/eIBqyn6M0RKsWCfSdaz5FGhW+RgpUYuJzWOd
 WOT9ulTxwpZZomP2N2HScgzmYSxmD/EMzRd9fz9mwGcRKHapMOhOHAfFNYZfiFExhwhrzO42n
 57M5SoyI4It+qutVWNA/0YK8l7tie1QVJWKZPJEXCXEu32GCcEHkbTezVPLN8ChjnOzufLHBv
 nuxlnXEPtzmU4yhi+AiS7nzIRglU5ofl2UtEjgO0fnfhtGL2cyddTM9TRTlmq+GoYIO3JT6cd
 Qb5roOHapzLaasI9lCmsjaPWux4s1ux+GYKyhHctxu6MzjRniWs+MyAtf7znO77rHZihmGHJu
 0J3FHCPhNKN9tH9j6nwu97POrWbgwrUFWhh4wyhL/h8QdegPQ6Gz9PZIDTLxKv0HSCawrKk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Fri, 5 Jan 2018, Junio C Hamano wrote:

> A release candidate Git v2.16.0-rc1 is now available for testing
> at the usual places.  It is comprised of 455 non-merge commits
> since v2.15.0, contributed by 79 people, 23 of which are new faces.

I rebased Git for Windows' thicket of patch series on top, and I already
got this when running t0021:

	# failed 10 among 26 test(s)
	1..26

It also seems that the v2.16.0-rc1 *without* Git for Windows' patches on
top displays the very same problem: the test suite does *not* pass on
Windows.

As it is, I am not willing to wreck my weekend, so this will have to wait
until Monday (and Git for Windows v2.16.0-rc1 with it).

Ciao,
Johannes
