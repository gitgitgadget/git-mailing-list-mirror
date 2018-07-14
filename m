Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5871F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeGNVwl (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:52:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:34813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbeGNVwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 17:52:41 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.126]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M2cYX-1fxUvw2lL3-00sOqs; Sat, 14 Jul 2018 23:32:13 +0200
Date:   Sat, 14 Jul 2018 23:32:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     David Brown <david@davidwbrown.name>
cc:     git@vger.kernel.org
Subject: Re: gitweb and Levenshtein
In-Reply-To: <e5903365bd8679d345bf3ca7f535070d@davidwbrown.name>
Message-ID: <nycvar.QRO.7.76.6.1807142331110.75@tvgsbejvaqbjf.bet>
References: <e5903365bd8679d345bf3ca7f535070d@davidwbrown.name>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JR07zzFBQpzgYihK9/36WrH42I3O6+pwBWsooHzOJJYOSkIgXQZ
 m+plFAANosq2ir8BxzvFwBLfyQvR7+cCRwt3GjQI8IcXyZ5O++NfcWIrLaEnh3B2ffkrBE8
 SfVvOCsOJcaXYlAfG9G4awt6Rwv6e1HtziSunRBaXwbNW8Un8EBQEo6+3+bYjI608xhg6Ho
 GX2GnOSvSi34eDGXMzW/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q6EUb3IHjfk=:XkO6MrGfX5Jzvz8kaUOYZH
 hhdRcVfOwPLoIsULh0pKwl+JgnB9dzDzlY5VeqOTOQx7eHHQ/HOIAV8NNkndt6iRPRm3ojoW4
 sEDB058tkUlOeu90djJymH6P6fA046nB8Q0ygyhL0EsQikow8Hki3XwtffDi8JcGkgrwRRfC+
 JWmoa1MQB02Xl98NW0hb4gNwCSipe5zlbQOk4QX2eRHlP6sTQIk2y0izwkhyJJXH0sNPHNtNh
 gUWIOt2pHRCyTXbQh5KG9sbLjAils0QQTH0AOJvp1lxLJ0L431PQLTf0qDyQP1thEDBvLhOr0
 uprp9pGiBntfsccg4F/DefwrdNUzRs3BQW8UQMvETRn6c/mSTK6D4Qw8xEhtYFrPJkrabCJ6A
 qrMfaHYtokJdVjS5XPGfhY5Pwjw47DFH3vSSXDFDxhWW8xioVGl6uG3UIUP1e3u3dYqd4eCJi
 H7VPyXJq2O3cam29GvjxDM77WUibSWLvt261H1cejDxevo0JFVQpb5AL3PnWiCw6vFa0RM5xj
 gzu5hL+rESOj3EJAP6yUrN5/4UK2EFSvYwLg9/rtLI+S83ukcdL6K3EpsWVfyu59/gzxPm3jc
 4GrEcLt9oIEsI78krR20HqcgV+Gg8IM006lGO25iCjW9YsR9OMK/Na1QY7XYJjVnuYLgxyVXA
 p5uM5/0uRNUmYI4/zWN6nvu9Gbb0ETCO3JHIdaGFyGFEvlAoyGqxTlLynXLEcCdTxO7Ume/o0
 4oG+bjS6Nd9/Rm8qSaL7FGJ6Xu9Ndg1P2g9MkpGNadutdjGrrO3Uv1U5hhKUTBNvXKeVXZm4G
 wBDV9Vw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Thu, 12 Jul 2018, David Brown wrote:

> Howdy, I want to hack the getweb_make_index.perl script to create a string
> search using: https://github.com/git/git/blob/master/levenshtein.c.
> 
> How do i reference the compiled code?
> 
> I would like to call this routine using Java and maybe Perl.

The code to compute the Levenshtein distance is not exposed in Git's
command-line interface. Therefore, there is currently no way to call it
directly from Java or Perl.

The best you could do for now is to convert the code to Java or Perl.

Ciao,
Johannes
