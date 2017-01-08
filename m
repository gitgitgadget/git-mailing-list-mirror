Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EC41FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 11:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755977AbdAHLyy (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 06:54:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:50624 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbdAHLyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 06:54:21 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MePYV-1c7IvO2F95-00QCn3; Sun, 08
 Jan 2017 12:54:17 +0100
Date:   Sun, 8 Jan 2017 12:54:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steven Penny <svnpenn@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
In-Reply-To: <20170108061238.2604-1-svnpenn@gmail.com>
Message-ID: <alpine.DEB.2.20.1701081250580.3469@virtualbox>
References: <20170108061238.2604-1-svnpenn@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a5QKeNexDghAbk+i5cQQGnkYH5CDnNiB2VNkGq84bU+8C/D+y/h
 4bw8c8x47l7/i4Bbq92z+fTmzbbo7o7xlO55quJ1SHZjVpyuT9alqcrog8b3NRYLr6qT76H
 l6KQ6anF5u1zhzmZbZCdNuGQyok7BVgjFf2cvR2LdRBFPFAqQ75ULip4DHGkOwtuD/2Poqe
 EdUHq9Pi8mp70nl2A17eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8XpUwsbgXkQ=:LI1i3Y77Mjs3tBvRqq8s4c
 sh1FUFMsPJORI2Fe/LUoQKJ/raKOXPhvWqQO7exn8fsQQNfFGegSACuimofcZrXSS4P/w0vYQ
 0sXUKp4iCQLNEqXn+OhP0hRIewXDR9Xh0xUQzRt17VYm0L6Qqg6h82VjwHy/Exr6Zta3k6E+r
 w2NMzGNyQ8iRvZa/Mfvcoc7JqMOdatKU3PnYuM1/WASbUgJPSRJh/gh+jMBShinB8I0qm4Swh
 fKv/QqbP/F4qX+CNWKT/uONFjYn9KoOKFgps1U6vPwdl3RszJluoJtDAabIkuIPyQhYS13jdR
 wF4EgzBq4cXpZOSbFo7w1hsgyLSp3dUgkaVFC8eGYEv7pkFzmD8ZkQYQ855Zl4Wb+JazooLoW
 83ZudXegfHpzefg+xYjOhYrySQi0ION2WTkf3yPw0rWskG7Sm2OSHkbies0CXWpi+HUhN5w3I
 HqCL55rOTglpX6XAT1CwfXjt5+schvU/UNpZqz+ok8Q0MZpqL3Qu+tMdoKyRRjJX68hU7D6ro
 dtL/4xyZAWAOQ7rcAfsLeBqYco776IIW+x/9v/5zOuETaTd7Q6D+jsaKpWJSWlU1PJukylqE/
 nHLjJ/a1e+/3Y3hR+DdevuQZ1fyMZtt/i1UOO2My6tX0y5/eRV3xwF+RblDnEmhkaqlLdWHNv
 gDOeOS5IIlcFStHUaBFum6zl15h+I2rlKE0l7Sejd4gM1ocvipOX1wxXh9W5NZga5tacmDaB8
 jH4tQZ3eshR2GwpGlMerK0ju9n9hs8kb/Pw3yp8Jb5AGSvQWI+bmX8fghLsLq1tueR/XCLl2P
 nF18ZyF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steven,

On Sun, 8 Jan 2017, Steven Penny wrote:

> This matches up with the targets git-%, git-http-fetch, git-http-push
> and git-remote-testsvn. It must be done this way on Windows else lcrypto
> cannot find lgdi32 and lws2_32

I am curious: how do you build Git? I ask because I build Git on Windows
many times a day, and I did not encounter any link problems. This hints at
a difference of build environment (I use the Git for Windows SDK) that
needs to be mentioned in the commit message.

Ciao,
Johannes
