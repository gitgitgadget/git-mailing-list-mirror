Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC5020989
	for <e@80x24.org>; Thu, 13 Oct 2016 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbcJMN47 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 09:56:59 -0400
Received: from mclniron02-ext.bah.com ([128.229.5.22]:2775 "EHLO
        mclniron02-ext.bah.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbcJMN4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 09:56:50 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Oct 2016 09:56:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=bah.com; i=@bah.com; q=dns/txt; s=20160504;
  t=1476367010; x=1507903010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4jiPiheDAhdtm/PhgR8+/0EZbuAIwpT8G5SGo+v1TQ=;
  b=jwmVPnVVTrBo7O8jNU3b3EnIfCjDyAEDnldHfFg2jIF7ith3aCzjb4sD
   V5Nj0Pfe2A/ywHfB73M4XiL1y44uzDZX4kQkof0vTI0CpN+/7R+KVZfz4
   8Pkc/HAmxlDEdx/Cvk+jSMYDxMCO/Ozwlj8a+2yvlHsGbC6XIM6v7qxfO
   E=;
x-SBRS: None
X-REMOTE-IP: 10.12.10.201
X-RELAYED: True
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2FsAwCYjv9X/8kKDApcGgEBAQECAQEBAQgBAQEBgzwBAQEBAXR8B6QxlXxCJ4V6AoJNAQIBAQEBAQIDgQKCVQE5PAEBAQEBASMCDV4BAQEDATo/BQcEAgEIDQQEAQELFAkHMhQDAQUIAQEEDgUIiEAWwzwBAQEBAQEBAQEBAQEBAQEBAQEBAQEYBYsShEmDLoIvBZoCAYYmk1aFdYhOhCuDf4YIcoY1KoEFgQABAQE
X-IPAS-Result: A2FsAwCYjv9X/8kKDApcGgEBAQECAQEBAQgBAQEBgzwBAQEBAXR8B6QxlXxCJ4V6AoJNAQIBAQEBAQIDgQKCVQE5PAEBAQEBASMCDV4BAQEDATo/BQcEAgEIDQQEAQELFAkHMhQDAQUIAQEEDgUIiEAWwzwBAQEBAQEBAQEBAQEBAQEBAQEBAQEYBYsShEmDLoIvBZoCAYYmk1aFdYhOhCuDf4YIcoY1KoEFgQABAQE
X-IronPort-AV: E=Sophos;i="5.31,339,1473134400"; 
   d="scan'208";a="849653614"
Received: from unknown (HELO ASHBCSHB02.resource.ds.bah.com) ([10.12.10.201])
  by mclniron02-int.bah.com with ESMTP; 13 Oct 2016 09:45:23 -0400
Received: from ASHBDAG1M3.resource.ds.bah.com ([fe80::e408:2edf:8022:481d]) by
 ASHBCSHB02.resource.ds.bah.com ([::1]) with mapi id 14.03.0279.002; Thu, 13
 Oct 2016 09:45:22 -0400
From:   "Vacha, Brian [USA]" <vacha_brian@bah.com>
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External] Re: Fork Errors
Thread-Topic: [External] Re: Fork Errors
Thread-Index: AdIf2jpv4xmwQsngS26RjrVKKVCazQAJukSAAVWRB+A=
Date:   Thu, 13 Oct 2016 13:45:20 +0000
Message-ID: <2E2ADD8A4AA3FA44A8D8FB00E2B24154B5EA4463@ASHBDAG1M3.resource.ds.bah.com>
References: <2E2ADD8A4AA3FA44A8D8FB00E2B24154B5E9E1C6@ASHBDAG1M3.resource.ds.bah.com>
 <20161006174041.4225c2b52bd144e5b3db8a85@domain007.com>
In-Reply-To: <20161006174041.4225c2b52bd144e5b3db8a85@domain007.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.4.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Khomoutov.  I turned out that when I went back to version 2.7.0 of =
Git (as mentioned in this post https://github.com/git-for-windows/git/issue=
s/776) that I no longer received the fork errors.  However, then I received=
 a Permission error and also wasn't thrilled that I had to use an old Git. =
 After some installing and uninstalling different ways, I remembered that w=
hen things were working for me in the past, I had the GitHub shell installe=
d.  So, I installed the GitHub shell with the newest version of Git and was=
 able to use its  Git Shell without problem.  Now, I can build my app with =
npm successfully.


-----Original Message-----
From: Konstantin Khomoutov [mailto:kostix+git@007spb.ru]=20
Sent: Thursday, October 06, 2016 10:41 AM
To: Vacha, Brian [USA] <vacha_brian@bah.com>
Cc: git@vger.kernel.org
Subject: [External] Re: Fork Errors

On Thu, 6 Oct 2016 14:02:09 +0000
"Vacha, Brian [USA]" <vacha_brian@bah.com> wrote:

> When starting Git Bash, I receive the following errors:
> 0 [main] bash 18088 fork: child 14072 - died waiting for dll loading,=20
> errno 11 bash: fork: retry: No child processes
> 1190419 [main] bash 18088 fork: child 8744 - died waiting for dll=20
> loading, errno 11 bash: fork: retry: No child processes
> 3343518 [main] bash 18088 fork: child 12324 - died waiting for dll=20
> loading, errno 11 bash: fork: retry: No child processes
> 7480858 [main] bash 18088 fork: child 17008 - died waiting for dll=20
> loading, errno 11 bash: fork: retry: No child processes
> 15635036 [main] bash 18088 fork: child 8108 - died waiting for dll=20
> loading, errno 11 bash: fork: Resource temporarily unavailable=20
> bash-4.3$
>=20
> My connection is great at 72 Mbps download and 93 Mbps upload.  I=20
> don't receive other errors so it appears to be a Git Bash issue to me.

Have you tried searching through Git for Windows bugtracker [1] for your pr=
oblem.  I'm pretty sure it was recently discussed there.
The issue #776 [2] looks like the one you're experiencing.

1. https://github.com/git-for-windows/git/issues
2. https://github.com/git-for-windows/git/issues/776
