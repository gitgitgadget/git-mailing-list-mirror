Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B81207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993788AbdDYVdw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:33:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:53565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2993785AbdDYVdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:33:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmr1w-1cM7lP2hrg-00h2Mf; Tue, 25
 Apr 2017 23:33:47 +0200
Date:   Tue, 25 Apr 2017 23:33:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stepan Kasal <kasal@ucw.cz>
cc:     git@vger.kernel.org
Subject: Re: Git For Windows SDK - cannot build
In-Reply-To: <20170425111315.GB13400@ucw.cz>
Message-ID: <alpine.DEB.2.20.1704252330480.3480@virtualbox>
References: <20170425111315.GB13400@ucw.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YJTQyK/ZXYMQSddPpwAf/ZhhSligFsnZikTcKbRqmHiggGcowBP
 H1OypxtUf20huvbtuZZJ5R7yHGmo5SQUVSZnMWH4UKV9sy3Fbtf+AzvrEVcEdxonXypH5Ub
 kteBFLuGjZtI+kuM+yPbhVUYM74f4RrwVGxmztwAsk9TZhRAJS/RbsouYbtC5EkRMPiPz6+
 YpBLQGooRK8qtPM2ByR+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kyYO4cIY8KI=:1n2dzaQwpcV3RAQt+gax5Q
 YB0Mksicn73NN6mCueTiQnTdQ5oNUPDZ2phXofS0tfkBeQC8kZOK9VJ66khDOafO4rDtzH8Gl
 19zczXEbFI3h1AIVJ3On5OvyYI2OF9CQG0VhEe3PfS4s9fNgGtj2hvA/gBw5iH1Pip2WZ3N8t
 7yMAPhTNENdZfCoHD+Upv1DMQAKajuAp7djiYr8EPjs/vBylfenCt2uP8sL8OgCYUUtA5LmcW
 ig9RTzirHpkKsfhEg1Tls6KJnb34kQA0hCVxtdSgOo8x8oWj2ZlKa+V1/UbrjzavigsHByzOk
 6CywSAs1VFrulKua0lRP74UdiT/OrtOWzjwjehS5PCmVQdc1epA3ptWBSulG8WFmdel+mzVdS
 XjEMZvpbxRJgTKYgw11A4BPkv6ZOvlb81V3JeLjjZMVz8cxDGoyZ+Iw9PmArvKXmA13TF17ll
 Nw6k2m29bOSsnjqv5/eptUJgBb7iYouScDlZp6vKv67YKOcNYKQq9lOsq2N6Cto6EPDRL1Bd+
 rr+crmFzI3VIpCCKKd2x2OTLHbco+PEJlFcR6xx+yfU0RS5Vn0oAsCPYWuDGHKUxcGHYwgMBC
 J3M5EzGIpnhlqILmN5SU2zgFs/njndzwIS4yi04L3DDIhYWgPqcw2X3rrDyBgcJQ0H4KvVjg5
 Chtdb/Iz0PvkPfEq+y86liQ6RM2LjP45iVhb3BgCf0xQJa1X9/l77wJgatqIaN+J2narrg7L5
 eQHKERaHnAEunMRpjuOvx1mOJMgURHah03sOYY0TdlZ9q/mfGPztcc1ZRsO03CXouE3AW2y22
 gtk9VBP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stepan,

as I commented on your post to the Git for Windows mailing list:

On Tue, 25 Apr 2017, Stepan Kasal wrote:

> I have installed git for windows sdk from the web and tried to build it.

Nobody in the project found the time to update the website yet, but we do
have a simpler way to install the SDK now:

	git clone https://github.com/git-for-windows/git-sdk-64

> $ make
>     LINK git-credential-store
> libgit.a(utf8.o): In function `reencode_string_iconv':
> /usr/src/git/utf8.c:463: undefined reference to `libiconv'
> /usr/src/git/utf8.c:463:(.text+0xf77): relocation truncated to fit: R_X86_64_PC32 against undefined symbol `libiconv'

This most likely means that `pacman -Sy mingw-w64-x86_64-libiconv` should
be called before re-running `make`.

The reason why the `libiconv` package (without `mingw-w64-` prefix) is not
helping: that package is an *MSYS2* package, i.e. it implicitly links to
the MSYS2 runtime (the POSIX emulation layer derived from Cygwin that we
use in Git for Windows to run Shell and Perl scripts, as well as OpenSSH).

Ciao,
Johannes
