Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41B91F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfBOSKZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:10:25 -0500
Received: from elephants.elehost.com ([216.66.27.132]:54364 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387853AbfBOSKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:10:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1FIAHkw004908
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 13:10:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Max Kirillov'" <max@max630.net>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20190209185930.5256-4-randall.s.becker@rogers.com> <20190215164237.12250-1-max@max630.net> <001601d4c551$d0f24c30$72d6e490$@nexbridge.com> <xmqqsgwp53uj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgwp53uj.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH] t5562: do not depend on /dev/zero
Date:   Fri, 15 Feb 2019 13:10:12 -0500
Message-ID: <001d01d4c559$b4f62b20$1ee28160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQDQQ4DmKtPRd0KdPgedbCJUNQBGEwIP382JAjLUFskCYseCnqe1AC8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 15, 2019 13:01, Junio C Hamano wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Max Kirillov' <max@max630.net>; git@vger.kernel.org; 'Johannes
> Schindelin' <Johannes.Schindelin@gmx.de>
> Subject: Re: [PATCH] t5562: do not depend on /dev/zero
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > FTR, this particular subtest is not the one that is hanging. This
> > subtest passes on NonStop with any and all (now) 4 solutions that have
> > been floating around.
> 
> One thing I'd like to know more is if this test passes on NonStop with
this
> patch, i.e. /dev/zero replaced with /dev/null.

Yes, this particular subtest passes replacing /dev/null. The other three
subtests still hang. This subtest never did.

