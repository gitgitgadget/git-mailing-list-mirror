Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06527C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FBB20671
	for <git@archiver.kernel.org>; Sat, 16 May 2020 14:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MfuXrVvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEPOKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 10:10:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:50365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgEPOKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 10:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589638240;
        bh=rxPpLqqSnt9Cm4jZe2QKLjvxPqPQKcVBLo5awneuNv8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MfuXrVvYj7ZhM36p17d0BzlvS/24WEMjqGPfeSjU5ZMB0tV5jVdZfhKFwU5hFZ2AD
         t8gQeH0y+Es6wV2Nb0mRrv1IE99bQQwSRrWEOYADDHBb7pol0WbMo5srEbqjCT6k/z
         kmqVHX+EcGcDXAgnaubkVsIdG8qoK5E69XijRbZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([89.1.215.229]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1impG610a2-00nAyw; Sat, 16
 May 2020 16:10:40 +0200
Date:   Sat, 16 May 2020 10:46:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.27.0-rc0
In-Reply-To: <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005161044580.55@tvgsbejvaqbjf.bet>
References: <20200515173242.6154-1-johannes.schindelin@gmx.de> <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VZPhE72JoyW/y1C7udRuOh72RUEOSr4IlW5Q71c9vc3Hl2Y0mjc
 o7Bqozc4nC9s1LdabUxscLnnVMCXl/FUE66KF/XExf+gXMIpZe41Aq90y5QntSvUIYIxSFe
 JPXGrZ0QiRXgpM2EXGUEMe4vSl2S2nMMkEewyl7+wMdybrZLmNwf9ZRII5ySW79pmms8+bn
 oUUpJc5l0y9jIEXLmSxJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+RmPAzwz4o=:AxjLWLRr478ydBtg1bI62L
 BEGy6iXrTsw79m+REhZMTH/c3/6P+eJ9rPPQUgDAdcqBsq76m4W81qQkca7azA6WyXOoHS3sP
 ctxz4Fd3wExxlBflJloymrjg/UM4eLlB2r3f+PY4mf11AXZEAOv5K5mdciwCi5SHh+SBU0qK9
 aKxLYNQPnBOOfCmK5cJ7a6zegR9kOd+zGoipogiG+SmWuj+raMBqKk9jaKPIJP/WGkJ5voRc6
 5Ej4yUT0qxJ2ChKLok99emJ4/75XOTvfNEe8pOEfdu53hH6VWkY5KwBqLBBjNG7LhLMfplQXd
 4QLX73ZivwUCWaemeiFRJCEFZLPNLFeGDVSRwV6YeIVL23KCbVEeQBUDJ1opirwBoNRtxFT2d
 JWJXVPorwTNj6LDgkV3R164f1cccJBy7WBZMy0vOLYhSbjVGFi7g3efYhG3DiBISdZhCG3o0n
 i8tJmK/O4W7izqoHfQXae8q7iTrDY2lZ4WNO8uhbDy1UnD1fcXL25HPmB4KvJagrRMokWO/AM
 hlutrHrg2vpn4ogVBQU1Sigk4c4B4VwZfa3BJQBakrZQ8jLzxBRXMZT+eVYsvG2cxThPOdioR
 HdApDVSqAc2WyQLRFDAf28Or8NwbbJbO+QPrf7nMZI6b7S+gXEIy6wLuXo+S/tekJkrJIeN5V
 6RMX3urJ66YCKLtMyPgId0BkKUeW22o3HmmhR7VLRZCws9qVp/2AmIArsibABEWQ3YYO2kwnR
 Clubrm1WbBMOpnS1HMpF/Asapj3yIiCB4S9VJR+KvdtF+JDq4jU99RAwdZjBI+NssXdEDzHM8
 eaL4/chVsZ3mwy83K108wpMol0AkaoZZl8QSrHpGY/Xk1/UP0FnZgrtxa77giXHWbnqNJ4Rde
 QZTRk4gpIHskqMzOp5+4+8OI5E4LjIq2w14Sa4ozHy85WvM8A6+8Xlt2kSZ33XuQyq/qYYks2
 d1lKtxqoH/q8TCdSmCN4K4YNQofqd/cJTb28LC3g6+7SYvyLkrV+dIQxQAdS2cnZK29/ddZ+M
 AmvLbACP2XK2M2R96qKFaB0JL+E+vtN4ybcNnrEOIwlaACpRmi64KUkqATasEd+rj4FdRGQjm
 5DFVfGr37gkrtjOLK4czL9pwqqu4FakqXBqHdYfqQbm2I9LUyLlFlsLxybYYGizL28kl8IRla
 sq3r7ZkMxbPN4QpUE4y8OZSk9SGwWjvgSNRcVj/J888lk1ho+PeXkrqxiEhP1PajSt3pYCiW/
 /uvOmg8kmO/H97lYr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Fri, 15 May 2020, Bryan Turner wrote:

> On Fri, May 15, 2020 at 10:32 AM Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >
> > Dear Git users,
> >
> > I hereby announce that Git for Windows 2.27.0-rc0 is available from:
> >
> >     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc0.wi=
ndows.1
>
> I've added the 2.27.0-rc0 release candidates for Git and Git for
> Windows to Bitbucket Server's test matrix. No failures to report.
>
> Thanks as always for these early release candidates!

Thank you so much!

To be honest, this time round I would _really_ like to ask for some manual
testing. I upgraded the MSYS2 runtime from being based on Cygwin v3.0.7 to
v3.1.4, and the biggest new feature is support for those new-fangled
pseudo terminals that Windows 10 now supports. I did find a couple of
rough edges in my use cases, but I am not exactly a typical Git for
Windows user...

Could I ask for some manual testing in particular of anything run inside
the Git Bash?

Thanks,
Dscho
