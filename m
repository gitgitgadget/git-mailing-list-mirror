Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2DF1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfBMSVF (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 13:21:05 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52917 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfBMSVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:21:05 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1DIL2UA037033
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 13:21:02 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <000501d4c3af$1748b100$45da1300$@rogers.com> <20190213174055.GD3064@jessie.local>
In-Reply-To: <20190213174055.GD3064@jessie.local>
Subject: RE: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in 2.21.0-rc0
Date:   Wed, 13 Feb 2019 13:20:55 -0500
Message-ID: <004801d4c3c8$df9d23c0$9ed76b40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIyu5uOusPFID78jMdwOugkAl1IxgJU8Yt0pQ9yiCA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 13, 2019 12:41, Max Kirillov wrote:
> On Wed, Feb 13, 2019 at 10:16:26AM -0500, randall.s.becker@rogers.com
> wrote:
> > On 2019-02-13, Max Kirillov, wrote:
> > As far as the unintended reuse of the output file, and issues with
> > pipes, yes, the NonStop is very sensitive to complex use of pipes and
> > much of the compatibility issues we have had relate to those (usually
> > Linux-specific pipe assumptions). That is where I have been looking
> > when trying to debug this situation (not yet found anything). This
> > could very well be directly related.
> 
> You mentioned cases 6,8,13. These are all related to gipped request body.
> Could it be the git-http-backend does not clean a sub-process which
> pervforms the decompression?

I guess that is possible. I don't know the guts of this part of the code.

