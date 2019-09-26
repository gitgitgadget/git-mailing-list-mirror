Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3665E1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 11:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfIZLmh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 07:42:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:53073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfIZLmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569498148;
        bh=wvrS9oxjoCm6O0U9DzBu1gnSwCfYgXUJ1jneVwD55I4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DxooFdvSSQqeN7eI0K4Qt689jmKQl8ksJ01bMQgLZgUQBdzN/l3oe02HdZMp53Edx
         jit4i6k7vrLQUmSRgUJSfY/wggM0OjfglVXn5mrAgcis/o7J9zL4XjoJzjsPgmsmcO
         0bgE9gOCxUM0FhJ5gkFddxjbvp1TzQgXy6uTTRKs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1hmsq33xeS-00iGd6; Thu, 26
 Sep 2019 13:42:28 +0200
Date:   Thu, 26 Sep 2019 13:42:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190923180649.GA2886@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909261341300.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190904194114.GA31398@sigill.intra.peff.net> <20190923180649.GA2886@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2038308231-1569498149=:15067"
X-Provags-ID: V03:K1:uUBF+1IxNddQEvA92D2GTY/kx4NqlwwfUHM+hJB6ectvGMJnkRy
 wfDaNWWkS3P1e/zpQSmv3+A14y/njs1Kz+fpZqjsbK83KSQVo2N7XKv6w+BN43GE0zobL7f
 U8jL4tFqzrFzzOryeB4zv0hCyb8y9a/Gl20URAkWk/nEMv+B+1QL06e+ewDnG2FBqLzO0zB
 QNeheZHOc6C0c2aqv1whg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AG+KdPnMCkU=:GSioMancvkffvPq1vsbikw
 pKGaCtLBihwz/XdKeV19VnOgbMHRqFwD0cQsdpjSOlk/h71MJsSZrt1YIfh1zCTgQRav+ZCav
 HMtVuI2ONDNFsHOLQGbZH7iPj7nYBi5hWXwBGJrN5tmPLvdR/Oy53zMEEfGpUkPkJg8KfU24C
 MeFGTqmSsKCFJukIVJIE0MA7cW0/6gF+POttXDfMJQDsskJ6cHxU+TGZwb1YjYCuzPm9F0cCD
 cHA3hMgixdcXI2AuApy1J5Csneze4vZgATOo4AZBKGc2VODjFFkrXtGo+gVOW975S715OBVbR
 SC3jy+2FypkdVLk4m4FwxDXzZKziVgUx384l0XdguNk6VIdWBwWWkU6cdLYFvW50HnpJuyV6T
 Feb/jPK+UB9+RS0BwSZLhFADjKEjvT8ENNoRDxD3VB4oBU3T09fxvOpi+6cDOKBS7+xHElKfe
 jNH0kwB6IYmJpslFqmAzAx53hEYqJdjP34e5DdF4O2D6A4QKt8kaC9C8iJ9yhcYKpf76jiRE5
 +UwW7q98TexKcTvTO2UFZnVo27SFEd0nx8Qi36jZhNordmIBt0iQgg/UN03Blq97azi8ROdCS
 Gi/AkjJWg8uXSJ1v4zB2OYiY4Qy5rROqF4Yi+GMHgM1SvpnWX/g6OZRMlClRV4ES1frqcuhW0
 BF3sD5G2u3y9plUdkKLOtglnMAbaS80Zs7pNaBjhW1dMEEg6qF/4HU2jByWidHNYTWa+YSXD1
 yh5CfUSuStylKZS6hTKtLHGKh6NSJfNil9foNoeo60xS/byZRvyQkldAI0QcOvDljIXeWXMVw
 d6XnWP33WlZCjQaEkWpq2ub/dcazoBJNWNLAvWETe2wVdZ86LDm3HNt0CfMbVAFHzf7NNG6PW
 Puebl7BBDWFaiL1KRiHKUOmL4nI4MQIon5KoCrH9SMSju7loYb9xqZ9qa3v5wK2flfMc0xtDO
 g4D3G22h9Kwzkw+YoKqFCB5FED1zPFZtiKneeqbm5xngfDCVJTW6sz0tcoWH4u0uELu/Kksfx
 TgVxjd8pLYZB9FAiFZEEBjV5KTkLZq/RDegpyqqNepe3Tt1l/z5MwTTUbXCmzDOhj8xA2Z0jh
 mW5SBnwYkfnaa7xfgNZq1v5LVaMRItkSAzQJPFE2Fy8JC595WMtZf1YgCl1mFJhSbdzAsdZU5
 1ZmPwFrnjYgzStSIwpLasfAqiiv5ctOHctQVK0iBV3aSG9kb8EL1pjvXq+z2UzyIIA9rdl9IS
 8Bxd3kX9yDDvtDrO4Mqox5/ehnSbBXW9sNV3KKeTCMFEA8kz+gKO9LuzHcGY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2038308231-1569498149=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 23 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Sep 04, 2019 at 03:41:15PM -0400, Jeff King wrote:
> > The project page has a section to point people in the right direction
> > for first-time contributions. I've left it blank for now, but I think =
it
> > makes sense to point one (or both) of:
> >
> >   - https://git-scm.com/docs/MyFirstContribution
> >
> >   - https://matheustavares.gitlab.io/posts/first-steps-contributing-to=
-git
> >
> > as well as a list of micro-projects (or at least instructions on how t=
o
> > find #leftoverbits, though we'd definitely have to step up our labelin=
g,
> > as I do not recall having seen one for a while).
>
> And we should make sure that all microprojects are indeed micro in
> size.  Matheus sent v8 of a 10 patch series in July that started out
> as a microproject back in February...

Indeed.

> Here is one more idea for microprojects:
>
>   Find a group of related preprocessor constants and turn them into an
>   enum.  Also find where those constants are stored in variables and
>   in structs and passed around as function parameters, and change the
>   type of those variables, fields and parameters to the new enum.

I agree that this is a good suggestion, and turned this #leftoverbits
into https://github.com/gitgitgadget/git/issues/357.

Ciao,
Dscho

--8323328-2038308231-1569498149=:15067--
