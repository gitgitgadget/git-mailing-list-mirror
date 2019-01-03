Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CE31F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfACWFM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Jan 2019 17:05:12 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39943 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfACWFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 17:05:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x03M4wT1078597
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 17:04:59 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        <randall.s.becker@rogers.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20190103210351.13920-1-randall.s.becker@rogers.com> <20190103210351.13920-3-randall.s.becker@rogers.com> <CAPig+cSkok+QttWZTMngCdUrxHiO0rg53M4q=1q1vsewn7Qy_Q@mail.gmail.com>
In-Reply-To: <CAPig+cSkok+QttWZTMngCdUrxHiO0rg53M4q=1q1vsewn7Qy_Q@mail.gmail.com>
Subject: RE: [Patch v5 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu, 3 Jan 2019 17:04:52 -0500
Message-ID: <007901d4a3b0$5dd1d030$19757090$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMvgCHt68OIXko24hzpvmTXcJA7igKbd6vcAYpRNDiixzG3QA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 3, 2019 16:38, Eric Sunshine wrote:
> On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
> > A number of configuration options are not automatically detected by
> > configure mechanisms, including the location of Perl and Python.
> >
> > There was a problem at a specific set of operating system versions
> > that caused getopt to have compile errors. Account for this by
> > providing emulation defines for those versions.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/config.mak.uname b/config.mak.uname @@ -470,7 +487,7
> @@
> > ifeq ($(uname_S),NONSTOP_KERNEL)
> >         NO_MKDTEMP = YesPlease
> >         OLD_ICONV = UnfortunatelyYes
> > -       NO_REGEX = YesPlease
> > +       NO_REGEX=NeedsStartEnd
> >         NO_PTHREADS = UnfortunatelyYes
> 
> Style nit (probably not worth a re-roll): you lost the whitespace surrounding
> '='

I can fix this one in the next round of changes, or after this gets in, if that works, or signoff on this being fixed in place.

