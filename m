Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AD61F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGV5x (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:57:53 -0500
Received: from mout.gmx.net ([212.227.17.21]:39913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfBGV5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:57:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKYpv-1graxf2Thv-0023dz; Thu, 07
 Feb 2019 22:57:48 +0100
Date:   Thu, 7 Feb 2019 22:57:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <20190207204502.GA28893@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902072245020.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <20190206184903.GC10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet> <20190207204502.GA28893@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m6lmFVbv+ocALa0hKVW9M0PgPNJ7BH9bHBn3Hi+R7VeNSnq6/YO
 PtsOfmnKyehOGZrvaY79HZ2LKFRjVvJnej6ysVAr1algCU2v+rKO/68NQRU40epJ/97Kdos
 U5sBL26WasDiMf92v36LOrH8xX5VhQT4NgYMbfsq1/6cBzUZwz+x4LIAxBKVJT704fV9KCg
 3IaWiyqb5eckq7K34p0Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KQlkHa5OLYk=:DcZFmbyJFpJU+qKEmwGm6w
 k+00H28V9+LEC5V3VkLyF7vgF7dh/PhkdvUbLGbTObLI3yaEBTUmVzwM+rl2eYY0XpDL/OiQy
 Ztg2U5H/bq4EWluBD48z2p2Vt5XBcyEe/kexb0YguB0krcxf9KfHzYehno0PzQSlUvFp3cGgX
 cp9inB/f4E9Rgz0859uoCBe2QZvgS+IKyeGYAonR2Nl5K8cAf13hF0i8qLcnIBmfNiyQIYp75
 BgfbpWdRpRceutyLv5RQYAcmbumyZd+KwMF8AFcULAs7UqCRxdN8lTsXMDUAXnWQv/b8S8LgT
 JTLf1dvQz7HMXqsfS/WlaSDfSKNCRy7y+mJkzyvHiGz33NCeT5HbllycY/L56t5HsxSb9Fj32
 uJLMC1KllmBqItzKGFmyTMSrw0ksN+fAPm497r/mkW3fZ6KnjnJEjAIh+CPQCxBrQkAXsk14o
 Wo8lj6T90h82Q3NA5gvMoKOd+60yxiNpU7/Q84CadWY/WxzG3Zpwh5yTCZygZgK0P3cQGe2RC
 qyzMTd329sAJfs9YUb2yh6wm6zxiV/WNADq+5hGH5o2a5zdWrfNzI/Co7VGUP8V8zn5v89pXI
 jGxshnlYWe4azR/ZUiSVjn4Ya9AUVkElVYnGlw78z7oDDHlB1MJKxA6NYWGCYvgPQP1BYPxi1
 3QsVEpQshbf8HcbNf8RZpViGCnBXmm9t1ifWQTMyXD10HxA3i5ZXkH9qcgEn3qusZVo53RTNR
 9NRSzz70WYsH+DE/g+olkOGOkaib+bAJJsCLwSOQ3gG1i8dSIC/l7gT1lcYNkdNVD1NpHTucb
 PxgP1czTpT7hTclsWSDYTb6xdqaTGe9mfNGDBws9vRSkhp8oxSjp3KjcqksPZSFE9Ruf8H6ao
 Q0jRbwnHf9vTivpaoZSO6KzFO+oN8NaGQq9SDEM89WtKb8UGSwuBJQNrHNCuflfhZrVegGIDT
 EqQOQabn2oA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 7 Feb 2019, Jeff King wrote:

> On Thu, Feb 07, 2019 at 03:26:21PM +0100, Johannes Schindelin wrote:
> 
> > > So IMHO this isn't really a show-stopper problem, so much as
> > > something that is a sign of the maturing test/CI setup (I say
> > > "maturing", not "mature", as it seems we've probably still got a
> > > ways to go). As far as notifications go, it probably makes sense for
> > > them to be something that requires the user to sign up for anyway,
> > > so at that point they're making their own choice about whether the
> > > signal to noise ratio is acceptable.
> > 
> > Maybe. I do not even know whether there is an option for that in Azure
> > Pipelines, maybe GitHub offers that?
> 
> No, I don't think so. Probably the route there would be to make a
> comment on the commit or PR that would then go to the user as a
> notification (from which they can then decide on email delivery, etc).

Ah, but that won't notify you when a Check failed. So that still would
require some scripting.

> > In any case, I just wanted to corroborate with a real-world example
> > what I mentioned at the Contributors' Summit: that I would like to not
> > script that thing yet where contributors are automatically notified
> > when their branches don't pass.
> 
> Fair enough. As an alternative, do you know offhand if there's an easy
> machine-readable way to get the CI results? If I could poll it with curl
> and generate my own notifications, that would be fine for me.

There is a REST API:

https://docs.microsoft.com/en-us/rest/api/azure/devops/build/builds/list?view=azure-devops-rest-5.0

So this would give you the latest 5 failed builds:

curl "https://dev.azure.com/gitgitgadget/git/_apis/build/builds?definitions=6&resultFilter=failed&\$top=5"

I did not find a way to filter by user, or by branch name with wildcards,
though.

> > Speaking of which... can we hook it up with https://github.com/git/git,
> > now that the Azure Pipelines support is in `master`? I sent you and Junio
> > an invitation to https://dev.azure.com/git/git, so that either you or
> > Junio (who are the only owners of the GitHub repository) can set it up. If
> > you want me to help, please do not hesitate to ping me on IRC.
> 
> I'm happy to. I walked through the Azure setup/login procedure, but I'm
> not sure what to do next.

The next step would be to install Azure Pipelines from the Marketplace and
activate it for git/git. There *should* be a wizard or something to walk
you through...

Ciao,
Dscho
