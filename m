Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4151F404
	for <e@80x24.org>; Wed, 29 Aug 2018 16:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeH2UMG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 16:12:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:51009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeH2UMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 16:12:06 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfmWy-1gFtLH1h6y-00NALj; Wed, 29
 Aug 2018 18:14:23 +0200
Date:   Wed, 29 Aug 2018 18:14:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
cc:     git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should
 accept --author
In-Reply-To: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
Message-ID: <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet>
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RX1XVMAckdycJ2XkPzZ0ch3PSYR33vNd6YC9qmstRypEmRrZDEX
 1zIAUb+ke0saSk2wmxSjCPkLJ/eaIdBRfDZq6VmNxYYoSdbRgIlEf0vXV9kUJtTgKfEWsPA
 V4DADjb9uWgh4va5OJ0RJWHLMAuIDypvYU2SFaINcEMGAmxNf5CfydnfirLFLE3KVGNW1Y/
 kfxnauHbbKRKYpeaSqyKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OMoSCrooFII=:vFi2k+doeA6IhDYLOy/ziv
 S9bMSO6/5JsI39udpRbCb6D1Rz8x1JY4sIkX6wlfJK8wdyKtGHQI6v7MFo8aawIVgR6ZaXTeh
 7uY6/Z/ahDb7FMce+JREV4GC97vsNq+ffubAsOZPloTDfKx6nGxLS92mihC8GaqWLkBkv0ulz
 bptZgLnodPcb0ceauoPl1bKXE5sIejk++rLHI2Yv1uV+4pcsGnggTNIH8TrQkr1zER6IO2bX/
 wgQQhzuR93+F8UqutNVO0Rixkh2AN6f7GndPtoZ2mXir5vX/mMPEaBTWWdMp7XXkMB4CfTtTg
 RJoGPi7tfGnbGhOTcPTYEd5iLf2RD8xruGwcj/jwpxYZzQ12jgQs/K1lAXiY5mRUFbn9X/cst
 Z6LBEnq2vCoTMSdkdlWTpnfujirtZELs1eB62O+hevP0jK4AxNqdEQV0D9HGpBPwe3ckpC5MK
 kRD4jiJ56R6IOFaYBm48x/x3c95Oedtc5WxxWWs4snsSpkH25HwdMFMOzKls71b4wyy3bftDj
 D704RAl+opCwi6d0zfZT1b3Xo5k1eU0pCATGDyET4JxNH51XuT9Q6V1JWUHaQt1b6JaQuDBT/
 3qvOdMRqCrmdFh1lpeI5t15zC6OJgX5jiwmU2hQjpEZHrdKAkE9C0BrX4Nggi1zwAzSn26Bf5
 zu/4HG60sun4iOXd18slYvcfQ/rmim52naUb8XXHMFtU01P/sfi4kJ4tLaNwlbbMaGlroHV6q
 7puGmgS9jzLMmJQH3DwLsF52vUXy37bdxjt4Mc/K7hRaVdQ0ClkCPCKnUwMHP3JgM/1DiW3yE
 6OvfyNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

On Tue, 28 Aug 2018, Ulrich Gemkow wrote:

> A trivial enhancement request:
> 
> All commands which require that the author is set (and complain if
> it is not set) should accept the option --author.
> 
> At least the command stash does not accept this option. We are using
> git version 2.17.1 (Ubuntu 18.04).

The `stash` command only incidentally requires that the author is set, as
it calls `git commit` internally (which records the author). As stashes
are intended to be local only, that author information was never meant to
be a vital part of the `stash`.

I could imagine that an even better enhancement request would ask for `git
stash` to work even if `user.name` is not configured.

However, to get you unblocked: what you ask for exists already, in some
form:

	git \
		-c user.name="Ulrich Gemkow" \
		-c user.email=ulrich.gemkow@ikr.uni-stuttgart.de \
		stash

Granted, this is not the nicest way to specify it, but you are probably
scripting things for environments where you do not really want to
configure an author, right?

Ciao,
Johannes
