Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915661F51C
	for <e@80x24.org>; Fri, 25 May 2018 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935800AbeEYHlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 03:41:40 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:60095 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935429AbeEYHlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 03:41:39 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 25 May 2018 09:42:07 +0200
  id 00000000000000BD.000000005B07BE4F.00001560
Date:   Fri, 25 May 2018 09:41:37 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] Use proper syntax for replaceables in command docs
Message-ID: <20180525074137.GA10300@ruderich.org>
References: <alpine.LFD.2.21.1805241610030.7254@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805241610030.7254@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 04:11:39PM -0400, Robert P. J. Day wrote:
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 37b96c545..f98b7c6ed 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -22,7 +22,7 @@ cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
>  Usage:
>
>  [verse]
> -'git-cvsserver' [options] [pserver|server] [<directory> ...]
> +'git-cvsserver' [<options>] [pserver|server] [<directory> ...]

No space in front of "..." for consistency?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
