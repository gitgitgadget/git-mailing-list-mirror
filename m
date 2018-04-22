Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEF21F424
	for <e@80x24.org>; Sun, 22 Apr 2018 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDVTu3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 15:50:29 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:25450 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751008AbeDVTu2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Apr 2018 15:50:28 -0400
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2018 15:50:28 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B54F0202378
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 14:01:12 -0500 (CDT)
Received: from gator3035.hostgator.com ([50.87.144.38])
        by cmsmtp with SMTP
        id AKEafVHxgQUwqAKEafGfD1; Sun, 22 Apr 2018 14:01:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schemaczar.com; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ehi/BiCY31wHc5Nq3orY0r+B/dtxrKopIvfWHLTPby4=; b=m2mnTwlbRdyl2PtawUAo2Cfui
        IOyHeNo/FGH2KalmrzURfL3H6i8OwvHCvAV/XS4HlObputuFV0glZV7OUQJnm99qs+5V0QtkhLBVQ
        KmYuyRjO1TmPdlhbdmiv8xpAQBr0ILicie/QREy01bPNmG9MmV9VWNEXwb2OLn2D6KGlU=;
Received: from pool-100-0-63-86.bstnma.fios.verizon.net ([100.0.63.86]:53100 helo=awolfe.local)
        by gator3035.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <andrew@schemaczar.com>)
        id 1fAKEZ-003HhH-SX; Sun, 22 Apr 2018 14:01:11 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Git enhancement request - checkout (clone) set modified dates to
 commit date
From:   Andrew Wolfe <andrew@schemaczar.com>
In-Reply-To: <20180422180912.GK14631@genre.crustytoothpaste.net>
Date:   Sun, 22 Apr 2018 15:01:10 -0400
Cc:     Andrew D Wolfe Jr <andrew@schemaczar.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FCE6958-FC75-4A9B-88A3-05AE991815E4@schemaczar.com>
References: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
 <20180422180912.GK14631@genre.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3445.6.18)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3035.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - schemaczar.com
X-BWhitelist: no
X-Source-IP: 100.0.63.86
X-Source-L: No
X-Exim-ID: 1fAKEZ-003HhH-SX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-100-0-63-86.bstnma.fios.verizon.net (awolfe.local) [100.0.63.86]:53100
X-Source-Auth: andrew@schemaczar.com
X-Email-Count: 1
X-Source-Cap: b3VybGlnaHQ7b3VybGlnaHQ7Z2F0b3IzMDM1Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

Not completely sure what you're saying.  If the files on master are not =
changed, the changed files' commit timestamps will be older than the =
branch commit timestamps.

However, if I check out master after committing to a branch, the =
modifications will necessarily disappear because they haven't been =
committed to master.  Instead, under my proposal, each will get the =
timestamp of its prior commit.

If you're doing a merge, it will entail a commit and, again, the =
modified files will be newer.

I don't think your use case breaks my proposal.

- Andrew Wolfe

> On Apr 22, 2018, at 2:09 PM, brian m. carlson =
<sandals@crustytoothpaste.net> wrote:
>=20
> On Sun, Apr 22, 2018 at 01:18:10PM -0400, Andrew Wolfe wrote:
>> I would like to propose that the checkout process set the create and =
modification times of a file to the timestamp at which a file was =
committed.
>=20
> The reason Git doesn't do this is pretty simple: make and various =
other
> tools do rebuilds depending on timestamps.
>=20
> If I create a branch off master and make some commits, then switch =
back
> to master, I will want the changed files to have their timestamps
> updated to be newer so that a make on master will rebuild dependencies
> based on those files.  If I set the files to the commit timestamp, =
those
> files would be set to the timestamp of master, which is older than my
> new branch, and make wouldn't work properly.
>=20
> There are some cases where people want the behavior you requested, =
such
> as for reproducible builds, and in such cases, you can use a
> post-checkout hook to set timestamps with touch.
> --=20
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

