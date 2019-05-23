Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB151F462
	for <e@80x24.org>; Thu, 23 May 2019 19:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfEWT5t convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 May 2019 15:57:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:65124 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfEWT5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 15:57:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4NJvcLV017518
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 15:57:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com> <20190522004825.GC8616@genre.crustytoothpaste.net>
In-Reply-To: <20190522004825.GC8616@genre.crustytoothpaste.net>
Subject: RE: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
Date:   Thu, 23 May 2019 15:57:31 -0400
Message-ID: <004e01d511a1$c521a120$4f64e360$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHMXCdBtn7xefigKEQDPm4zJf8pugKY8znQpnXC9kA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 21, 2019 20:48, brian m. carlson wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Git Mailing List' <git@vger.kernel.org>
> Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
> 
> On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> > When running the test in isolation, it passes without incident whether
> > or not --verbose is used. So far, this only occurs on the first run
> > through. I wanted to report it, based on the inconsistency of results.
> > This is not the first time tests have acted in this fashion, and I
> > realize it is difficult to do anything about it without being able to recreate
> the situation.
> 
> Does running git clean -dxf cause it to be reproducible?

Made no difference. t5401 passed cleanly after a the clean -dxf. I don't know where the breadcrumbs are. I guess it could be something funky in the file system on platform or with bash.

