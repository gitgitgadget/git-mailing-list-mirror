Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0377CC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 15:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiDNPtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiDNPIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 11:08:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D4E8868
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 07:46:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23EEk54L002067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:46:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CAB3415C003E; Thu, 14 Apr 2022 10:46:05 -0400 (EDT)
Date:   Thu, 14 Apr 2022 10:46:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <YlgzrSAJnYpNYDV0@mit.edu>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
 <YlRyHR5rvG5P/Acr@mit.edu>
 <220411.86k0bvidja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220411.86k0bvidja.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 10:10:23PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> We could add configuration or whatever, but the topic of this thread is
> whether we should change the *default*. I think it's better to stick to
> that.

I would have thought it was painfully obvious that changing the
*default* is a ***terrible*** idea?

Is anyone other than the OP seriously promoting changing the default?

If someone wants to do something terrible to their own development
workflow (or if it actually makes sense for their workflow) we could
add some configuration, but if the question is changing the default,
my ppersonal opinion is, "Heck, no!"

   	  	     	    	      - Ted
