Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924651F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIRDZQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:25:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:17346 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRDZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:25:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8HLu1J8004316
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Sep 2018 17:56:02 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>
References: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com> <20180917192753.GF140909@aiede.svl.corp.google.com>
In-Reply-To: <20180917192753.GF140909@aiede.svl.corp.google.com>
Subject: RE: [Question] Alternative to git-lfs under go
Date:   Mon, 17 Sep 2018 17:55:55 -0400
Message-ID: <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJdFhyAAkhrROGH2xxxy0H9RARvggJHejCgo9E5f5A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 17, 2018 3:28 PM, Jonathan Nieder wrote:
> Randall S. Becker wrote:
> 
> > Does anyone know whether it is practical to rework git-lfs under a
> > language other than "go"? GCC is not even close to being possible to
> > port to my NonStop platform (may have tried, some have died - joke -
> > trying). I would like to convert this directly to C or something more
> > widely portable. Is there a protocol doc out there I can reference?
> 
> Can you say more about the context?  You might like
> 
>  git clone --filter=blob:limit=512m <repo>
> 
> which tells Git to avoid downloading any blobs larger than 512 megabytes
> until you know they need them.  See Documentation/technical/partial-
> clone.txt
> for more details.

Sorry, I was not clear. I am not having issues with large files or blob
limits.  Members of my community wish to use Git LFS support on their
enterprise git servers, so as platform maintainer for git on NonStop, I am
trying to accommodate them. The stumbling block is that "Go" language will
not port to the platform.

Cheers,
Randall

