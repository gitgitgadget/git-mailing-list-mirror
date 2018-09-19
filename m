Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06671F453
	for <e@80x24.org>; Wed, 19 Sep 2018 23:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbeITExq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 00:53:46 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:46348 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITExq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 00:53:46 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g2lf2-0004DZ-Fu; Wed, 19 Sep 2018 19:13:32 -0400
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 4C1813EE59;
        Wed, 19 Sep 2018 16:13:27 -0700 (PDT)
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1g2lew-00050R-9e; Wed, 19 Sep 2018 16:13:26 -0700
Date:   Wed, 19 Sep 2018 16:13:26 -0700
From:   frederik@ofb.net
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] git-archimport.1: specify what kind of Arch we're
 talking about
Message-ID: <20180919231326.GG22921@ofb.net>
Reply-To: frederik@ofb.net
References: <20180919201231.609-1-frederik@ofb.net>
 <20180919201231.609-2-frederik@ofb.net>
 <xmqqsh252iwp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh252iwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think "Is it a CPU archtecture?" is a red-herring, but between

It wasn't meant to be a red-herring though. Plenty of Linux
distributions have different architecture-specific package repos, and
arch is a common abbreviation for architecture. This only comes up if
you search for the full word e.g. "linux architecture repository"
since other wise Arch Linux dominates all the search results.

A bit of a tangent...

Frederick

> "What is an Arch Repository?" and "What is GNU Arch?" there indeed
> is a vast difference in the quality of information readers would
> get; with the proposed commit log message that ends with "so people
> can find it with search engines", I am reasonably sure this is an
> improvement worth having.
> 
> Thanks.
