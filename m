Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F64520281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdIOTvB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 15:51:01 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:52699 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdIOTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:51:00 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Sep 2017 15:51:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 07B2010005C;
        Fri, 15 Sep 2017 19:43:32 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hF0ten5_Y6P1; Fri, 15 Sep 2017 19:43:31 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id E8BE680035;
        Fri, 15 Sep 2017 19:43:31 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 15 Sep 2017 19:43:31 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 15 Sep 2017 19:43:31 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
 extension.
Thread-Topic: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
 extension.
Thread-Index: AQHTLlfY788pGk9sj0CQO4VoibRJEKK2VGTg
Date:   Fri, 15 Sep 2017 19:43:31 +0000
Message-ID: <297da9019d8c44faa89434d699623408@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-6-benpeart@microsoft.com>
In-Reply-To: <20170915192043.4516-6-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Ben Peart [mailto:benpeart@microsoft.com]
> Sent: Friday, September 15, 2017 3:21 PM
> To: benpeart@microsoft.com
> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
> extension.
> 
> This includes the core.fsmonitor setting, the query-fsmonitor hook, and the
> fsmonitor index extension.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Documentation/config.txt                 |  6 ++++++
>  Documentation/githooks.txt               | 23 +++++++++++++++++++++++
>  Documentation/technical/index-format.txt | 19 +++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt index
> dc4e3f58a2..c196007a27 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -413,6 +413,12 @@ core.protectNTFS::
>  	8.3 "short" names.
>  	Defaults to `true` on Windows, and `false` elsewhere.
> 
> +core.fsmonitor::
> +	If set, the value of this variable is used as a command which
> +	will identify all files that may have changed since the
> +	requested date/time. This information is used to speed up git by
> +	avoiding unnecessary processing of files that have not changed.

I'm confused here.  You have a file called "fsmonitor-watchman", which seems to discuss the protocol for core.fsmonitor scripts in general, and you have this documentation, which does not link to that file.  Can you clarify this? 

<snip>

> +The hook should output to stdout the list of all files in the working
> +directory that may have changed since the requested time.  The logic
> +should be inclusive so that it does not miss any potential changes.

+"It is OK to include files which have not actually changed.  Newly-created and deleted files should also be included.  When files are renamed, both the old and the new name should be included."

Also, please discuss case sensitivity issues (e.g. on OS X).  

> +The paths should be relative to the root of the working directory and
> +be separated by a single NUL.

<snip>

> +  - 32-bit version number: the current supported version is 1.
> +
> +  - 64-bit time: the extension data reflects all changes through the given
> +	time which is stored as the nanoseconds elapsed since midnight,
> +	January 1, 1970.

Nit: Please specify signed or unsigned for these.  (I expect to be getting out of 
cryosleep around 2262, and I want to know if my old git repos will keep working...)

> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_VALID bitmap.
> +
> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
> +    is not CE_FSMONITOR_VALID.

