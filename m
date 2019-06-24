Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337971F461
	for <e@80x24.org>; Mon, 24 Jun 2019 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfFXKkv (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 06:40:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:51287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbfFXKku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561372840;
        bh=gEhfqkLvJnV2WOTaBdpzDlvvh9wVTsNafESvImnZ0OE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HNINH+ttp1e335UEnXy85ePFtxU7+/Mo5yMChq6G2Klk/c/El4a6mUAR1IOdt6veS
         CVpRmfn/+NcAxG9k4zQ/2qmuJyxCpD7U8c3KB0OfdsIZLEknHyDAnX1s2uQp/Qg1/W
         i/7xgGg7E6Mb8wlUnRA70TBpwwBfdLwEfXf2+TWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MELdk-1hlvyC18fo-00FSzY; Mon, 24
 Jun 2019 12:40:40 +0200
Date:   Mon, 24 Jun 2019 12:40:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: windows: error cannot lock ref ... unable to create lock
In-Reply-To: <98e1e1e5-c410-caf1-0e2f-9cb0cc6d7e94@iee.org>
Message-ID: <nycvar.QRO.7.76.6.1906241240450.44@tvgsbejvaqbjf.bet>
References: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com> <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com> <98e1e1e5-c410-caf1-0e2f-9cb0cc6d7e94@iee.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0as3AkqdGfL8HcVrHXkFuCBGZnvWd9h/5jlDOepUhukc6AEXslE
 MHXQgTNL4hzAFXhH/04ljsqMsMDDd8vv8s7Q82wXA/1WGeqfGBsP2u6ui6sOtszni3XLPyg
 d9QtionSifipfUV5iS1PHD2TynvByFog14Vtuj9fHav8SbKU+xiHkT79OOLIZktsVpmaFjk
 wX90O/t82kp6mxZpCe1Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ty8uJ7MogJ8=:Vbb4bwuEMBQgBlWhwemRYj
 1uMaa3AlXaKFX6ByDmRPWb6WX4m6f/q4RcHEQbhjMkJEKOc0ITx5NVrifKTLkLPGVjMMakdfE
 Brsb7vyDLJIX516MSEjQgTtA25IveCqsdnZe+LZtzyrRhG9AKDczyS76z+0OA/aIoc1n/3lUy
 1SIdzks+guSNUkI7ORrIUR+5uTCSazyNZ9XjwYtMZQGlxmVII4j1iqRdpN/1QvbrNQRGP1EXN
 SwGc0quGKAxNj8+cpYEySfGqoCZexvD9s0so57VLhdR0ZZzRzbTKP2LeCgGhcg2odWl6qxyS3
 IL4wZHL9dyiqrqusIAoHdtcxrfmJjlV6r6gUJdNplxO3e5XrpNMaMY121g1lUVFfQCdPpb9Z8
 e9E/h+KFtMkJkqLnDPrQQrpNz/196rQM1Hhz9IoGxUL4n5r6yYIbXuhve3z9MggmgxqN5uSiu
 caemeGUXc6XbgpG6PUN3QnFgWSBF8YBrVHeAIapvBlAUfcGNMiN8sjwQtTKbUi5QFCysf5iDf
 /DOkCar2j7FyWYoYuZfjTvbWsIw93HgF4G2/Z5zA4VdbaRJuSSsPD/MVbrO+ZMsbaEGn5cn18
 kINljptwkPuXQugOI8bDiZgGm9BczN7UWewlyDaPhvm4y5vtAUT8u7PyrLIVHag6A4LCzq0lQ
 Je7ayCGOnMJJAS3QeisJjyYlgQHjCSBrdFmpSUQ2k1XIxmaZLLNc0DvB4oFYJdOxQVa7s0Rae
 Zrwx4po18JGGb4no2pGmbG+t5y27ZEKtyKPCwBRW23aWzTpgxQ4y9TiXKIOJNYzSqBgY9pJhU
 KFmtpBh+NPxjMmeAwsA7SDkJF7Oi0GO+lpVzw909lBNvd+fBKUOwLTk8IcxmGxAxccwShrbjm
 +LTmx8a/Do/ve3lACl5CVplFFNLjcTjgmBle5DFpoTO4o22+jgBkAwiJy6M8qXXxkagYBQm9H
 SZXhnsaDCF21v2TT9rkvTISMceE89IgBGW9p2PNNe7oDBF67kgh9q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, 22 Jun 2019, Philip Oakley wrote:

> On 18/06/2019 18:01, Eric Sunshine wrote:
> > On Tue, Jun 18, 2019 at 12:39 PM Anthony Sottile <asottile@umich.edu> =
wrote:
> > > + git fetch origin --tags
> > > Unpacking objects: 100% (10/10), done.
> > >  From https://github.com/asottile-archive/git-windows-branch-test
> > >   * [new branch]      master     -> origin/master
> > > error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to creat=
e
> > > 'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
> > > file or directory
> > >   ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update=
 local
> > >   ref)
> > AUX is a reserved[1] filename on Windows. Quoting from that source:
> >
> >      Do not use the following reserved names for the name of a file:
> >      CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7,
> >      COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and
> >      LPT9. Also avoid these names followed immediately by an
> >      extension...
> >
> > The default Git "ref store" is filesystem-based, so a branch named
> > "aux" is problematic. Other ref store implementations would not be
> > subject to this limitation (though I'm not sure what the state of the
> > others is -- someone with more knowledge can probably answer that).
> >
> > [1]:
> > https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#=
naming-conventions
> This sounds interesting. I thought (but I'm not certain) that Git for Wi=
ndows
> avoided creating files in the working tree with such problematic names, =
so
> that a clone of a repo that contained a file "AUX" (any case, any extens=
ion
> IIRC), would be bypassed with possibly a warning message.
>
> However this looks to be a slightly different case where a _branch_ call=
ed
> "AUX" (lower cased) has been created within the clone, and it's a proble=
m not
> trapped. Maybe worth creating a proper issue on the Git-for-Windows repo=
. Also
> cc'ing Dscho who may remember better than I.

He doesn't ;-)

Ciao,
Dscho

