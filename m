Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56DA1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759906AbeD1MYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 08:24:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:35453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759873AbeD1MYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 08:24:48 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWTSA-1et3mW0m30-00Xdpy; Sat, 28
 Apr 2018 14:24:46 +0200
Date:   Sat, 28 Apr 2018 14:24:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Colin Arnott <colin@urandom.co.uk>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http.c: shell command evaluation for extraheader
In-Reply-To: <-mpHjLv0pGYld30rBagku1GYfPM2FqZQubWD4rHt2K_uijQg0ehMjeBnZgr4K77zc2E4HAlm3eqNtP7-lXzhR8o7udP0TdNHMJK7WRauzmk=@urandom.co.uk>
Message-ID: <nycvar.QRO.7.76.6.1804281421430.79@tvgsbejvaqbjf.bet>
References: <CngnTUCx1pVSyKUzINZV972DlD_JMH53F-L2PZtx0_RKMiwXYY4f2UzDPeJaC5fL-6oJBXAxQ5f0OC76I_fagEWxch5csI716N7bQDh3gR8=@urandom.co.uk> <nycvar.QRO.7.76.6.1803051437000.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <-mpHjLv0pGYld30rBagku1GYfPM2FqZQubWD4rHt2K_uijQg0ehMjeBnZgr4K77zc2E4HAlm3eqNtP7-lXzhR8o7udP0TdNHMJK7WRauzmk=@urandom.co.uk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eoT7mqnekMv80WVAK8K6Q1vAKogf2ylsoY/FUtaEJTaWmMHX4ar
 AfN0W+/E9+uxrCDpA/Y6of1UJn9YejXW28Ip6yTAek9I8bIkLhNh2GD3ilkuwPk+NTi17ZX
 NgFbphCE1p8pHhWFeM+9wq446R+zzMXG2mD9CTzz1287CVu8Q3NKc03KS4lusd3scoEK476
 nF/qkZaCIlrkCdc8h7etA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J26rVwXTGSs=:7Whgan3DByx4V+GRKzmdLP
 Sk3Ol2wykovjPRyHmEkLk/KwJRbwOnopOoXB68pC0Z8tBdRSqfMNHJPK/CmAeRfZ4x9/iLTaY
 75Q3YEnzVevWPkWj7KDKdbaEzd2MwZiAz5xu5x6zpG5hqVtp5naHGTWHoC4dtx1ZeCIkjOcsN
 L1pB535YzcBiRRgjKMcUHcbVQGro19HJWRngio38c1xe3DM6HZi/q4paQBmD6zBaE4zU465Ta
 UoOr7VbIGtt4fanqMgBA0qbA6F7qqQvADm7q4cgtRdkY9BHziW/YEB/fwdyJ4jg4xEPMsxoyR
 MTNKrN+51+OuKpnKoWeDHWEgmiJNxPget6GTolbWmucL8bbhUTDGtX8bxi38A4zHc0XEciS9D
 m6yCXaEB4bJWI1Iujg/sOpVuLyYbGxNke9Jcoukb9QX92wlY/aH3zynbdz5NkNOly9qP6ozel
 drjWoEr8kM/hRX/yTD7qQsGLXcCMygAUeP0kDfXC2UJvcfni8e8MJHXmRshn1pYW/1FfMXVoa
 5J5JGql8Y3sLt1BpFi9Jujbq8eWuZx2BOG9tE10sUk7pXWkWPuqInUYRwCKPw2SemVgf9Jw/W
 RYwwcECreee9QIoYO6F3YRUOZZSdADUuL0tPsdZRsZ20yu8S4dn0a2DEOADqQXDCV+Eu/PAcx
 ZmXi8LTGyL0o2WG8CIjp0xQMAA4Kr6DGDOWVz/wVVYuSNU0cnO2CmEFUpLpz+wOfxo6ypMZXb
 7T214qcUrVTh5n1YExVXfBgQlAgKGw2hn5IsAHuKt3dSTkTBDd4I97ha8kfidwNTG6uMNS6E9
 gynZ3aJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Colin,

On Tue, 6 Mar 2018, Colin Arnott wrote:

> On March 5, 2018 1:47 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > As the credential-helper is already intended for sensitive data, and
> > as it already allows to interact with a helper, I would strongly
> > assume that it would make more sense to try to extend that feature
> > (instead of the simple extraHeader one).
> 
> To confirm you are suggesting that the credential struct, defined in credential.h, be extended to include a headers array, like so:
> --- a/credential.h
> +++ b/credential.h
> @@ -15,6 +15,7 @@ struct credential {
>         char *protocol;
>         char *host;
>         char *path;
> +       char **headers
>  };
>  
>  #define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }

I think that was what I had in mind, yes.

> > This would also help alleviate all the quoting/dequoting issues involved
> > with shell scripting.
> > 
> > Besides, the http.extraHeader feature was designed to accommodate all
> > kinds of extra headers, not only authentication ones (and indeed, the
> > authentication was only intended for use in build agents, where both
> > environment and logging can be controlled rather tightly).
> 
> I realise that my examples are scoped for auth, but I can conceive of
> other mutating headers that are not explicitly authentication related,
> and could benefit from shell execution before fetch, pull, push actions.

I can conceive of yet another use case that would benefit from shell
execution in these scenarios: attacks. That is why I am extremely hesitant
to go that route.

But then, I am not the maintainer of Git. If you can convince him, you're
good to go.

> > I also see that in your implementation, only the extraHeader value is
> > evaluated, without any access to the rest of the metadata (such as URL,
> > and optionally specified user).
> >
> > It would probably get a little more complicated than a shell script to
> > write a credential-helper that will always be asked to generate an
> > authentication, but I think even a moderate-level Perl script could be
> > used for that, and it would know the URL and user for which the
> > credentials are intended...
> 
> You are correct; the scope provided by http.<url>.* is enough to meet my
> use cases, however I agree the lack of access to metadata limits what
> can be done within in the context of the shell, and makes the case for a
> credential-helper implementation stronger. I think there is something to
> be said about the simplicity and user-friendliness of allowing shell
> scripts for semi-complex config options, but authentication is a task
> that should be handled well and centrally, thus extending the
> credential-api makes sense.

Yes, I agree.

Ciao,
Johannes
