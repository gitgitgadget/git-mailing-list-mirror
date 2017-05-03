Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93C21F829
	for <e@80x24.org>; Wed,  3 May 2017 14:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbdECOcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 10:32:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:60064 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753352AbdECOcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 10:32:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMT1y-1d9mwQ3InG-008Jda; Wed, 03
 May 2017 16:32:16 +0200
Date:   Wed, 3 May 2017 16:32:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     ankostis <ankostis@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: CYGWIN git cannot install python packages with pip
In-Reply-To: <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705031630540.3480@virtualbox>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com> <alpine.DEB.2.20.1705031147040.3480@virtualbox> <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0NUze+oazdY/ONd5AvtB0MOrbXS3dyd6xAYDTAoX6EGdod45fMQ
 wj24spGVTp1LIKRabktEFsDaGM2QLlRncaHkFOuwqeWCBeb4Fmm/kkfQ88/6HqhVnQhpPC/
 rzdH0kQn++SI6gz+EL/AwsgQGepVFE2TRHFNEig3CsutTVMuoXWQMATGNtOvmnFhqpLvYkP
 6+om1+649OFGHds455Kew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:judKZDKnd8A=:vPeLj9h/z61b2rm/rE38uO
 ATIcJeylqueecS+T47Uf7iQtcOs/9E9DPDL5xtn9GPgNH41kf5Pz98CtyQekVTBCufXn8LaP2
 wxTVtrZZ1sRVgUB4QHSGXp0wBn3aZTvfo4X3lzajNR+X1oZHvLP8UW3OhAZxbruYnZRane2AN
 De3AVMtfDqZzynqblCLtltOx0QlW1SKjhWbp0muCGniw1vMjy43w7n/DDu2xeq56XYqi6mF+A
 JF9oUykRVhpDYABQc4Fp5diR9fdzJXcodOuF8QcciwnryahGhP4LfLvIHncLbRVyewgNcvAbh
 NC6QT+ldDOosPBtSQWXYoO6TtDSW4eCWJcxOC9XR4qod4nRuYu4a/mFlYb9Cu7DweHt38gBKb
 QjVZpOQfzSgBrpC3fp75YHcRlYOqGJfAd9RgO+AWrViqUME4vdyC9Ie95susHl5DByUvYFgsy
 OloW4Le4VPVZn57zyD5kDirB775gPJGJYzGVir8/sxCQm+fJxqK3vcW9zMpviyHQHxROJDKl/
 q0UQuYpKNN5o9uz6e7NiSHCu+iQe9yGUFsyE4lTFN7fSLpriaxbxfr05WUi/193ZKDv5xtvfg
 AiVZO0CF7S2pjyV3MIE4tYcp6SdiYh6cFSsCCVCrB9Lucl2WLvSDIneTA0ePzSejMapxhwaD9
 4Z9IJT3kdQwhcaZjtGINPUn4Hkcu4ipXy2gM51dl+9qDJS0c+02aJdPIp5jNmNaQMAL0yAFJ1
 HVDpdnjnhEAc+6PhDbITvasv/ymnzl6ew92D8lzFfzY2kXl8LKM/yHs5FHPnAw5Ro2gR9A0Rs
 IOKioZd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 3 May 2017, ankostis wrote:

> On 3 May 2017 11:47, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 2 May 2017, ankostis wrote:
> >
> >> On Windows, with Cygwin-git 02.12.2-1 the python command:
> >> [...]
> >
> > You forgot to mention what python/pip you use (is it the Cygwin one,
> > or a standalone one?). Intentional?
> 
> I have tested it on using WinPython[1] 3.6.1 & 3.5.3.
> WinPython is built out of the "standard" python on Windows.

I am afraid that you run into path conversion problems here. /cygdrive/d/
is something Cygwin understands, but not WinPython nor Git for Windows.

It appears to be difficult to impossible to mix Cygwin with non-Cygwin
executables...

Ciao,
Johannes
