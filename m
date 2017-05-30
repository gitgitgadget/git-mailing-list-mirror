Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701102027C
	for <e@80x24.org>; Tue, 30 May 2017 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdE3Pn0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:43:26 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:44049 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdE3PnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:43:25 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v4UFhNE3012488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2017 15:43:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v4UFhM8l013755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 30 May 2017 15:43:23 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v4UFhKuo011152;
        Tue, 30 May 2017 15:43:21 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 May 2017 08:43:20 -0700
Date:   Tue, 30 May 2017 11:43:13 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.13.0-rc1 is broken on SPARC
Message-ID: <20170530154313.g7jcwgmlc5gk6uzj@oracle.com>
References: <20170529023619.24zh2owkpxgzt3em@oracle.com>
 <xmqqefv88fpu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefv88fpu.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [170529 00:11]:
> "Liam R. Howlett" <Liam.Howlett@Oracle.com> writes:
> 
> > My SPARC build does not function and seg bus terminates on any command.
> 
> Sorry, known issue in the released version 2.13 (we would have
> appreciated if a bug report for -rc1 came way before the decision to
> tag the final release).
> 
> A fix exists on 'pu' (you can merge or cherry-pick a0103914c2); it
> was unfortunately held up with an unrelated enthusiasm around an
> attempt to use submodule to manage this codebase in our project.
> 
> I'll try to untangle the fix proper and quickly merge down to the
> maintenance track.
> 
> Thanks for a report.


Thank you for your prompt response.  I appreciate your enthusiasm around
submodule code as I've used them extensively in the past.  I'm happy to
hear you have a fix planned for the stable release branch.

Cheers,
Liam
