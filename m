Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD81A1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 22:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfIIWvY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 18:51:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:47231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIIWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 18:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568069477;
        bh=mlXWbkfmwDBBua143r/Ms8m3MSjrYn5bTJuOe/XsAEw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c4QVKOmnU4VTUAUgHztx8DoENBBs7XfXjsDxRNPE7oSFvPKT//7mGNJpF/MrL18Ff
         EhumJrl5pQhxdGfoH0itb6tC8FvdklRK0ZVRzNFtrWTTkFcYW/cDf28AIrJpOLuRN/
         rxuuhZykfvNuJ+s5tvuHc6xHfnjWc8a++m/f6h0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LinyL-1ihtiS0fSX-00cyeB; Tue, 10
 Sep 2019 00:51:17 +0200
Date:   Tue, 10 Sep 2019 00:51:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install P4 from package to fix build error
In-Reply-To: <20190906105825.GD32087@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909100049180.5377@tvgsbejvaqbjf.bet>
References: <20190906102711.6401-1-szeder.dev@gmail.com> <20190906105825.GD32087@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1678146039-1568069477=:5377"
X-Provags-ID: V03:K1:DAyO+cvYglMQB3hsAU36qcGXEWoKr8vrtgoDYJFie4BYFMcKq99
 zu9B7y8ywbs0iQGqdDAz2FmOSlGq8lMXYTFd7SfInzlEYlj2ULVjlD8Rq9j2wygIm2NmAI+
 CPPugcESVmdHovsI0HufwK/nq0yNmOhROsESN4qSXygGyofe6lwRrjPrSUr7U7eZp9LUw8x
 gUkQPSQqCjIFNSwRNXZzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ouZD6KOiSNA=:kGcjIRgRvkjau7fDiY1kDr
 ryf00V+P87RJCPqfviOIhdj0oO98G20GB7dT180onV66vOr+2H3XHMzx8aWD9KorfJLy9yD4E
 ivqF2fX4JI5LAECsU5e2eyaBmlkQPQkswoxLZ8+RRKebC7HItpRyECDfzRR+c17k6rnrqq2xX
 vGBqKXtIaG+IKZgdOY+a3pDp6iTbIhB8DtnwqgUjFGrYAt034uwC5FF4+q6HwWBnCnJAjNxnu
 Uh42kjBVLgg9qg7MMTu1qhor+ihSRXusMGAwJHhKaQx+yFNppmZuC+UBSot5dHLQqi5K6SyHL
 QV/zK7FmvALaUoAxJMYWpOHQ5SHVKTYtkIoXRenBUTY7FefEG1d6i3XnG1LfURT4Ogp+KCKaK
 VLMWVsjciEcKY8txRoF0WiXxnJqCqxDoxMU0jwImbMpIr7F0GGS2L7L0poXAx/HDOkFye7y2C
 Xtuz7CZiTUHgbFws3pkP7SYAwdJhocbiNE85I/M3cNXw5OOY9UwvrbtmnJE2eMDC3peoO1rXl
 ime+8nryrK9B8tITVbZO2cOIyDmm3aF+Q6LB0mkz3e5SN4RCjtKSQ39ax99YDtYljMavDmWnz
 IMZUeGcMXguw8N6YvosCDVk0hxZaZ/8VWfSH65lP6fqB2hhYueXl9hR7p7unAdvA6TVdt2FO/
 GG0ervcbdzr/2lspDY7cT99E11Dwtu1NxEqDZWAtrJUjVzX/id6quBhCFSN7NTIANuYMFQF8E
 zy7gai0Xw7O17h9mxQaHUDUm96oQSR6EIChu6XSyucVjY0bIvskw5aUga6A58uMggIRA1x9Uw
 aHMUIAaVV4twzu7xooOWiozPDTfx824x2SlOUIv3+jB3v0kPLHvnP8sYqRytWLEEoCupJ6d1S
 glsM/zdIGYx5oMa0JX+raoeTX5vL2xpb+S852SUxt4tNGIQWwl2SSUY8T2c8gH4p5nrPdK/Dq
 OWQe+xq/+V7B+bdaifZlJy/vFAOIMe22eSOhymckRqGzgejMyVc5zh2WMi9FRqIISzicYkXAK
 tze8XzGIpseRrieK8VCd3khnDzj/Wj4ptjU4XFuEZJ+56hkQG1lKAcOANbFA9mhZqcy7nLyWV
 CDfHGP7TiXCucH343MAnxh8f/uNN67gQndd45K2tZRHjwS26K+XBILxOMZPW81g4TNkJkw8mf
 JqMgFyc4qCKrFCfgB7lY6Yb/cj0ZI/0vywdo6Ab/1ZTwOzN70eUuVJr2JcWeBTT+kxZghnndt
 eLWgAqTNGmflZwwaP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1678146039-1568069477=:5377
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Fri, 6 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Sep 06, 2019 at 12:27:11PM +0200, SZEDER G=C3=A1bor wrote:
> > To test 'git-p4' in the Linux Clang and GCC build jobs we used to
> > install the 'p4' and 'p4d' binaries by directly downloading those
> > binaries from a Perforce filehost.  This has worked just fine ever
> > since we started using Travis CI [1], but during the last day or so
> > that filehost appeared to be gone: while its hostname still resolves,
> > the host doesn't seem to reply to any download request, it doesn't
> > even refuse the connection, and eventually our build jobs time out
> > [2].
> >
> > Now, this might be just a temporary glitch, but I'm afraid that it
> > isn't.
>
> Well, now would you believe it, while I was testing this patch (I even
> made a gitgitgadget PR to run it on Azure Pipelines! :) and touching
> up its log message the good old Perforce filehost sprang back to life,
> and the CI build jobs now succeed again even without this patch.

Sorry for being so slow with granting you access to GitGitGadget. FWIW
_anybody_ who already was granted access can issue `/allow` commands, it
is not just me.

> > Let's install P4 from the package repository, because this approach
> > seems to be simpler and more future proof.
> >
> > Note that we used to install an old P4 version (2016.2) in the Linux
> > build jobs, but with this change we'll install the most recent version
> > available in the Perforce package repository (currently 2019.1).
>
> So I'm not quite sure whether we really want this patch.  It depends
> on how important it is to test 'git-p4' with an old P4 version, but I
> don't really have an opinion on that.

I'd rather have that patch. It seems to be a much better idea to use the
package management system than to rely on one host, especially when said
host already displayed hiccups.

Ciao,
Dscho

--8323328-1678146039-1568069477=:5377--
