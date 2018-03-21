Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D53C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCUQC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:02:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:39655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbeCUQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:02:55 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKmP-1eU8oi3XQv-014Rse; Wed, 21
 Mar 2018 17:02:49 +0100
Date:   Wed, 21 Mar 2018 17:02:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [ANNOUNCE] git-sizer: compute various size-related metrics for
 your Git repository
In-Reply-To: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803211659390.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pNaBLp2pJxk++dsqF5bGcFW0MKdmz9KoaK+L5cJPORHVK8P/NYK
 QLSdzMGxDCiKQ/AaMpArDj1R3QT8oZ/qPI2n5Qqxo51FL27XncuWLdGYkdvb3NmhbzhzytU
 j/VcK4kcH7JNA9lrpxledJjIw2vmbrOgDgPsIx2GrlUHYRELceEatSFjVJvlaalb7OhkKS1
 /rf6aPm0P+fuuWp3+0gnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QmYiLdLZxM=:emCboCLZQIKOIojdbCudjm
 xee1jksV9LPcHlExwfToXQ0cN8GnmIGrpF4Cb7Db0RvoZWMFvYo/AO7+41GBkz/CB84Qh5Gyj
 dAlYg/E/Cz5TmkJzwTvCsrbpw/LQJdno45yOxrVId08vRmd0myBfEjcfPH3vfGu88eSTP+AAN
 kD9icw0QK6fVzdMNveAb4zrBIoM5F38lAUmR+3C/5hyWdiCUlUpzR89DWkhcYxL6gaGaCpT6g
 qKnfyP3Dc4/dbXu5tOARGvGMBblnoXb5k0NyP0cI/hyRhhfhywhBltfuxyRVq6p337p3vYtjq
 J1Ua70iz5q+hYPBbdl+inNucOylwDyN2aVoBmQFN1IMw+XubBB4raTZd/FBCdZE4oa7XaCAkq
 W39oBrMkyS8XxnwzdJwn/MYqMzdcrUlpfIiiLT+fP97SsHqHCGjr4NR/2C3fc2/yGd3p77LEV
 3ecFC51AH943cqQ9LjrRZkfq6BjDnrUGEnzunCQRHlQQZgeTgOTHusua7mV39kMcJd3vbEBqi
 ax29eFzaqXXvXGNK4bEBKwNPa+sQhs5CArofUFVq0o8LtzriKeZ8hOE95ZEsd2E413UioOO64
 isf9x+iPeYbg3PWZC00rDH0K0yVIzrVx91IRodIzv0ZWwWbMxBsSmq/lNhkEMDRZxctb3OJV7
 6+LHYoKxhyN0MpGogMmSfgGwTcAUdtL07JaFAe8HZsSWRy20ju6Kcwl7lGt0yN4IQ1xh+xNnB
 lr6LzoEQz2TQqqyQDWHjhzz/7swrN5nP7QzYZgyhgE16wgoveMu8OTSddNhnfNXmq3CrSlg3A
 sT/3jW4DrLu/rUAHwZs36sUCAtJboqpdjR7JevqPVCECLk0ypY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Fri, 16 Mar 2018, Michael Haggerty wrote:

> What makes a Git repository unwieldy to work with and host? It turns
> out that the respository's on-disk size in gigabytes is only part of
> the story. From our experience at GitHub, repositories cause problems
> because of poor internal layout at least as often as because of their
> overall size. For example,
> 
> * blobs or trees that are too large
> * large blobs that are modified frequently (e.g., database dumps)
> * large trees that are modified frequently
> * trees that expand to unreasonable size when checked out (e.g., "Git
> bombs" [2])
> * too many tiny Git objects
> * too many references
> * other oddities, such as giant octopus merges, super long reference
> names or file paths, huge commit messages, etc.
> 
> `git-sizer` [1] is a new open-source tool that computes various
> size-related statistics for a Git repository and points out those that
> are likely to cause problems or inconvenience to its users.

Thank you very much for sharing this tool.

I packaged this as a MSYS2 package for use in Git for Windows' SDKs. You
can install it via

	pacman -Sy mingw-w64-x86_64-git-sizer

(obviously, if you are in a 32-bit SDK you want to replace x86_64 by i686)

Note: I am simply re-bundling the binaries you post to the GitHub
releases; The main purpose is to make it easier for users to include this
in their custom installers.

Second note: I briefly considered including this tool in Git for Windows,
but it does increase the size of the installer by a full megabyte, and
therefore I decided to keep it as SDK-only, optional package.

Thanks!
Dscho
