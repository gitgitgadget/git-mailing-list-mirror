Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC1920958
	for <e@80x24.org>; Wed, 29 Mar 2017 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbdC2V7N (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:59:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:53709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdC2V7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:59:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfjJY-1cWKam435o-00NAmI; Wed, 29
 Mar 2017 23:59:09 +0200
Date:   Wed, 29 Mar 2017 23:59:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Andrew Witte <zezba9000@gmail.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.12.2
In-Reply-To: <87642eee-7eca-447d-b726-2fa87d212288@googlegroups.com>
Message-ID: <alpine.DEB.2.20.1703292356480.4068@virtualbox>
References: <20170327194813.6876-1-johannes.schindelin@gmx.de> <87642eee-7eca-447d-b726-2fa87d212288@googlegroups.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KaQTCH8K5x6ClR38+ukIPgOxz22gpgh7393/pmV5qxNKfFEMxHd
 YK1C3a0X3W/q/VJbBJ4tl8VYoL7lGhTOUSQDLzunDfQhK5fARiOSqDP1oBylIFD4YpUZnrY
 d2MDcwUybtmK728OuwipNU40D28/jDoxq9X+YrxPRDGPpp+tOqTnNiwrQKiwazVfS51xF8K
 D7nF1exKCvm+CD3FTAcrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IkPBa4Wysdc=:enou8pzxeNVbK/V4DQ1LaT
 TGyWcq5RojqovTZY4L7KuMF0t+WDkFF0tUBrohnql/FKahkJ7ZSs4JcOxOA9vx7epMWfm4Anv
 55cLCy3Bj9nBmJk4e16o5Pxx0/zDfYWvNmssSMaDzUJfLNWggVvrwruAK6QidInBKAerpyp7C
 YFN72Zr0st7S/g+RytH0leSs8d5x8mlJaySMFKa9tZL/DR/88IVp7Ra0VGv2wkKME8ynzVoIE
 0yHxPV7Ik7Di7cASNnUqkoM9zr3ldT2OsvLgdD5xQUdJIOE9QXgvZ/uac8pFchHpEQX3whmOJ
 bzGUMPz0FcKWvY9seVx917nA/i/6QBzdggbGYKY6iXbfj3yawT7lFVlEjZ1ZtVskxflM1sVqd
 OZNudDCQW3VjWqh6zyWeyPbf4szxhjT5ORSm+kOKoGWfD2deJfuv2XF3mxEJb9cVriZVP15M/
 lM6Bmgibm3zJvh96MYGGCz3sLQIp7rtpUOAlCTecORE81qJfwBf1uGZn0L4aqZh7kjj3v2Rvf
 d8co/fgNl4lbnNEj7/G4qzPWBHngQOdvG3j8Q7fe63V3MNj7Nq336HA0EW4Ny13tI37432Teo
 3iBQtDQtPYbakS4hljNAezBgoG1OHnT7rA9c9tmXxP0RxvdcWkA3bRh/pHD8ow95Jjpqfa0my
 NQmb1OQiZqPTJheDxtuRTncKlituKMccDJUo4U+KvSWfv4d+JW1zsvi8GqTt84h+V6yvnv98o
 cQzucPZQTsEUx0AMVRaE23Bn5UI6VkEPLNP4ncmYR9CfUgKW5picLrCrxfQ/LxEHKFnXofpDz
 fe1zi/l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew,

On Wed, 29 Mar 2017, Andrew Witte wrote:

> The git 2.12 GCM for Windows is broken. I tried doing a git clone and
> got "*remote: HTTP Basic: Access denied*".
> I downgraded to git 2.11.0 and everything worked fine.

Could you test v2.12.1, too, and open a bug report at:
https://github.com/git-for-windows/git/issues/new ?

I am particularly interested in any details you can share that would help
other developers like me to reproduce the issue.

Thank you,
Johannes
