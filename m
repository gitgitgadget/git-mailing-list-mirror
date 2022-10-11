Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B812C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 22:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJKWgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKWgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 18:36:07 -0400
X-Greylist: delayed 2105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 15:36:06 PDT
Received: from 10.mo576.mail-out.ovh.net (10.mo576.mail-out.ovh.net [46.105.73.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A558A1DE
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:36:06 -0700 (PDT)
Received: from player691.ha.ovh.net (unknown [10.108.4.105])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 653C723E20
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 22:17:44 +0000 (UTC)
Received: from ngraves.fr (met42-h01-213-44-161-47.dsl.sta.abo.bbox.fr [213.44.161.47])
        (Authenticated sender: ngraves@ngraves.fr)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id AE9B42FA9C1F3;
        Tue, 11 Oct 2022 22:17:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002ef0a4e56-d959-44c2-8b7b-ff499e7e32d0,
                    48C11EF01C883BAACC61323EB83FED7696FCE8CF) smtp.auth=ngraves@ngraves.fr
X-OVh-ClientIp: 213.44.161.47
From:   Nicolas Graves <ngraves@ngraves.fr>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Re: Error / feature-request: Signing git commits with SSH hardware key
In-Reply-To: <87v8oquiuk.fsf@ngraves.fr>
References: <875ygqw7p8.fsf@ngraves.fr>
 <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
 <87v8oquiuk.fsf@ngraves.fr>
Date:   Wed, 12 Oct 2022 00:17:40 +0200
Message-ID: <87r0zeuhrv.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Ovh-Tracer-Id: 16971815196168872570
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejjedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecuhfhrohhmpefpihgtohhlrghsucfirhgrvhgvshcuoehnghhrrghvvghssehnghhrrghvvghsrdhfrheqnecuggftrfgrthhtvghrnhepveekleeujedthefgffekleekhffhffetgfdvheekleeuhfehueeljedtjefhvdfgnecukfhppeduvdejrddtrddtrddupddvudefrdeggedrudeiuddrgeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-11 23:54, Nicolas Graves wrote:

> error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification

And I can confirm that it was this error and bad configuration, sorry!

> error: Couldn't load public key sk-ssh-ed25519@openssh.com AAAAG[..]zaDo=: No such file or directory?

This error is not very precise though.

Thanks for your help!


-- 
Best regards,
Nicolas Graves
