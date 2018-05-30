Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758261F51C
	for <e@80x24.org>; Wed, 30 May 2018 11:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeE3LlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 07:41:17 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:58220 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeE3LlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/q4DVTWLTOJdy36sIDbtYGmo57I0M/9z+E6zGroB9Co=; b=vOfpQ3alyCAIa2P3gk86aYe2N8
        QaLyGrLWZBDsdJv7m7P1wI52EFbRjkHyi8JPPZcZDxVDb3RjdwpjvGHNrSHy4GnCncUlZ6CGlcksu
        hl11tSj3ArNZmsC4RBrCw9gSPrz3MuNDDTx6/O398klIrKznkmT5G3OyHy+dMQZCKmITdus3DTISz
        NbnQLcu8Tejh5+CbELRM8kkBQuHPKpT4SqI8iuhF62A+pbEBOZtrMtS68FICsZ9XmRU7D10EgwKuM
        kATvj+9mmjIyJ8MHZ8LLppJtSPasTWEX8x8awpCvxoqbmGROERCH9HIfZovhHaOL+27OJdaOcpG97
        VPdwaNgg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:51408 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNzTb-00ELGm-SQ
        for git@vger.kernel.org; Wed, 30 May 2018 07:41:12 -0400
Date:   Wed, 30 May 2018 07:39:15 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: verifying syntax for optional and replaceable content in man pages
Message-ID: <alpine.LFD.2.21.1805300733440.10096@localhost.localdomain>
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


  willing to submit some patches to standardize the syntax of man
pages in terms of rendering "optional" and/or "replaceable" content,
and it seems like "man git-config" would be a good place to start:

SYNOPSIS
       git config [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
       git config [<file-option>] [type] --add name value
       git config [<file-option>] [type] --replace-all name value [value_regex]
       ...snip ...

  can i assume the proper (uniform) syntax for the above would be
(shortening lines):

  ... [<type>] [--show-origin] [-z|--null] <name> [<value> [<value_regex>]]
  ... [<type>] --add <name> <value>
  ... [<type>] --replace-all <name> <value> [<value_regex>]

and so on. is that the consensus? i wouldn't try to do it all at once,
maybe just a page at a time to not be too disruptive.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
