Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18D31F404
	for <e@80x24.org>; Thu, 30 Aug 2018 11:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeH3Peo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 11:34:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:55801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbeH3Peo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 11:34:44 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxxKu-1fpeAr3fMK-015GTX; Thu, 30
 Aug 2018 13:33:01 +0200
Date:   Thu, 30 Aug 2018 13:33:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Piers Titus van der Torren <pierstitus@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: improved diff tool
In-Reply-To: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808301324120.71@tvgsbejvaqbjf.bet>
References: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LzEDZsfs0Wi1xm5fM95h1e6HqQfJYUdVtuuPahFcW+HX3UNT5gQ
 G9jY9tmy+BdCADndifJzYRXzMMkVfDSiN7VRIGHOTfXQiOfXdcCbvPC6aSfsQzK86gBqMOI
 49FOZ6PXWIHMXb58LIo7gFXGaqWF9YoPVQ4fz1663I7veRBIFrBBPCIVPeX5DA41Omcueg0
 YBr0Dh9Ny1JBWSB/5u7Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ufp9634nNRA=:iHzqEl+DxwHLyRNtkZBTgP
 +JSKNhw7wGIDVf/o52LkLr6ZugZ/zuwsHUCY87Ek3b/CDQI5LnHsiMo6m5biMAUSVCINBFcg4
 n3FzL+vWQAZQ8W9b0Ajnk1Ry1032HqX5auYtkLk8/UgKvwJXK6lMMHep+oMPc0cyh0g3irVzZ
 1BDdWlrMtZbcs1zEDff85IdVDaoW1M3r+tYXm0aohvAu3xFQyMhI2FVULmmJcL9rCohDhF0xu
 ww1wJWo228StgVtIFsWLEQGQTRvwRJS4LkJckGLmbhlqDzBsR53Dw1oGAjyGXgAFlz9iGvGEr
 d71K1E3pDYhVOwh3iItbtG+HSZfHClyTDccH+hlbVg0+5hrqSYIVXiJGaMVXlUYBxOvT2mac3
 HT1yPpEUA8iAG9MKSMXX08jeY8Mh4Rybiw4lMQg1BCjMTct64t/zyUckAQ+ASnd3lHSEF2RiB
 HP7kfsJPDQ0XCiCF5Y3EU3yjZVD5K9aHHFhIqw/2ulZw1Oxx3N3ztvaaSw0paU70bNuwmnaXJ
 AYh/IO1MbGj3ugt4uR/7HYfBbFwU/gDthronU6vQc13NsNCdKHPmCN6cjIGcKitKtaWOLo+WJ
 sXU8oVnmfltDFwYqYFtGLIiteqkR6WTCApHyStKfWkFiY2Mj5kk2RTsM7Ki1E5bxUIfsXitX8
 oMA4/WtVJRdLKYCAOdOXL1BO9NJMH6DUjLEiij9pnL0SbX7I/CGoB81osFaSQyFLwpF+OacV+
 lXysr0hHd6L6yZndUcOHF9zMVAuzirqJru9YsuNDut6nWQnTojFkp9OB/Yg0fHw91Rhtph3DX
 QhoUqvv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Piers,

On Thu, 30 Aug 2018, Piers Titus van der Torren wrote:

> I've created a diff algorithm that focuses on creating readable diffs,
> see https://github.com/pierstitus/klondiff

Looks intriguing.

> The git integration as an external diff command works quite well,
> though it would be nice to integrate it deeper in git, and also in
> git-gui and gitk. Any way to use ext-diff from the gui tools?

Git GUI and gitk are both Tcl/Tk programs, and will need quite a bit of
work to accommodate for your diff mode.

To put things into perspective: the `--color-words` mode is not integrated
into Git GUI nor gitk, and it has been around for a while...

> Is there interest to incorporate this algorithm in the main git
> codebase? And if so, any hints on how to proceed?

The best advice I have is to look at the `--color-words` mode. It comes
with its own "consume" function that accumulates lines from the diff, then
outputs them in a different way than the regular colored diff. Your mode
would want to do it very similarly.

This is the accumulating part:

	https://github.com/git/git/blob/v2.19.0-rc1/diff.c#L1886

and this is the display part:

	https://github.com/git/git/blob/v2.19.0-rc1/diff.c#L2013

Basically, I would suggest to do a `git grep color.words` to find the
places where the `--color-words` mode is special-cased, and add new
special-casing for your mode. Which, BTW, I would suggest to find a
catchier name for ;-)

I have not looked closely at your implementation, but I could imagine that
you might want to have at least part of your algorithm step in at a much
lower level: If you can use the patience diff algorithm itself for
pre-processing and initial diff generation, that's great, just force
XDF_PATIENCE_DIFF; Otherwise you will have to implement an alternative,
similar to https://github.com/git/git/blob/v2.19.0-rc1/xdiff/xpatience.c.

Ciao,
Johannes
