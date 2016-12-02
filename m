Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0586A1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 16:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbcLBQGs (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 11:06:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:60650 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbcLBQGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 11:06:46 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ma2Lr-1bysea1v1r-00Loyt; Fri, 02
 Dec 2016 17:05:07 +0100
Date:   Fri, 2 Dec 2016 17:05:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "P. Duijst" <p.duijst@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Error after calling git difftool -d with
In-Reply-To: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com>
Message-ID: <alpine.DEB.2.20.1612021704170.117539@virtualbox>
References: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NgI/AxmpsC96rrhJSVgoqMaxwr79xY7P7L3TgDDMG1FJz9NOvC/
 5UOWGBmXSueMneT2pFfcl9pzauNY5iXbjsP4hcYcP7f9g9phQGgD/R97V6aeqV7LuijoFAl
 YPlKuxjZPilTrMtHDPMib6COc08ODuaXaEjGmJGPVdyUv5d9hH+6DB+BQgnqST3lwuGWMhe
 Ogvbsnc8MCEHdfh49ruaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/NiLyEOW6BY=:Q/84JZbK25NDDiUTwYGHXF
 QXiNMWg6dPl6xEL4lycG5icZN5DWV3vWGoicfEKlCj/iwCZ/Ggd0AthIOafp2kvFzTwYpfA1y
 FGbrzS9eNWmtUE6pCnjHmcu0CmvacBFfCqc6t4LmCSk1GgCpFz6vGr8zGHXmgPVKY9g7s646X
 IcDYTHsBd3VKShH5fLcDsANv0HXDPHicYE+cb1Rk2LKi+xUteNCFJy5qhf0bNP10xWCPRK94F
 Vkoy/qQ/59AC0701J7suRRG0vauvFW6EAKORKAWCfNsIx6uMjkVHoZcoUxrsR4cMN7eLq+1JK
 ZVQLEbqVy2ixy5QBM4VC2UPxnpFZUfmTCog5sjc3a83AFbWS7ry14+u78g0Dqf+VaBmsUMFu8
 DcaYt/Q1RE15xdoS6/4Y94JyBKzRCp5skDGszI391h9d2VQEA7pndHX622VO23PdRhypBfdJO
 qzYJYZ9FHwM0g0My/qCWUX7zSH2CJHY4+Du93Lts9GtNAqVFL9hC8bH4LP+/4/UNsVhPIUHpD
 i99Iy+M7pfFPHu7y8OnRQSiHztmvh0vs0oqm1zLPhD8K7n3WfGkp3DNVQNDpTaRs3ens/lVQ5
 /U96PeLc+gKEYEXXGk+DutkrhlqwDRqUBS3zxLTHlM/OFUT0yrVW2q65xoi07vqaq/08+NU2M
 IcNzqJYVj76KBGtMKJF8+3I728RG5Eidz8cwqOIVK85ggzPkTW/1VdwENcbmvy/32tEy2owEl
 gn2jYRj9H+CDlOQStns4KT6CXUbgzJKWCrqXNU+52bETQko+4UjiUFZ9HDJ1KbM/v0dwRhmYU
 4ArcKgS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Fri, 2 Dec 2016, P. Duijst wrote:

> Incase filenames are used with a quote ' or a bracket [  (and maybe some more
> characters), git "diff" and "difftool -y" works fine, but git *difftool **-d*
> gives the next error message:
> 
>    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>    $ git diff
>    diff --git a/Test ''inch.txt b/Test ''inch.txt
>    index dbff793..41f3257 100644
>    --- a/Test ''inch.txt
>    +++ b/Test ''inch.txt
>    @@ -1 +1,3 @@
>    +
>    +ddd
>      Test error in simple repository
>    warning: LF will be replaced by CRLF in Test ''inch.txt.
>    The file will have its original line endings in your working directory.
> 
>    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>    *$ git difftool -d*
>    *fatal: Cannot open '/d/Dev/test//Test ''inch.txt': No such file or
>    directory*
>    *hash-object /d/Dev/test//Test ''inch.txt: command returned error: 128*
> 
>    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
>    $
> 
> 
> This issue is inside V2.10.x and V2.11.0.
> V2.9.0 is working correctly...

You say v2.11.0, but did you also try the new, experimental builtin
difftool? You can test without reinstalling:

	git -c difftool.useBuiltin=true difftool -d ...

Ciao,
Johannes
