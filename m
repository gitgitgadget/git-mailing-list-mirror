Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E16C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 17:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9D320704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDYRgs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Apr 2020 13:36:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:32210 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDYRgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 13:36:48 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 03PHae7o076319
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 25 Apr 2020 13:36:41 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Sibi Siddharthan via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "'Sibi Siddharthan'" <sibisiddharthan.github@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com> <20200425170740.GA6421@camp.crustytoothpaste.net>
In-Reply-To: <20200425170740.GA6421@camp.crustytoothpaste.net>
Subject: RE: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
Date:   Sat, 25 Apr 2020 13:36:34 -0400
Message-ID: <02a401d61b28$141b8d00$3c52a700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJYRHyQ1C8LhW18tSt1A8NYmssxgLhBqeCAatnK72n/yoVAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 25, 2020 1:08 PM, brian m. carlson Wrote:
> On 2020-04-24 at 04:01:30, Sibi Siddharthan via GitGitGadget wrote:
> > diff --git a/CMakeLists.txt b/CMakeLists.txt new file mode 100644
> > index 00000000000..73703bd321f
> > --- /dev/null
> > +++ b/CMakeLists.txt
> > @@ -0,0 +1,528 @@
> > +#
> > +#	Copyright (c) 2020 Sibi Siddharthan
> > +#
> > +
> > +cmake_minimum_required(VERSION 3.14)
> 
> I don't plan a full review of this series, but I wanted to point out that this
> version is newer than what's in Debian 10, so this isn't practically buildable on
> many systems.

I am unsure about this, but are non-git-foundation copyrights consistent GPL v2? Just asking for curiosity.

