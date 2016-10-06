Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060C820986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755569AbcJFJ6b (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:58:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:49550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755508AbcJFJ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:58:29 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lev1D-1b6eSd2aY3-00qk9v; Thu, 06 Oct 2016 11:58:08
 +0200
Date:   Thu, 6 Oct 2016 11:58:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] run-command: fix build on cygwin (stdin is a macro)
In-Reply-To: <7de3821f-5111-47ac-b7e5-20fe1216ba58@web.de>
Message-ID: <alpine.DEB.2.20.1610061157090.35196@virtualbox>
References: <f9b6abf6-8305-4a32-29af-765f08fee94b@ramsayjones.plus.com> <7de3821f-5111-47ac-b7e5-20fe1216ba58@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-770791816-1475747888=:35196"
X-Provags-ID: V03:K0:2ezQfBI8xs9NpnsGrKMvUy/3Lv/tlZYSbeHKFW2iZTIc39jMYxV
 wFzTnNJxB4UchRoC67GagC+rjXgN+rZn0KkJQqI8HWIG6RmT9mc0LP/en1icmCwBSzLksyP
 D3HY7HZrjIYg3adRCgTp1ufNn4n9VocmAQOD1DlDkisV0JQkO6qjwSS67EpZRHfUJScfJCM
 0M5SvmfXTeiCSSn+Bhncg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TMwUnC2yUNc=:ru/8wCT+5H0P0iRFTBPNDq
 i3aTEuGxZUTGswMU7yspBA9BGZH9u0dCnqcdPoktunMzU4Zl1FAz238cdJRcofnVVpiW1i2jX
 sZ1+4UthpFF0kOwZT1nEwf6QfPO/2tfiDUWdSjIlnDmfe89zUtv2Pk+a6ms+8tldLLBrpwntz
 vio6snjTBnlsDgkJAzaWTbcThe8Y81vqgvV5ql2be4DOG1OhHOE2L+ECtO06HxeIfiQ+oN/KP
 RJ0DcmeUuJecn5xEmRLvdteHbHZvbKY193t8u+lmcnjQTrOlgFRdzUu7QbYdLZsluvIHs99R0
 gA4RlyRH01dKkZ2Xbmm3mT7dxQSRfMdNatf5EDSysPONfiB5Fya00+wsB7xJePpQ2C+C9Dcn2
 dlGDjdZM1X1o6JK+mz+agxMaFnV6tc88kHO0olv1nEE1b/JhF+t7Y5NOZRde5YTFE57jV3YC4
 JQvz3kRizjjwMWVIVKLyES90/ud3TBrwRc8k+M2UAedIG1FyvL1M2wSPMwe43hv/fWyfopROM
 X7wyFl7mhsYXcfJHl76UtEi+M2CplQHloi/a6vze8GEXaPcg74OuRcWEM/dEXUmTHekVb3cL0
 V9m0jCAgmuyG9zkV32OFpgXPfQqpF/eSANPxf4Kwd7YgFSLN9cWAZU53VOVD4M0ZIx4ODTK7F
 +ASc4AnW8wuEFaWGQB0srJxfCBR4wG1DoFTDdiu48vo2VmbksHKINWWa8MsbzoVCtQ3Of0BAv
 m65LC1/XFqMXuZdlgnagn/SkRxomwt5nnDl4vEpqbT10gDpd5ZDW/cn61FCNBcoqcPqzKpYGb
 nsg64jt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-770791816-1475747888=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 6 Oct 2016, Torsten B=C3=B6gershausen wrote:

> >I am not suggesting that you apply this exact patch (stdin_ is not a goo=
d
> choice
>=20
> How about fd_stdin ?

Better: stdin_fd. Why? Prior art:

=09$ git grep -c stdin_fd
=09builtin/remote-ext.c:3

=09$ git grep -c fd_stdin

Ciao,
Dscho
--8323329-770791816-1475747888=:35196--
