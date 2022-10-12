Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD0C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJLMKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJLMKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:10:50 -0400
X-Greylist: delayed 16202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 05:10:47 PDT
Received: from 4.mo561.mail-out.ovh.net (4.mo561.mail-out.ovh.net [178.33.46.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B32796BE
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:10:47 -0700 (PDT)
Received: from player690.ha.ovh.net (unknown [10.111.208.48])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 3BC3322D24
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 07:22:51 +0000 (UTC)
Received: from ngraves.fr (met42-h01-213-44-161-47.dsl.sta.abo.bbox.fr [213.44.161.47])
        (Authenticated sender: ngraves@ngraves.fr)
        by player690.ha.ovh.net (Postfix) with ESMTPSA id 49BBB2F7AB5E8;
        Wed, 12 Oct 2022 07:22:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S0049541c3e9-00f6-4156-9292-6bcbeee4ddf6,
                    48C11EF01C883BAACC61323EB83FED7696FCE8CF) smtp.auth=ngraves@ngraves.fr
X-OVh-ClientIp: 213.44.161.47
From:   Nicolas Graves <ngraves@ngraves.fr>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Re: Error / feature-request: Signing git commits with SSH hardware key
In-Reply-To: <20221012065541.y2tl63tw3ooeoy7s@fs>
References: <875ygqw7p8.fsf@ngraves.fr>
 <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
 <87v8oquiuk.fsf@ngraves.fr> <87r0zeuhrv.fsf@ngraves.fr>
 <20221012065541.y2tl63tw3ooeoy7s@fs>
Date:   Wed, 12 Oct 2022 09:22:44 +0200
Message-ID: <871qrdh5ff.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Ovh-Tracer-Id: 7731273187313312378
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejjedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesthdtredttddttdenucfhrhhomheppfhitgholhgrshcuifhrrghvvghsuceonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqeenucggtffrrghtthgvrhhnpeeiudejtddvhfeflefgveehkeevvdeiieeffeehueffgeeuleehueetgfdtueevtdenucffohhmrghinhepghhithdqshgtmhdrtghomhenucfkphepuddvjedrtddrtddruddpvddufedrgeegrdduiedurdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehnghhrrghvvghssehnghhrrghvvghsrdhfrheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-12 08:55, Fabian Stelzer wrote:

> I assume you have specified your key in the git config in user.signingkey as
> the literal keystring?
> If so, then you'll need a `key::` prefix. Otherwise git will treat it as a
> file path.
> See
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-usersigningKey
>
> In the initial merge of this feature, git would allow ssh-* keys to be
> specified without the prefix. This was later deprecated and not all
> Tutorial/Docs you'll find online consider this.

Our mails crossed :)

This was the actual error, thanks a lot!

-- 
Best regards,
Nicolas Graves
