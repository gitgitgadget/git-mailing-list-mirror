Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E00202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdCHMWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:22:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:50499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbdCHMVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:21:42 -0500
Received: from virtualbox ([37.201.194.15]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHbpA-1ciIWP3OFY-003JBN; Wed, 08
 Mar 2017 13:03:25 +0100
Date:   Wed, 8 Mar 2017 13:03:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     valtron <valtron2000@gmail.com>
cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <CAFKRc7ysOAOVx-7ww7MLF1qKpuKdJQqAtAhLJcYh3yMD3G2ncA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703081259150.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com> <alpine.DEB.2.20.1703072345530.3767@virtualbox> <alpine.DEB.2.20.1703080104580.3767@virtualbox> <CAFKRc7ysOAOVx-7ww7MLF1qKpuKdJQqAtAhLJcYh3yMD3G2ncA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fvUvuEayHLXr7AZgY5B69OwEL+I68dVnhC4fsMG1A6iypD/zuMm
 05aqQfgQNltUjiiwVREb/A+YGiaA+iA+X066djIpwfp8VD5GlunLVXmQMDoD1Ewixf0/aSZ
 40kOujh6vkPUEIMXfmO2te49q3mmBpUOsgWfSLkj3BTVX9EtEignLxgEG8haPvjkXgKQhHz
 fDqy+mxfWTrkq0hn7i5gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hkf5BJNFfVo=:kQ48wqYyxXnBBLSR5foAdO
 IkuoQLUtDnrMKAD0RfWexw274zaFKWd2O6IhjQamZ7cJ6g0eD0EHKOnLPeZiGsaQSR82NZkd8
 p1ivKwWcmktMmABcY18apjs53GopjCwyqUqWkhdyuHa8JXNfgDNJ0RiuwaZNdL3ZDmZAgHRxp
 htQG747N4cZuNfHZqQ3Qq4Sblq3OJmrbAZyGwm6Squ8nq0ructd0vGf+LW+e8J3CZKIBLpUPw
 2jP7SVaa7wL6AWbvlKm0yCVSkyxurHzeE/sD/YDntktloLD9hdq54CPKsIkPkuObW5iBOFLIY
 72iXkIzjWO67RwYPYJYi4yHOqyub7ycBgZnU+bq8SaJAmlRTErJgB1xK4WKKFcGlEZQeU+lOF
 wGfoCbG7Buia7G2qfWxLR7pkpsL/w5aStkAcB9N+g8fO8xQVTINld8E4US+WfT72P9PVTErST
 B19CHq1YJT4Q3AM6DyhYbmcn3en8nPQuOMoRSXG7haGmo0475+Rdd3PSF9FauOqFm/fzK7QvV
 oN/fE5PLkcW693SEk2PwCTFK20Jud5yP+lVAV80aRsoSkIB+BnZphf0aSe02lZakBLsta9hsl
 L8HoXqsgmwjRQroYf9jZBC0gWwoYD6Z4vY5rhu8n/BwH+zK+/Kde8OdHfEsgaiDpe9nncfLOk
 SdhaU94rYnsNdM8MqJ9zdMKXu8eMN/eo3Fvd+to065nN4Fxuw4EcAljWGBY+mdUVAEp9FkZun
 6QzTvJe1XKug2hDFJTz21oGrmSjQBkmAhQRJvbEpxLLRZAP7LptxEQl01rQa52kOiJFp1I4RP
 dukuZ19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi valtron,


On Tue, 7 Mar 2017, valtron wrote:

> I only ran into this because of git-gui, where I eventually tracked it
> down to line 1330:
> 
>     set env(GIT_WORK_TREE) $_gitworktree

As git-gui is a Tcl script, which in turn runs as a pure Windows
application, the path should use backslashes.

> With that line commented out, it works. I'll look into why git-gui
> sets it to a windows-path-with-forward-slashes, but that's a separate
> issue from the crash.

It is... please do contribute your fix when you have one.

> Also, from the stack trace, I think git is still able to understand the
> path, since it appears to correctly convert it to /c/repo, but I might
> be wrong since I haven't look at the code.

Git does not convert the path at all. It is the *MSYS2 runtime* that
converts Windows paths to POSIX paths, if any. And it does so selectively.
The current working directory is always transformed. PATH is always
transformed. Environment variables are transformed *when they look like
Windows paths*. And I am fairly certain that a GIT_WORK_TREE with a colon
and forward-slashes fails that test: the MSYS2 runtime thinks this is not
a Windows path and leaves it alone. Enter your problem.

Ciao,
Johannes
