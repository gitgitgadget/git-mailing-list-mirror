Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0B61F859
	for <e@80x24.org>; Thu,  1 Sep 2016 04:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbcIAEIy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 00:08:54 -0400
Received: from do.snorge.com ([162.243.6.197]:51357 "EHLO snorge.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbcIAEIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 00:08:53 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Sep 2016 00:08:53 EDT
Received: by snorge.com (Postfix, from userid 1003)
        id 55C1C286D4; Wed, 31 Aug 2016 23:01:07 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sabbey.net; s=mail;
        t=1472702467; bh=ByGf9Vcer5pz+cB2WZgng+IRI/RKCV3ewkmibOtADQg=;
        h=Date:From:To:Subject:Reply-To:From;
        b=nqMRCpsQMX0jFdZxc6pfW+yKhPcbqgXlLIMakLoqprxjv3jk3cztDxawiN6tsk744
         QbC7IxTCmFNL3dcsPBbSWFS7S+xkPNO3Vsz6dboTDovTVJ1BmlMrHQp6Ko4IRoGAwa
         ZVjvLWgmZme9HCzJ4+zR7JFL2dn89r9VwwQVPmZA=
Date:   Wed, 31 Aug 2016 23:01:07 -0500
From:   Scott Abbey <scott@sabbey.net>
To:     git@vger.kernel.org
Subject: Re: Literate programming with git
Message-ID: <20160901040107.GB19210@snorge.com>
Reply-To: CAGZ79kbOMa5e5pUi+pA1JUSehFYMyCot+ZRWbORgwq2xCqvnZg@mail.gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> How does the linearify/dendrify work with already non-linear history?

The current implementation using magic strings in commit messages
seems incompatible with existing projects.

How about annotating an existing project with git-notes instead? You
could add notes to existing commits without needing to rewrite history.
