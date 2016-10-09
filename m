Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB07E20986
	for <e@80x24.org>; Sun,  9 Oct 2016 06:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbcJIGsZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 02:48:25 -0400
Received: from mout.web.de ([212.227.17.11]:60882 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcJIGsY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 02:48:24 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MAdol-1biMX8460p-00Bwby; Sun, 09 Oct 2016 08:47:34
 +0200
Subject: Re: %C(auto) not working as expected
To:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
Date:   Sun, 9 Oct 2016 08:47:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YJproU3FolskAAsbvd4XECWCAFlaUJlduJJ8V84Kj0S2Msahyce
 t94wl+UjrkeYsikqwod9c0Zve1qxJjD2BySJbpaCa/tZFSAjVIfe36Cs8/ZgPgsKaRNnwv1
 4QaTcheU8ZXe3q2ew8kQTlD7iRU1C7QOFwv5kP0XXpa5UYVxxPi/f/9joKRuEOu7tfzDV9F
 +2R6J9xRFSnmawaJqrHpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ebta8xDwlS0=:NfZ89yXm+pLqjIKgw5VTdt
 0LEsmaW3amRZeXR/A/WZETZoabmLBnWhC2Ad7SRH87Zz62HkhDgUbsoA9MijLhL3fOahUMedk
 OfGW1OeI0xMYTFAgSOcmBoCHXRFHetEU6BPL+RcZMuTZ16HjDi9771soBmw4ZXc6vawomiiVk
 UyXdmsr/lckAiPbmRtE/AGoOW/cI8ttSNTFT00TA6oa9aRP9r1Uc832MNvmQUJVsqIB8r7y5W
 Yam30DzAP3XAQt+lvY3axON0BwM5YLqC7Duxaq1BDxu/etTZE4Y0XBAWfL+QRVDjrtC8GBjiZ
 n1jVs7DNrMLCI+eRYudqCOyL9eR49xEpIocD7IUlld8xtkebEpBKoaVqOjRFcjzaKx9Rc+i/9
 l12mCPWG3wRmPL1AN7Pac5rFgCuP2weIK95boLufCB/gyC5r9GXzraTe5lT6KILIZAC3P9RTk
 ea/5B+3Fy3iP7AzJB8UyRJAK00Yi74GbBDUi1AA6QLa+nVkNRa+3dXxl9EtGp8tMLKFvNxq9y
 rwvhOClF3whnlylYltUnMcLhaZuf3KB3uxkk8AxqNmrnDWpttBCNfxbRzrK3UjQ5lBNenAGMf
 vrHRGhNv9kg5yr3K9t/cZ7YfMqADFX2ahZUS4qYTo6WcoDXJcKlFVgf3Asac4OCfL83BcbT6v
 bUMhJ03pl8lMJlW+Y/m4zcuBf9x2GbTbMyOEokJrHPFxG7Hul2mNmGnk82GmyoKWoZq67hSzJ
 vA9TehPQ802SDoChJshgyPKf5t3uoR9+MMcHyP6lH2pws3r7PyX1fvXfu4Y+I6/vkOieFHsqM
 fImxjkaOiL+AuKXPhSZp3KglAcIt0UGocaI6UXdjlZaaWmK+J9wkf3O3vmuxOfSofFaTtwLqB
 XJVd58pMgY4V/vhCol+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.2016 um 07:43 schrieb Tom Hale:
> $ ~/repo/git/git --version
> git version 2.10.0.GIT
>
> The `git-log` man page says:
>
> `auto` alone (i.e.  %C(auto)) will turn on auto coloring on the next
> placeholders until the color is switched again.
>
> In this example:
>
> http://i.imgur.com/y3yLxk7.png
>
> I turn on auto colouring for green, but it seems that this is not being
> respected when piped through `cat`.
>
> Am I misunderstanding the manual?

So this colors the ref name decoration and the short hash:

	$ git log -n1 --format="%C(auto)%d %C(auto)%Cgreen%h"

And this only colors the short hash:

	$ git log -n1 --format="%C(auto)%d %C(auto)%Cgreen%h" | cat

%C(auto) respects the color-related configuration settings; that's 
mentioned on the man page for git log in the section on %C(...).  You 
probably have color.ui=auto or color.diff=auto in your config, which 
means that output to terminals is to be colored, but output to files and 
pipes isn't.  You could override that setting e.g. by adding the command 
line option --color=always.

%Cgreen emits color codes unconditionally.  %C(auto,green) would respect 
the config settings.

Your second %C(auto) has no effect because it is overridden by the 
immediately following %Cgreen.

You may want to add a %Creset at the end to avoid colors bleeding out 
over the end of the line.  You can see that happening e.g. with:

	$ git log -n3 --format="normal %C(green)green" | cat

Without cat bash seems to add a reset automatically.

René

