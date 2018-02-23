Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779231F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBWMSf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:18:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:57745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeBWMSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:18:34 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXEs5-1fCgk60WKT-00WHUJ; Fri, 23
 Feb 2018 13:18:31 +0100
Date:   Fri, 23 Feb 2018 13:18:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Raining Chain <rainingchain@gmail.com>,
        git <git@vger.kernel.org>, git-for-windows@googlegroups.com
Subject: Re: Bug Report: git status triggers a file change event
In-Reply-To: <CAGZ79kZBrG7uQ5KOrpdkkhzet7chJhxVsKjTnVMQTrSGFAMZhw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802231315480.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAPaSTm=Vhg+S0Cf7rkcvXKH1eaEbw5aGOfCmtU7K3D+1kc-pGg@mail.gmail.com> <20180222052227.GA133592@aiede.svl.corp.google.com> <CAGZ79kZBrG7uQ5KOrpdkkhzet7chJhxVsKjTnVMQTrSGFAMZhw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EO/2f2d5sZ/SwCBqD7WsRhrwyECR5ZC0e2eFopISbcsjEuZUo+s
 uICnltIj4yXcOIWqSoPaSRYQGtHSvuyap3wetuiUGabciHtyHaqlIfb44A9WE29deknkceL
 V5S/LGk0GkNgqm21mDtcyi5XDWa5R5yB/IDOpKn9WJPdjMXFfIf981COavvnSzOsm2pcfWB
 wU2kcaSNAGlm0vrz3Vvcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:914RzR8RJj4=:KCwfyVxWUCxu5g7odGuU7p
 KUW2Gc166TWOMKtOYf+yxqOwU1GT6ZUDMNFjDVwUomESADe6ks8Xhx5s6oBC/8oX4kv+AaG9l
 1GZ4QZM5I7u0tV1ccnf55GmOFW4JOx2lLfy2HCVox3OaDXULuU6kk1kgPajv1m8AjmeXrE3l2
 hEcM2UJTYbX7DWvRfNjCrHH8aWByHPQNl6vubJ9swwuzg/3aISVSXLXIcBI/n4fLOO+AhsfxS
 6sHljKUm7GUIRR72MpGBafuIODaxbjydmLAR1xRfj0EBP/+fD3CKNDFv83oCJ84P/ACmYD/+X
 khMNUXcI8LIr5G/6lGLsN2wiSxww6uI5etKod+GUp9Q9uV+Pb8JVJVG3Lo+7YwC5x+zEHA5yL
 nkhgF76LagrwlAELimptFL2WOk3P1xYRHKudPmx7jDJBB3D5c2PWJ6ZGg5qiu9sFq1vI1V1yM
 gJsGhT6q6JqzEfiCcyt/Y2UYMjCg2EivXLVgNVfSaRiqwUjMxgWI8H8l3EkZZ9vSjYkL+0lO9
 DwqvHRlVXFyCxqZdH62+zuiP0Vy61U9GBTD1QXVlyju1KAwxboEwLCmAZGWqxaQLMnzcWmujN
 ZRhcB/Sg1up4fEJeBH7tg2vb96HpFLo3vWB+C+s+E9c/R2nYhDGFOM5ZAqjbt0xjYjQNWZG1K
 UScMW6OP31Nl7AKGiNge1UrRI6pPbcGFcS4N1pRdVEDGxaSbP9G7qQFqd9CSOS9EI1UO/hF2f
 7dlk/OphqFQO6LztKPeunLQmj4ZvAoYANkvI7a0cU4LFukJ6tmEFKTUIA1qH9/+SVgpHZJY6A
 uXmYsCmR29t6l0NYiXFosUZKDtRK5gt7iSYS8x+VI7dGo9n+Bs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Thu, 22 Feb 2018, Stefan Beller wrote:

> On Wed, Feb 21, 2018 at 9:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > +git-for-windows

First of all, this is clearly not a Windows-specific problem, as the index
file *is* updated, and that is simply the same behavior as on Linux/macOS.

> > Raining Chain wrote:
> >
> >> On Windows 10, git version 2.16.2.windows.1, running the command
> >>
> >> git status
> >>
> >> will trigger a file change event to file C:\myPath\.git  "Attributes
> >> changed."

Correct, because .git\index changed.

> >> This causes problems when using scripts that detect file changes such
> >> as tsc -w (Typescript compiler) and using softwares that regularly
> >> call git status such as VisualStudioCode.

Visual Studio Code most likely does not look at .git for worktree changes.

As to the Typescript compiler: it should only look for .ts files, I would
be very surprised if it was confused by .git's filesystem attributes
changing!

If tsw is still confused, try adding

	"exclude": [
	    ".git"
	]

to your tsconfig.json.

Ciao,
Johannes
