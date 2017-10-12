Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5921FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 00:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdJLA2A (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 20:28:00 -0400
Received: from avasout08.plus.net ([212.159.14.20]:52475 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdJLA17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 20:27:59 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id LQTx1w0020M91Ur01QTyTh; Thu, 12 Oct 2017 01:27:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=n8dVP5MhCN3csio9EjcA:9 a=fwpS_05hqZ076MV6:21
 a=lC8KaHdy_7_pkJ4j:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: v2.15.0-rc1 test failure
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
 <20171011223433.GA6079@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <338656d4-182b-563f-9195-515d213d4b6d@ramsayjones.plus.com>
Date:   Thu, 12 Oct 2017 01:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171011223433.GA6079@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/10/17 23:34, Adam Dinwoodie wrote:
[snip]
> Hi Ramsay,
> 
> I assume, given you're emailing me, that this is a Cygwin failure?

Yes, sorry, I should have made that clear.

> t0021.15 has PERL as a requirement, and I see semi-regular failures from
> Git tests that are Perl-based in one way or another (git-svn tests are
> the most common problems).  I've not spotted t0021 failing in that way,
> but it sounds like the same class of problem.

Yep, many moons ago, I used to run the svn tests (on Linux and cygwin)
which would fail intermittently on cygwin. I didn't notice any problem
with perl though.

> I dig into these failures when I see them, mostly by running the script
> a few hundred times until I get the failure again, and they've always
> been Perl itself segfaulting.  That points to the problem being in
> Cygwin's Perl package rather than Git, and it's very unlikely to be
> anything that's got worse in v2.15.0.

Since I stopped running the svn tests, the number of intermittent test failures on cygwin have dropped significantly, but haven't gone away
completely.

I just finished the second test-suite run and, of course, t0021 ran
without problem this time. Hmm, I don't think I have time to chase
this down at the moment. I will keep your 'perl hypothesis' in mind
for next time, however.

Thanks.

ATB,
Ramsay Jones


