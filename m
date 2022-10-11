Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF91C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 19:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKTcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKTcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 15:32:20 -0400
X-Greylist: delayed 2403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 12:32:17 PDT
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A874BB9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 12:32:17 -0700 (PDT)
Received: from player756.ha.ovh.net (unknown [10.108.20.144])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id BC99521CAF
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 18:12:23 +0000 (UTC)
Received: from ngraves.fr (met42-h01-213-44-161-47.dsl.sta.abo.bbox.fr [213.44.161.47])
        (Authenticated sender: ngraves@ngraves.fr)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id 243C52EC44B37;
        Tue, 11 Oct 2022 18:12:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R0044be6e683-1b19-4259-9e17-ec0a76e7eece,
                    CAD2B4A3459146A86F0B95563822EA9C8829CA61) smtp.auth=ngraves@ngraves.fr
X-OVh-ClientIp: 213.44.161.47
From:   Nicolas Graves <ngraves@ngraves.fr>
To:     git@vger.kernel.org
Cc:     Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Error / feature-request: Signing git commits with SSH hardware key
Date:   Tue, 11 Oct 2022 20:12:19 +0200
Message-ID: <875ygqw7p8.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Ovh-Tracer-Id: 12828222064667189882
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfggtgesthdtredttddttdenucfhrhhomheppfhitgholhgrshcuifhrrghvvghsuceonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqeenucggtffrrghtthgvrhhnpedutefhueegheffteduleettdehhfehgeekgfdttdeuteduleekleeitddtvdefheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupddvudefrdeggedrudeiuddrgeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi!

I noticed git commit signing works well with ssh-ed25519 keys, but does
fail with sk-ssh-ed25519@openssh.com SSH hardware keys (with can be
used to clone / post to github for instance).

Would that be possible to support in a later release? Thus having a
smart card can be useful for both ssh and git.

I also noticed a similar error in a previous mail from Cuckoo Aidan
<aidancuckoo@gmail.com>, but he doesn't say which type of key he
used. In any case, would that be possible to include the info about
which type of keys cannot be used to commit in the github guide
https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key) ?

-- 
Best regards,
Nicolas Graves
