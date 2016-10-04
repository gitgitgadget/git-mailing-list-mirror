Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145631F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 10:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcJDK0G (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 06:26:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:50496 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbcJDK0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 06:26:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M9JYE-1blMdL1QWE-00Ckbh; Tue, 04 Oct 2016 12:26:01
 +0200
Date:   Tue, 4 Oct 2016 12:25:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     chris king <kingces95@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Repeatable Extraction
In-Reply-To: <CAJQwtsidixAAJKp7-b2PmXgs=mS+PbT5ebOmKLJU1nEn7UJ2og@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610041223010.35196@virtualbox>
References: <CAJQwtsidixAAJKp7-b2PmXgs=mS+PbT5ebOmKLJU1nEn7UJ2og@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:d6Jwk/3CPHd6dFQg0dPwZN0hBZ/v3vGCaZOBoXOI4kjUYNtGuTJ
 pz8TrvGJp1/KCRsrVGg7VyZZUcRNrss0DfahpCJH+DujWbnrcSqRupz/heE9raNebBSAI4B
 erxVOILnE5uFNKob/cKXctIi6h5cAyxkxtUrhitnqpm/iMG/d7oSV5jaDqjezx/xi8Ywasq
 rMH/CkpNdkil0U/kJ1TlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6CkLd/3U8M0=:7yDJPCcfqyTF6OuwO2P2SA
 0WXso3U/YBqiU3Vn6UfGql5aM4XKSDPqfhTuFZ2ZS5TeeyclblUm6xuiyjwp998PTiAstmKuH
 5vb5LG5vxfZ267WSlEbYo/CXDaaPNmGkmi8WMGSE63dxSFD0eLl9MGYsO79M37dWMoWLIqV2r
 hzK+N0F+QLzWVyprma/gn8G3BUMQW9tSTKyNsoPTG1oTp28+wPpNVmKFZ3wVfyFeOy6DfebLp
 jjtgpXs2j5KcOJxfXz1aq/k4/0/MTpC+KSHWDIl4GVoGjquz6Lf+adLpAvJI8hJl4UnQ0cNsF
 jkjn35ge4Wl8DT2gDeKqOOfEUijxBQ+Pivlps1DRyy2nQSUAy6fRqn3cx+uDF+mF0WnPEACd6
 uFlJxlXQMSXobi5AVooHEUppLdhsUk5Jj9GYw4LmdWgjynfyCK+48Y/xy7b2xsoTB8gWVkhUW
 jmU9tB45INxeZaoI+Boin+mpOkDZQnM6XZoTeL1y007gUtk+L3qufUe5iRa6RiDa1FMDy7bzq
 t8nbwGTvQjXMZIFdtTSiSegNtgHdRtKCqZBArYXU6Ex1+Jjefbb2gQcAf7gRzNq4EAqzPCL3A
 O0Z64hrJR8dJWFLFf/UXM4BjEBi87xTDHxKCtDC6DPSM0i60p8RFIkjkHrYDxIpYqFULA+FNE
 hdtljHKyH/UrBzSY0v3u6LHGUKMjWhMH1ABdQgF2e7iU1OPpaCNWSoi/Jw0tfT0xNlb1r1iSz
 NPHKEOkavHkTprCL5xVCLyp/LwcCK0sAg45do1ZK403dX4c3NtA9rcJovTccbmxmBG37OrIEU
 qqr8V2t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 27 Sep 2016, chris king wrote:

> Is there a way automate extraction that will repeatably generate the
> same files? Currently, each time I extract git portable many of the
> binaries change slightly. For example, if I extract twice using
> 
>     PortableGit-2.10.0-32-bit.7z.exe -y -gm2
> 
> then Beyond Compare tells me that many of the files in usr\bin have
> changed at offset 0x88 and 0x89. Why is that?

The reason is that you look at 32-bit, where technical limitations force
us to hard-code a certain base address for all of the includede MSYS2 .dll
files (i.e. all libraries that require, or implement, the POSIX emulation
layer called MSYS2).

To avoid clashes with other .dll files, that base address is adjusted via
the post-install.bat script for your particular environment.

If you want to avoid that, you will have to extract the installer via
7-Zip: it is a self-extracting .7z archive (and the self-extractor
automatically executes post-install.bat, which subsequently deletes
itself).

Ciao,
Johannes
