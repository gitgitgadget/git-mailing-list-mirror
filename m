Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531E2202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 12:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757554AbdKGMOS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 07:14:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:63945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755952AbdKGMOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 07:14:14 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1etNfT2gT0-00hgVZ; Tue, 07
 Nov 2017 13:14:09 +0100
Date:   Tue, 7 Nov 2017 13:13:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/early-config, was Re: What's cooking in git.git (Nov 2017, #02;
 Mon, 6)
In-Reply-To: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711071311330.6482@virtualbox>
References: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ieF6bHnvgX0nPWJmFLpyRL093pCmIi1h7T9lCzZpXKH6PYSvSXA
 5N/LhO+T+J9AbcCPQ2SqewYMLiSG2gXoJUVy9fwnsQdqwT4j9X6LKoUWGX2QKGzZXC+iU6n
 tWTD2zad4fzbW6NUGfHuk+ZTokIDz+pKZ3Ux/eVg6VeEs+i5adCwG0GgkBbZATgKlP2/v15
 LhxdL6FEsVh/Ja08tSJXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MPet2mK/dBk=:qrPKzhYlJGkIgTCp1aIHnJ
 9MTgDkNSBb4E+ajes4rwBPjeQ/RwxHHehNknuCZZ+7yjEihQAxsTeHkxrFjwkZ7ggIR25kVlW
 03K9Z3/M8hT/uqc9B7cFOFRCV3/toks96tJdPx37A4nYH/UzpkF9MOfLINT4edqJJodg6Qf3v
 8LVl0sCxPXw09fCmaZml/Cpdz+DNMqXVRSd64AsL+X1lenLG4msIsOWccSSoHIPx6/tJZq8Yw
 uY28pZl3l9nYl42l0H6tKM6BFEBCCwhfIG0ngSMqdrCOszCxPY34rkHabeU0lQmKEq/MGX6ma
 +XmC4AnbkkhZaqM5DI/DsRRoAsYhTZ1rCWLuhtQSyEi8MYF43tZlWDqXQcJzha7Ziv4vcb88W
 4/jukqqvJBoSZKMJlSKkR5BuSs4RlyHvfYFb9IXErVv8QsqB2zwdO6yQW0gw3LunAyKTlO9xs
 ecw4nYQkqql9ZQvR4WaP2Ck21AAB7DHd9+7iwSzgRbID8IyRh9TF4ZEMFZ0c4GVlDpD86z6oR
 rAYiYN8eiLfvSQIikLS6J6Jdn8yldxN9ve08hx33E35ZyM6drzepTAR+iJRP9c5VM+7TJisfb
 8K2zjwseXa/ovYuIqBi5iargjEgRdiFMOq61FRtj1hGTMf8QqCHPNy2Ib4NR6GUHOBcP4Ov1z
 ircm4XqbCB2ZAyg/wnQEaK+0H7UqLK6OwjlCRUWRSNUVwokVpMKHnPFMqCgqiKMjX5DewNDp/
 6xwwfkQRFNBfVej4Dcx3d1IgbsPWxxIfafVFfL5+pQzB7+kYuPApJEiY/cGcEVIB7F/W2wZLx
 /dUSEEnkGKJdauEQLOw9ob7KjdZ75/0BcJB7s4WQ/6LeGxAOqQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Nov 2017, Junio C Hamano wrote:

> * js/early-config (2017-11-03) 1 commit
>  - setup: avoid double slashes when looking for HEAD
> 
>  Correct start-up sequence so that a repository could hang
>  immediately under the root directory again (which was broken at
>  around Git 2.13).

Maybe change that description to avoid the word "hang"? The original
report used the very same word "hang", but not for the location of the
Git repository: instead, it was used to describe a major latency due to
inadvertent network accesses.

I would suggest s/hang/be located/.

Ciao,
Dscho
