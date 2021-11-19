Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ACC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF42761221
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhKSPwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:52:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:44791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhKSPwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637336952;
        bh=eb5cH7Pn+zQc3S44x7ZgJ2Uw8wbU6L76xpLQnM9Lufo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lGulvr8xQn8mAUwciqwc7MEWvOZExvze5hWK6bwTpTWECI+1VMqgaQDOTXQ/+qRP0
         54lRd0q/drdoZkAhRuJG6whMOt1Zj+SophVtnAEgyn5S/6r6ifP9rW9iUr2Dwx1K+W
         WgRVniRltQTsoYMcSAC0v/piIQUIpXHFWCsocVVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1mIO0R1Z91-00nUOh; Fri, 19
 Nov 2021 16:49:12 +0100
Date:   Fri, 19 Nov 2021 16:49:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
In-Reply-To: <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111191647100.63@tvgsbejvaqbjf.bet>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com> <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com> <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com> <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet> <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net> <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZUp2jdfK7BEhJL+fVazOR923GFNw9GKbYWnsNB0OSgOpH2ZO1gW
 PpJz7kV123gd4z0zgtedHy3mgWv3GLo46Pjpy+o1AIShV05xUSFHrcoWn9UGsxiSVgFFefv
 lYCcyAXG/suu8zz3YodvLFwEACE1XFSECqlE6uAogufmATx2Yci9OFzFGF3aGUqIFYd4MJM
 5L4fEzF6C+Zj5vNy+zvQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42vQleZLPg0=:caNmU2HBtj1SGnn5G796X6
 Z5tejRoFfBNpMnES8pwQ7Yu42f371f66QlW/y3mtaeGq4e3sAFBgQf3hTo22+Ny381tbgUb9M
 H7d+KxdnWbhkAY5ZiFyn5TFCYGjEIYSffzgARK8A6bujqK6FqOPVgF7RO7fR5ZGH7LbNV7+QN
 SzuEOyh9EFxCJUcKa1XJHmlCdQhVj3Z3RzF+fZxlzcL7XPNotfrCsS3gx9HefrrSA76l5npAt
 9d2LqnYwlvctDtstUHkhGpHsSqHFSrAPE8nhBISSoZZ7wAKnC4m3LJU58CXdJEMoTBPdMf3zS
 krQE07PPISzUSqlJrQLLdpoGGah4cDnu164gk9LpieQ0epuJxizXYtDFRQQAHVCRmJ7ab7i4k
 EK4pWFfdmfG4I199zqkapNaEO2JTNVHp9tULntGvTyxqPwRvT1XpPINFpLpn0HffEB6Iu/4vS
 FXruvJlVsaV7HN0EdXLkFeh5yPXLbu7hjoY+FRmAA7o2arVhy+RPx76J9iDYFxwlothaV+sr2
 Q10Vb7nCavHP1FhPzWDIn0+5l1b/ghahztACEOU6Ia9CYoced4onPMJfhPbjeH1nkfN1C5Guf
 /wBzkZNZbm4GlaS0T6qxZMyEPhzQPsT3fD3+RBWxw8nYSEprieNPHzkgDf/IzA6GSUsGS19qq
 yqO7bgtY2wBNeH/2EZyXC2jqEbQq8xWcZY1/y0z978/nJx3CrN7OcH3OvaBMj+l6zAxuFj+2+
 m7rGR82xmK0OBpBM/rwd5kieFrKPVsuK8Pa1ViZWifec4412hxSa5ej9IeQXPgsZtOf9/8eU/
 yqWNiTQH17RsVkczf6JyAk1xwKSyDaqpPnpF1sTzsVrAT/hNqhlGqETo/ZwgboJbyAgA30G02
 g5vB01D6i7DnkxGx5uZ8ILBKMTYb/EHEKhahsrKVLFrSenR7Ek6eSyvvZ7wlnWiCMsxHbh9C8
 UeY5Y08NdfH/XJb17dx4eSwbXFHa4E614zMLz5O2w5mi9PqmqgCoLEHSRrWIo3bnpbDabaJp5
 JpT1F0+toCnisBY1EQMQpQdO4ltbTXYPkoMXRml8eW5qZbBd7BeMnZTTVR/OWmcMO781uHUn0
 /eF7IjXQB8Vn4k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 19 Nov 2021, Phillip Wood wrote:

> On 18/11/2021 15:42, Jeff King wrote:
> > On Thu, Nov 18, 2021 at 04:35:48PM +0100, Johannes Schindelin wrote:
> >
> > > I think the really important thing to point out is that
> > > `xdl_classify_record()` ensures that the `ha` attribute is different
> > > for different text. AFAIR it even "linearizes" the `ha` values, i.e.
> > > they won't be all over the place but start at 0 (or 1).
> > >
> > > So no, I'm not worried about collisions. That would be a bug in
> > > `xdl_classify_record()` and I think we would have caught this bug by
> > > now.
> >
> > Ah, thanks for that explanation. That addresses my collision concern
> > from earlier in the thread completely.
>
> Yes, thanks for clarifying I should have been clearer in my reply to
> Stolee. The reason I was waffling on about file sizes is that there can
> only be a collision if there are more than 2^32 unique lines. I think
> the minimum file size where that happens is just below 10GB when one
> side of the diff has 2^31 lines and the other has 2^31 + 1 lines and all
> the lines are unique.

Indeed, and as you pointed out, we already refuse to generate diffs for
such large amounts of data.

(For what it's worth, I totally agree with punting on such large data, it
would also take too long a time to generate diffs on such large data to be
reasonable.)

Ciao,
Dscho
