Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975AE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 12:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937884AbeFSMzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 08:55:22 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:40568 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937858AbeFSMzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 08:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9eXoTyKqsUao7ngdltHZhYkovC0BIzhuTsQ55q+rakI=; b=Ljg9IpcLI+4Cf5gHJUV9mSL6q0
        3f5cdstBZxpIJm8GqT/E5yOopAxj6HxU2XoC4EsWoMH6sJO14w4PZiToqbDP2PK1k6WruwmFKLNXD
        A+V4rI1Pa0VdkllOTSd0oABqkqp0dvEPGgCVqEKHiOee2+UgKO8P7IsvD6n18wl/5iF0Am0BpQiUC
        KSHB3B1Q5/3+KWcARzc5sboqlcOx9JoLTugAnePKKiLPdh2l+vYRH2LZaiwLJ/PfMVmWowV8tYPmz
        rreGtP+h69PDkYt78FeKT3lsRB/0aTE5TBRBoMNrbHv7JLL7M6/3UFA4ty11OsVl6h2JbBEu9cVMT
        wzXBv5Qg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:49696 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fVGAG-008XGY-4X
        for git@vger.kernel.org; Tue, 19 Jun 2018 08:55:17 -0400
Date:   Tue, 19 Jun 2018 08:55:14 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: recommendations for practical git config settings for
 /etc/gitconfig?
Message-ID: <alpine.LFD.2.21.1806190845170.13482@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  updating some git course material, and i want to add to the config
section at least a small number of example config settings that make
practical sense to add to the system /etc/gitconfig file. that is,
config settings that, even if i don't explain them fully, even novice
git users will appreciate that such settings make sense to apply to
*all* users on a system.

  i imagine that would include any (corporate-mandated) settings
related to networking authentication and protocols,
filesystem-related settings and more, such as:

  * core.protect{HFS,NTFS}
  * whitespace/EOL settings
  * proxy/ssh-related commands
  * http.* settings
  * some sendemail settings

you get the idea. i don't have a ton of experience configuring git in
an enterprise setting, so while there are a zillion config settings
one *could* add to /etc/gitconfig, i'm interested in what experienced
git admins can testify really make sense to set in a corporate
environment. does that make sense?

  open to thoughts ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
