Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49CC34026
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5045F20578
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="G8LyBop3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgBQTiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:38:50 -0500
Received: from mout.web.de ([212.227.17.12]:44809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgBQTiu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 14:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581968327;
        bh=sDk4d+s6xw8CF2Xx2o4MSQNEHlLk+EP92zwOWP4w+4M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G8LyBop3Xa+nmlD4RWMa/kQWfePwexKZIuTvFGX/wcPX5FBDq3DmggL70CaEbSQMN
         SM66iLQxPH9j8nSbm/YJqVZZHr84GWJ8JDSj1Q9hZ6/eCQj9k1BxRuWQrOP/mbNeyj
         1CdML7PIxB3YfaZWqYoUjNfdJJlN2oAScb+MtJRY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqFo-1jW8tT1SAa-016NyT; Mon, 17
 Feb 2020 20:38:47 +0100
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
To:     Manish Devgan <manish.nsit8@gmail.com>, git@vger.kernel.org
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de>
Date:   Mon, 17 Feb 2020 20:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1y4A+bCsMpUiFB1ekl2biNP9jPhOA00s+A+tNPk2ES63i8WGjZw
 qtlMVSuLuiKB/g+QOGggOGv6wOon5yyXTY2H7L6SqiGid3kyEbNLpmrhvPne9/o9hXZfrPb
 r4Qu/BGboW94TJQDGHVLKJQLP6jpLlH1ZzES7LPr/vhBe8Tik05Gx6tcl4B9/oD867VkOOk
 jYNl6jEw/noaEo/bDB3GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NB36cqTj6is=:eSefBGIRd1q6ldLJ2lcfPV
 KemJ8I+zwQMksCLVQbw1FlGXPS+GYRSwuAbPvIUYbHPSXBDa9IUT+zGUFocTlZJQE4GZU3Vns
 buxqxqPKce5rOTzLJldmk/61OAgYwIBYn+pgTW/mimajGYswjR3d57hBxVBkWmzx6mpQX9hRR
 BdJRRYvIKtDquLB8ukxnZqRBTPG8bL0ezSSAL7rS2ZAgvbl88MW3xD0RbWwbvTFNtuszztKbE
 nqeVmYkRPQuP+UrpJz59aptNbUme+SSyl7L7MI4R2MM7J70zrjh9OnF1kkIDcYrVPHrhA41nv
 i4MjzrHEbQNKX08XxSEdKGap+HZmCxYv0YUrVf+cAht2cpAjA+LTCCBaQpl9drr2cT/iwYd2F
 szOm0bjr4J4I5ujpZuTO4cj5aDpj3KTyh7dtnazXpUEDtuLlysWLii3v3RDGepkdLA3MSjHV0
 9cepNN1Ijq2QUaaollsepuz5ZmVljLBKzq5ov+kSpRGoovejUZtbzqonVvyWH4BzIOMX54Dlj
 nwJlJYasGCGogWLkemraYhYcIWW4PBwS4pYow5GSGUGAoiOKeOX4F+vSV94wOIke07ZoYZLPD
 +ijLt8b8lhr44e71THHay1+m4wFM5yYRotCBIgx1tKSP01JKFkxiJLv8GfffK2ggWNFUPIB6L
 s9v4erC7fd4/EQ2Ake7ZcaelrqslKCkolAn13FQUfDNFWAA7RU77xTnRl2WJnHgX31mpzTsB7
 ftWRIMt2mbJNIn9Tk3lUBZv+fFsRnMj3ps3ZH2xmfUSiUZfloQHBdZaaz20qwjTEARn2SQnNp
 RasMN2DGwxJEE9QR/ZfxkDC22j7ZyjGyOYsfdAj8NBcRIOvVSTmUa8Yi6rUTUL/QhY0zqu01h
 Q1wTO+0FsIn2wWbo1ONeaqKWUbknb0lSNGxOpb3pjqF45CVxVwYIsNQEhJtKvJAF8ow0P1PPb
 RVoELxcmLmJF34ukAgeNngPHV3BJr3T4g0z7Ski12UbenPTjxqrYppIdf8u6TubRohpTluGUk
 VF6CXKRTxrT/V8GGIPCnqYWETEvj+5ZWFn80SHSlIOgNTfaFUxJpq2wOvhHyYFc6bdc9QNAP5
 efjvPn2zAf9wRiQDuFZ/8HbnUrzXIq53/NW+tzingwwL4A1wdIMHrX+R6N40LvrWmwOzA2YcC
 sS+snIypjrZR/1mNtlCERVP+Uknqkw+iL8+rSsl/1yErKlgiKaK+BKbtWdisJr/wvWLseBNRk
 Qejd9HNt0lpa0oae5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.20 um 09:02 schrieb Manish Devgan:
> Hello,
>
> I am a university student from India and I was trying to clone the
> xfwm4 git repository from the git-url :
> https://git.xfce.org/xfce/xfwm4
> I was trying to clone this repository over my university network and
> it didn't work. I worked my way around by using my mobile
> wireless-hotspot for the same and was able to do it just fine.
> The next day I tried doing the exact same thing since I couldn't get
> an answer from our university if any such firewall was blocking me
> from cloning it. But this time instead of failing to reach the url the
> command ran with the following output:
>
> gabru-md@bhaalu:~/Desktop$ git clone https://git.xfce.org/xfce/xfwm4
> Cloning into 'xfwm4'...
>
> after waiting for a few minutes the command didn't fail but it didn't
> show any output/stats like it does when I try to clone a repository
> from Github which is definitely not blocked on the university network.
> for eg.

That doesn't sound ideal, but it also doesn't necessarily have to be a
bug in the sense that git clone broke at some point.  It could be caused
by the server side as well.

What you see here is the default output of the so-called dumb HTTP
transport.  AFAUI it doesn't show any progress (yet?).  You can get some
kind of progress messages by dialing up the verbosity way up with
repeated -v or --verbose options.  E.g.:

   $ git clone -vvv https://git.xfce.org/xfce/xfwm4
   Cloning into 'xfwm4'...
   got 9a2556cfeedcc1b73cea36e5045073ecdf9fd39a
   walk 9a2556cfeedcc1b73cea36e5045073ecdf9fd39a
   Getting alternates list for https://git.xfce.org/xfce/xfwm4
   Getting pack list for https://git.xfce.org/xfce/xfwm4
   got 72b002b0f028fe610ba22035453647001e886969
   Getting index for pack 3a53ad6629b13fd830436a47c59b86e29b565d88
   got 600cb96c7eed28529fc8d5d0383d58070cb30957
   Getting index for pack 9ef7bd53f4441a79be936132e1c4cde62f6fd9a8
   Getting index for pack cef42fa75f4badc8e7ece5fee5ff8068dc8ae51b
   [...]

> gabru-md@bhaalu:~/Desktop$ git clone https://github.com/gabru-md/stl-cpp
> Cloning into 'stl-cpp'...
> remote: Enumerating objects: 186, done.
> remote: Counting objects: 100% (186/186), done.
> remote: Compressing objects: 100% (128/128), done.
> remote: Total 186 (delta 92), reused 146 (delta 56), pack-reused 0
> Receiving objects: 100% (186/186), 105.58 KiB | 256.00 KiB/s, done.
> Resolving deltas: 100% (92/92), done.

This is the so-called smart HTTP transport at work, which does support
progress output.

You could use the git protocol to clone xfwm4:

   $ git clone git://git.xfce.org/xfce/xfwm4
   Cloning into 'xfwm4'...
   remote: Counting objects: 66501, done.
   remote: Compressing objects: 100% (16901/16901), done.
   [...]

> Furthermore the interesting thing is that I expected that my attempt
> at cloning the xfwm4 repository might have failed but it surprisingly
> did not. The command did clone the xfwm4 repository for me but it
> didn't print out any stats/output during that time.
>
> After searching on DuckDuckGo I saw that adding flags `--verbose
> --progress` will allow me to achieve the desired functionality. I
> tried doing the same and the output is given below.
>
> gabru-md@bhaalu:~/Desktop/test$ git clone --progress --verbose
> https://git.xfce.org/xfce/xfwm4
> Cloning into 'xfwm4'...
> gabru-md@bhaalu:~/Desktop/test$ ls
> xfwm4
> gabru-md@bhaalu:~/Desktop/test$ cd xfwm4/
> gabru-md@bhaalu:~/Desktop/test/xfwm4$ cd icons/
> gabru-md@bhaalu:~/Desktop/test/xfwm4/icons$ ls
> 22x22  48x48  Makefile.am  scalable
>
> It is evident that the cloning worked perfectly fine but there didn't
> seem to be any output on the terminal. At first I was convinced that
> it was network error because it couldn't reach the target url but now
> it doesn't seem to be a network problem.
>
> I am not quite sure if this unfamiliar behavior while cloning a
> repository is a bug or not hence I thought of reporting it. Also,
> Apologies if this is not a bug but something which is known already.
>
> I am currently running git version 2.17.1 on my Xubuntu.

Git 2.25.1 shows the same behavior.

I guess the reason the dumb HTTP transport doesn't show any progress is
that there is no way to know how much data it needs to download, so it
can't calculate a percentage of work done.  Perhaps showing a number
that is incremented with each GET request or a spinning wheel or so
could reassure users that git clone is still working?

Ren=C3=A9

