Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5D71F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBUX6u convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 21 Feb 2018 18:58:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55833 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBUX6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:58:49 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1LNwfTc068595
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Feb 2018 18:58:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Peter Backes'" <rtc@helen.PLASMA.Xg8.DE>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
Cc:     "'Derek Fawcus'" <dfawcus+lists-git@employees.org>,
        <git@vger.kernel.org>, "'Theodore Ts'o'" <tytso@mit.edu>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <20180221210339.GA43094@accordion.employees.org> <87bmgif2pa.fsf@evledraar.gmail.com> <20180221221420.GA7743@helen.PLASMA.Xg8.DE> <87a7w2ezeq.fsf@evledraar.gmail.com> <20180221231234.GA8509@helen.PLASMA.Xg8.DE>
In-Reply-To: <20180221231234.GA8509@helen.PLASMA.Xg8.DE>
Subject: RE: Git should preserve modification times at least on request
Date:   Wed, 21 Feb 2018 18:58:34 -0500
Message-ID: <007d01d3ab6f$e5439f10$afcadd30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJZbTC47MKZPVAOS2Y2vuFiN4livgIvGfNUAqkrcnkCpkG6hgItVZkNAdyeioeiR8C4sA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 21, 2018 6:13 PM, Peter Backes wrote:
> On Wed, Feb 21, 2018 at 11:44:13PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > If it were added as a first-level feature to git it would present a
> > lot of UX confusion. E.g. you run "git add" and it'll be showing the
> > mtime somehow, or you get a formatted patch over E-Mail and it doesn't
> > only include the commit time but also times for individual files.
> 
> But that's pretty standard. patch format has timestamp fields for
precisely
> this purpose:
> 
> % echo a > x
> % echo b > y
> % diff -u x y
> --- x	2018-02-21 23:56:29.574029523 +0100
> +++ y	2018-02-21 23:56:31.430003389 +0100

May I suggest storing the date/time in UTC+0 in all cases. I can see
potential issues a couple of times a year where holes exist. I cannot even
fathom what would happen on a merge or edit of history.

Cheers,
Randall

