Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7069FC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 08:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1287722266
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 08:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKRIRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 03:17:53 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33675 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgKRIRw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 03:17:52 -0500
Received: from mxplan1.mail.ovh.net (unknown [10.109.146.140])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 96C327362E09;
        Wed, 18 Nov 2020 09:17:50 +0100 (CET)
Received: from greg0ire.fr (37.59.142.104) by DAG4EX2.mxp1.local (172.16.2.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 18 Nov
 2020 09:17:49 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-104R0051d9e8198-35f8-4081-877c-8067f9794faa,
                    AD131F76BB5DFBF2F978B3F098793A1FA3F14443) smtp.auth=postmaster@greg0ire.fr
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
 <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
 <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr>
 <CAN0heSr9=_So-sUhQN86vawBEkJhnrHHsd3OcSYZMZ-idZGFAQ@mail.gmail.com>
 <5a2d70eb-da75-ff59-8ac1-6ba81e1632da@web.de>
From:   =?UTF-8?Q?Gr=c3=a9goire_PARIS?= <postmaster@greg0ire.fr>
Message-ID: <a205cb0c-95ec-7f9e-0dea-8fd5b4bc694f@greg0ire.fr>
Date:   Wed, 18 Nov 2020 09:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5a2d70eb-da75-ff59-8ac1-6ba81e1632da@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG8EX1.mxp1.local (172.16.2.15) To DAG4EX2.mxp1.local
 (172.16.2.8)
X-Ovh-Tracer-GUID: 19661b44-445f-44b5-8ef5-f0b469406801
X-Ovh-Tracer-Id: 15613416961290636765
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudefgedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepifhrrohgohhirhgvpgfrteftkffuuceophhoshhtmhgrshhtvghrsehgrhgvghdtihhrvgdrfhhrqeenucggtffrrghtthgvrhhnpeeiueeileehlefhudejteetueeijeekieevtdevffevveevgeefudelfffhheektdenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhdurdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepphhoshhtmhgrshhtvghrsehgrhgvghdtihhrvgdrfhhrpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René!

Sorry for not seeing your answer before!

On 11/15/20 12:40 AM, René Scharfe wrote:
>
> The --function-context options of git diff and git grep try to show
> comments by including non-empty lines before function lines.

That would indeed do the first part of the job. Do you think something 
similarcould be done to remove non-empty lines before the next funcname?

>    This
> heuristic might work for -L :funcname:file as well (patch below), but
> breaks seven tests in each of t8001-annotate.sh, t8002-blame.sh and
> t8012-blame-colors.sh.

I haven't written C in 10 literal years but I think I managed to apply 
this patch, and something looks wrong: it's looking too "far" before: 
See for instance: --- commit 1a8a640f87cad94d36713f45e5e257de20930171 
Author: Michael Moravec <me@majkl.me> Date: Mon Mar 5 04:01:58 2018 
+0100 Upgrade to Doctrine CS 4.0 diff --git 
a/src/Doctrine/Instantiator/Instantiator.php 
b/src/Doctrine/Instantiator/Instantiator.php --- 
a/src/Doctrine/Instantiator/Instantiator.php +++ 
b/src/Doctrine/Instantiator/Instantiator.php @@ -31,12 +33,14 @@ */ 
private static $cachedInstantiators = []; /** - * @var object[] of 
objects that can directly be cloned, indexed by class name + * Array of 
objects that can directly be cloned, indexed by class name. + * + * @var 
object[] */ private static $cachedCloneables = []; /** * {@inheritDoc} 
*/ public function instantiate($className) --- Here it's picking changes 
in the phpdoc of the property that precedes `instantiate`, (when using 
git log 
-L/instantiate\(/,-14:src/Doctrine/Instantiator/Instantiator.php) What's 
wrong? -- greg0ire

