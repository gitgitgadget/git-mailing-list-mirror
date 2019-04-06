Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786D620248
	for <e@80x24.org>; Sat,  6 Apr 2019 13:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDFNME (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 09:12:04 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38911 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFNME (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 09:12:04 -0400
Received: by mail-wr1-f52.google.com with SMTP id k11so11066453wro.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=azoGAtxtigKVo2tKUjWVfIysC3+UryjVG2HfvDmMjLw=;
        b=OecvvrPlTVBdmznWwQCmqUjzjhavUJ1IMevUH/DG3xOv+33BkutKzLKWAr3+dTm5ZP
         z0xQmKVWNTuCd5eUpjiCPXNYdg2CEyTtK00/t6ivQ9EkQBjhnGo87iKRtxt3WcXAkgeE
         eK20BRgOm8drwg0btZsjKFjrY082pohkQuAXVrajEiP2qj8bqLubOmh3rOAOuK0hXoJL
         Kne0YPNEhXq0t13ztw8o48mlTLiYde1Gp4cNEK1iDv3Pn7s+9QStGASYA+CFCVighQFc
         DWmrxVgbgujaiWV1LkuzNhpnTTAkQg6sLYLgZ36zo5qqvSFVGfASKkzNDikt/XcJIuwe
         HDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=azoGAtxtigKVo2tKUjWVfIysC3+UryjVG2HfvDmMjLw=;
        b=EaA+DEKKvC7nUma3m9WtRQHdNgqpt7vkGG+SBntCULMUkZ7UhIXhZsLc7vxZHghlf5
         4g1c4twD3FIIhUVvmPD0lKHmU194O8L2LgSFpPQaBuv/aT336PUivrJwie1iynonUSsL
         v7cZu1JphZve+ku77GprwowB6NKeZ8lk7E1BIBfuE/vFIp5Yce4o80WQhh64X90o7xop
         9s+5CeWzgSrEodr0CgiBTEcD6mCfDetumXvT41SEp9PWN/wQV4cmlLHhZQYC6lh/mJAE
         eYowNhDTrgbNFWgdAt4IxJU4zBnuCwlyAy//eS6l/qQRWRXM2iJwbNJ2X6u0CK/N2H1/
         Qh6Q==
X-Gm-Message-State: APjAAAVJI/yf0AIOSc/XivAYj+XCteAHTDWS8FwkdZ3j/MAqDws0tU+I
        6ga+qnfj0LqDKWYeRvC4jWhAmDJO
X-Google-Smtp-Source: APXvYqwO9aBdb7hBb8rdb9zt8YqLaqcmxbWc3WX4DDEpZrnTXinGw0RXSf7TNp/3S7eZQDZ3O0/K9Q==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr2574212wrs.5.1554556322032;
        Sat, 06 Apr 2019 06:12:02 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id p6sm18290011wrs.6.2019.04.06.06.12.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Apr 2019 06:12:01 -0700 (PDT)
Date:   Sat, 6 Apr 2019 15:12:00 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     git@vger.kernel.org
Subject: Pull without fetch
Message-ID: <20190406131200.xcd7gtf7dlc567uh@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 06 Apr 2019 15:09:49 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developpers,

is there a way to do a git pull without it running git fetch?
Looking at the source in builtin/pull.c does not seem to indicate so.

Here is my use case: I do a `git fetch --all` to look at the incoming
changes, and only afterwards I would like to do a `git pull --no-fetch`. I
could of course call `git merge`/`git rebase` directly, but the advantage
of `git pull` is that it parses the value of branch.<name>.rebase for me
(in `parse_config_rebase`). I could easily write a script for it, but this
would just duplicate this part of git-pull, so we might as well use git
pull directly. Moreover, `git-pull --rebase` used to have extra functionality
where it looked at the reflog to find the merge base. This is now
incorporated directly into git rebase, but this is one more reason I would
like to use git pull directly.

I am missing another way? Would a patch to provide this feature be accepted?

-- 
Damien Robert
