Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2961F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfH0EBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:01:39 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:32713
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfH0EBj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Aug 2019 00:01:39 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B53B420EBE
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:51:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-6-46.trex.outbound.svc.cluster.local [100.96.6.46])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3CCE5211C8
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:51:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Tue, 27 Aug 2019 03:51:58 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Madly: 2b7494a376023e52_1566877918459_170518932
X-MC-Loop-Signature: 1566877918458:805889974
X-MC-Ingress-Time: 1566877918458
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 339607FEEE
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version
        :content-transfer-encoding; s=novalis.org; bh=jKyfwSFzdRQcnNWD+e
        sMKc/1dYY=; b=Ah5E7f4SvYgPdiMRr0PaJHdvau1v7TNq1O3KDg1Sv/qkBaB4pf
        lF2IY17T/1oGPNuW7i3Nv1rMKZJbSF2a6UohvwUEcj8id8hhR1L2wPanFCu9IyNk
        Asr8CWDfDP8kRHyCv6aLb2l1MiR9y5Ol1kdf1C2xzIAyYZIF5X3X1tsB8=
Received: from corey.lan (ool-18bcb49e.dyn.optonline.net [24.188.180.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id AAACE7FEE8
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 20:51:52 -0700 (PDT)
Message-ID: <7a13669281bef14b51d120815bc77fdbfa16afab.camel@novalis.org>
Subject: git remote-helpers and connectivity-ok
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <novalis@novalis.org>
To:     Git Mailing List <git@vger.kernel.org>
Date:   Mon, 26 Aug 2019 23:51:51 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqeenucfkphepvdegrddukeekrddukedtrdduheeknecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegtohhrvgihrdhlrghnpdhinhgvthepvdegrddukeekrddukedtrdduheekpdhrvghtuhhrnhdqphgrthhhpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqedpmhgrihhlfhhrohhmpehnohhvrghlihhssehnohhvrghlihhsrdhorhhgpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoth the git-remote-helpers man page:
"If option check-connectivity is requested, the helper must output
connectivity-ok if the clone is self-contained and connected."

I tried doing that in a helper, but I still got a connectivity check. 
Looking at the code, it looks like this only works if I supply a
".keep" file, and it only works for objects within the kept pack.  If I
want my helper to write more than one pack, I can't use this feature.

What I would expect, given the man page text, is that if connectivity-
ok is output, the entire rev-list bit is skipped.  

Is this a bug?  Or is it working as intended, and the documentation is
just unclear?  Should there be an option for "I (the remote helper)
know what I am doing, so please don't bother to check connectivity"?



