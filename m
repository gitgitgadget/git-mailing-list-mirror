Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F607205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965289AbdAHSye (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 13:54:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:55920 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932432AbdAHSyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 13:54:32 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M51eM-1cgBo63rXa-00zGCE; Sun, 08
 Jan 2017 19:54:25 +0100
Date:   Sun, 8 Jan 2017 19:54:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steven Penny <svnpenn@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
In-Reply-To: <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701081953330.3469@virtualbox>
References: <20170108061238.2604-1-svnpenn@gmail.com> <alpine.DEB.2.20.1701081250580.3469@virtualbox> <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lWFEPWe0UNQzqhgeFJbi2Y6LY1yOtwqt2OduCpEMY8d3IHU3wUL
 NjjUBYZDsWVrhqjojVfl//Zih5dxr12MHHw5+E6v96LqKFrNr+PQNeDC+P+GQF6UO7qRMM1
 gqnnYCEKKMjYUEhzvqWLEWxsfN/I3qrC0AEtIQb/v8cLVsxZtqO+miN1yVspR7zQsRgi85Z
 KoH20YWJCItGIWnDUbIGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xF+qa5JTv68=:DghxIA2UwKesy3xDmg5ZHX
 mu0IGA8dMMXNw+Wr1wsMJmi0jEjDJp8K1uvIdUdNDqr+Y0HqH/P5t1eTSh0zUzjj/xLA9cFN7
 WN1FzZAMrByw9pXzqGzWZ6Q3GRdldbjh6jbQWmSDfYU3Ls94x54ousvkswearlMfLmbcFKmE9
 8BGJRELtxh3+ByH4nfSdViZUImYzji2q03UhFYUK2Uq20Lr8RUUDxQViWwpgdakxyMYNBwyvG
 w2udBOfpASilZra024iRZCCdKg0+cHQBBVrcDN17sIylaXK0C2x5rZT1yZv1IzPXZCY6i09an
 RnWbNUGdDMdtr2iNzeC5eakn44Qduqw0zkU0eo/l5RTcpPZmm6ehYjnYeNIDrHVDGlm04DNqD
 QuWUDaM/DsZyWCbXITYPa9gWTOVTtU3RpIh5RBG/C2qdCqjpn8FasFqMoY9mI9q08gt0vWRrH
 Mhjwu3FV5RIq3kEplGOcTinOHt/tR7bLnZrMoBKNhs3aymZjQnACPi1CbCLjpEUiK/6h1mcD9
 RJGUbkUYL2G3ILuJOd5PfRT0VNO5kVEhzHf2anirxLqj+deqJxX9afd4irkApE8Rn+W/1fWKb
 7dvEiK+CLj5V8Z3FF548w6yzpEtwmZbhh8+61RL1VN1qFeyYxgkJKfg5oTX4SZvzxG7uekaJj
 Qknubh/o7VLxXv8pN1Ii/FxNseuG00q2dBQpWgj3yUxe4Z7aRorz4smFq2aRIzavCT+uOOvpH
 MpSoVA/3mghAdOzrK4eWebsotMx7Xb0MUJeOFDCOTALwP7j9qccMImDzdCusm1RhhM0bglkPv
 SHCn5QcuhtPzzFcfk2FyrBhyZRYFHQqDbpw9dp3lIRBlllgMho+tpNbd8UVD1HpwAjJ7BmpXe
 uNqvZEvf9FhIjeSN5vt9b81pbpPpbTaQ9DvpjpKGBCFa1MyTB5txkk4KSKza/UccjPdjUtfOt
 76sms2A7SLQog9LvQCSVJ2VCKslYBCrQcfSGkbAgWf/BKaSDLQS7P9xiwHwMzL2kAiS/2H3O4
 PmCBcZJLF32ZGXDdMrBVyKcOIhq3BSGw9qKtCYG9c6FQ0c2nbRs3pZ8yGmwRlsVDvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steven,

On Sun, 8 Jan 2017, Steven Penny wrote:

> On Sun, Jan 8, 2017 at 5:54 AM, Johannes Schindelin wrote:
> > I am curious: how do you build Git? I ask because I build Git on Windows
> > many times a day, and I did not encounter any link problems.
> 
> My end goal is to build static native Windows Git via Cygwin and the
> mingw64-x86_64-gcc-core package.

That is certainly a worthy goal, and I would highly recommend to mention
that particular cross-compiling setup in the commit message. It's not like
this is the easiest way to build native Git on Windows...

Ciao,
Johannes
