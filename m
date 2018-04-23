Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E791F424
	for <e@80x24.org>; Mon, 23 Apr 2018 00:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeDWAoX (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 20:44:23 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:34583 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753752AbeDWAoW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Apr 2018 20:44:22 -0400
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2018 20:44:22 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 8A700EAB8
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 19:23:41 -0500 (CDT)
Received: from gator3035.hostgator.com ([50.87.144.38])
        by cmsmtp with SMTP
        id APGffyItTlAdrAPGffYdqY; Sun, 22 Apr 2018 19:23:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schemaczar.com; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/94t2fk0/Fk3T5gEn6tmZXduce2DO6WXnkxKaeAGixY=; b=Mq8RLkAKWTIlVjjxpHqsSXUzg
        Qz5k3SESKWSd42xmyrehrMBoQCskfGSws0UjBgIvHizAb/Iz4VIjQHJhQigqsYQkSVFBU9LgS1oTB
        WkEVBtfcBkGQ8OTgrhrc0PD/pAA+3tRXHzS0tfcKyR+Na4txkiYQCc9DTeD1aYy+4Zu1U=;
Received: from pool-100-0-63-86.bstnma.fios.verizon.net ([100.0.63.86]:49680 helo=[172.24.1.103])
        by gator3035.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <andrew@schemaczar.com>)
        id 1fAPGd-001vbU-Hl; Sun, 22 Apr 2018 19:23:39 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Git enhancement request - checkout (clone) set modified dates to
 commit date
From:   Andrew Wolfe <andrew@schemaczar.com>
In-Reply-To: <20180422195923.GA10082@alpha>
Date:   Sun, 22 Apr 2018 20:23:37 -0400
Cc:     Andrew D Wolfe Jr <andrew@schemaczar.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BCD276C-BC6B-47BD-A27C-05D7C0C07280@schemaczar.com>
References: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
 <20180422180912.GK14631@genre.crustytoothpaste.net>
 <1FCE6958-FC75-4A9B-88A3-05AE991815E4@schemaczar.com>
 <20180422195923.GA10082@alpha>
To:     Kevin Daudt <me@ikke.info>
X-Mailer: Apple Mail (2.3445.6.18)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3035.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - schemaczar.com
X-BWhitelist: no
X-Source-IP: 100.0.63.86
X-Source-L: No
X-Exim-ID: 1fAPGd-001vbU-Hl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-100-0-63-86.bstnma.fios.verizon.net ([172.24.1.103]) [100.0.63.86]:49680
X-Source-Auth: andrew@schemaczar.com
X-Email-Count: 1
X-Source-Cap: b3VybGlnaHQ7b3VybGlnaHQ7Z2F0b3IzMDM1Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin, thanks for your feedback.

You have a reasonable point, because usually you don't put the outputs =
of a build into version control, but the build script checks them for =
being current.

On the other hand, when you change branches, your existing output =
directories are worthless problems anyway =E2=80=94 even if you have all =
the interdependencies correct.  Because of this, I'm inclined to =
consider this use case as intrinsically hazardous.  When I do a =
checkout, I always want to purge all the intermediate and end targets =
regardless.

When doing a build, it's often useful to put the current commit/branch =
into the output directories as documentation; I usually do this in my =
build scripts.  This also makes it simple to detect when the branch is =
changed and clean the outputs.

- Andrew

> On Apr 22, 2018, at 3:59 PM, Kevin Daudt <me@ikke.info> wrote:
>=20
> On Sun, Apr 22, 2018 at 03:01:10PM -0400, Andrew Wolfe wrote:
>> Hi Brian,
>>=20
>> Not completely sure what you're saying.  If the files on master are
>> not changed, the changed files' commit timestamps will be older than
>> the branch commit timestamps.
>>=20
>> However, if I check out master after committing to a branch, the
>> modifications will necessarily disappear because they haven't been
>> committed to master.  Instead, under my proposal, each will get the
>> timestamp of its prior commit.
>>=20
>=20
> Say I build the project while on a certain branch. Then I checkout a
> different branch and build again. You would expect that the targets of
> every source file that have changed are rebuilt.
>=20
> When you would restore the timestamp back to the commit timestamp, the
> timestamp will be older then the target, and make will not rebuild it,
> leaving you with outdated build targets.

