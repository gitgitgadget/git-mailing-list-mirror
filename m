Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA98520401
	for <e@80x24.org>; Tue, 27 Jun 2017 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdF0QbT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 12:31:19 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:42771 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdF0QbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 12:31:17 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5RGV8fr012776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2017 16:31:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v5RGV72f031069
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 27 Jun 2017 16:31:07 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v5RGV4Q3003217;
        Tue, 27 Jun 2017 16:31:05 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Jun 2017 09:31:04 -0700
Date:   Tue, 27 Jun 2017 12:31:02 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
Message-ID: <20170627163101.u7lsclnxnl6o7jec@oracle.com>
References: <20170627121718.12078-1-avarab@gmail.com>
 <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-2-avarab@gmail.com>
 <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
 <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [170627 11:55]:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
> >>       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
> >>       defined(__sparc))
> >> +/*
> >> + * Should define Big Endian for a whitelist of known processors. See
> >> + * https://sourceforge.net/p/predef/wiki/Endianness/ and
> >> + * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
> >> + */
> >>  #define SHA1DC_BIGENDIAN
> >
> > These look sensible.
> 
> By the way, I wonder why this didn't catch the sparc running
> Solaris.  What does Michael's system use to let the software know
> that it is targetted for a Sparc, if not __sparc?
> 

I have issues running the test on my solaris system.  Could you send him
the changes you made on sha1dc in git?  I suspect his platform does
define __sparc.

Cheers,
Liam

