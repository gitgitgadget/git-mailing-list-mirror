Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4FA2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 15:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbcKOPKP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 10:10:15 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:37380 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbcKOPKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 10:10:15 -0500
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6fND-0003Fa-IM; Tue, 15 Nov 2016 16:10:11 +0100
Date:   Tue, 15 Nov 2016 16:10:09 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     ravalika <prenuka@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git status takes too long- How to improve the performance of git
Message-ID: <20161115151009.GB7854@book.hvoigt.net>
References: <1479202392275-7657456.post@n2.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479202392275-7657456.post@n2.nabble.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 02:33:12AM -0700, ravalika wrote:
> Number of files - 63883

Since you also posted this to the "Git for Windows" mailinglist I assume
that you are using Windows. Reduce the number of files. For example
split the repository into two one for documentation and one for source.
Thats what I did with a converted repository that had to many files.

Windows is unfortunately very slow when it comes to handling many files
and if I recall correctly ~30000 files was in a nicely handleable range
for a Git repository on Windows, but that might have changed...

Cheers Heiko
