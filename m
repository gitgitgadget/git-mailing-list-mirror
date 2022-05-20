Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D92C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 08:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiETI4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbiETI4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 04:56:15 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118E0377E0
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:56:13 -0700 (PDT)
Received: from localhost (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id 85C6A44C72;
        Fri, 20 May 2022 10:56:12 +0200 (CEST)
Date:   Fri, 20 May 2022 10:56:12 +0200
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] transport: free local and remote refs in transport_push()
Message-ID: <YodXrProOdVzvgQA@fedora>
Reply-To: Frantisek Hrbata <frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <220520.8635h438aa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220520.8635h438aa.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, May 20, 2022 at 10:40:33AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 20 2022, Frantisek Hrbata wrote:
> 
> > Fix memory leaks in transport_push(), where remote_refs and local_refs
> > are never freed. While at it, remove the unnecessary indenting and make
> > the code hopefully more readable.
> 
> If at all possible it would be very nice to split up such re-indenting /
> formatting into another commit, so we can see what the "real" code
> changes are.

of course, I will split it into two patch series and post v2. First with the
indenting adjustment only and second with mem leak fixes.

Thank you


-- 
Frantisek Hrbata
