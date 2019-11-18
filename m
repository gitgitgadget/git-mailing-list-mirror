Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09C11F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRXZW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Nov 2019 18:25:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16877 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfKRXZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 18:25:22 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xAINPBPt084191
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Nov 2019 18:25:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com> <20190423030254.GA19604@sigill.intra.peff.net> <20191113000747.GQ4348@szeder.dev> <20191113010337.GA20023@sigill.intra.peff.net> <20191113020719.GA435@sigill.intra.peff.net> <20191118223020.GB23183@szeder.dev>
In-Reply-To: <20191118223020.GB23183@szeder.dev>
Subject: RE: do people find t5504.8 flaky?
Date:   Mon, 18 Nov 2019 18:25:05 -0500
Message-ID: <024a01d59e67$6c08bdf0$441a39d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJBDed1vvcE8VTct2xs17BRPLb5eAFytMRcAZ1cnsMBveHd0gK2VcBkAvE2szSmZwa+cA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 18, 2019 5:30 PM, SZEDER Gábor wrote
> On Tue, Nov 12, 2019 at 09:07:19PM -0500, Jeff King wrote:
> > On Tue, Nov 12, 2019 at 08:03:37PM -0500, Jeff King wrote:
> >
> > > So with that second patch above, the test failure goes away for me.
> >
> > After poking at the behavior around connection dropping, I've
> > convinced myself this is the right thing to do. So here it is with a
> > commit message. I can't get the flaky test to fail anymore, but please
> > let me know if you do.
> 
> FWIW neither can I.  I clocked in ~3 hours of --stress with the patch applied,
> and no failures  (before it usually failed within 30s).

Nothing flaky so far on either NonStop ports.

