Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BB520365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdJCKeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:34:36 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:55072 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdJCKef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:34:35 -0400
Received: from [::1] (port=49396 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dzKX4-00012b-UT
        for git@vger.kernel.org; Tue, 03 Oct 2017 06:34:34 -0400
Received: from 158.116.144.29 ([158.116.144.29]) by crashcourse.ca (Horde
 Framework) with HTTPS; Tue, 03 Oct 2017 06:34:34 -0400
Date:   Tue, 03 Oct 2017 06:34:34 -0400
Message-ID: <20171003063434.Horde.nbQwMWrv0wS_naxhawU5YlG@crashcourse.ca>
From:   rpjday@crashcourse.ca
To:     git@vger.kernel.org
Subject: "man git-config", "--list" option misleadingly refers to "config
 file" (singular)
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday@crashcourse.ca
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


   (i suppose that if i'm going to continue whining about stuff, i might
as well clone the git source and start submitting patches.)

   in "man git-config":

     -l
     --list
           List all variables set in config file, along with their values.
                                            ^^^^

except that, AIUI, "git config --list" will list the combination of all
config values in (if it exists) /etc/gitconfig, then the user's global
settings, and finally the repo's config settings if one happens to be
in a working directory, so technically, it lists the contents of *all* of
the config files (plural), no?

   i can submit a patch to clarify that, unless there's some weird definition
of "config file" that implicitly means the combination of all of them.

rday

