Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8670C77B7C
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjDZSnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZSnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 14:43:16 -0400
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 11:43:12 PDT
Received: from tilde.club (tilde.club [IPv6:2607:5300:204:4340::114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECC44BA
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 11:43:11 -0700 (PDT)
Received: from tilde.club (tor-exit-55.for-privacy.net [185.220.101.55])
        by tilde.club (Postfix) with ESMTPSA id B0905220CAA85;
        Wed, 26 Apr 2023 18:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club B0905220CAA85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1682534158; bh=iSrdsWB9+0rky9E/qynrbznAnZytADMb5IiqemLxKw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ST4du/1OW3oFIz6FqPRnO0CyakJgkQKnJJzpVzQGlLC0UyIgr38IglFzdhaYziXvj
         lvA7Mn52aouhsQDX9fKNtuAfBOvCLsMgZRj1By9tw75TBnajI7ZJ2JMJCorq/Fei0E
         UJx7tHXbtg6X44mpcw/9RdrRcCCZnzxnNjk+N4SU=
Date:   Wed, 26 Apr 2023 18:35:39 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Bran Hagger <brhagger@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <nasamuffin@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Improving support for name changes in git
Message-ID: <ZElux+kFcskXVL9Y@tilde.club>
References: <LV2PR21MB31334981E02BCA25792BAFFCCF939@LV2PR21MB3133.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV2PR21MB31334981E02BCA25792BAFFCCF939@LV2PR21MB3133.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-04 18:00:00+0000, Bran Hagger wrote:
> Has there been any further work done on supporting git name changes that I missed? Are there any existing files without git history that face similar issues?
> 
> [1] https://code.googlesource.com/git/summit/2020/+/main/notes.md
> [2] https://lore.kernel.org/git/20210103211849.2691287-1-sandals@crustytoothpaste.net/

There was another proposal posted by brian last year, using signing keys
the author controls instead of hashes:
https://lore.kernel.org/git/20220919145231.48245-1-sandals@crustytoothpaste.net/T/

A different VCS, Pijul, recently adopted a system that seems similar to
brian's proposal, and may provide some inspiration on the user
experience. I haven't seen documentation for it, but there are some
examples of commands here:
https://nest.pijul.com/pijul/pijul/discussions/706
