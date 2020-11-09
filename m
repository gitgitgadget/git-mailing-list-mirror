Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEFC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A29C2076E
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgKIKRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:17:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:47504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKIKRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 05:17:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41209ABCC;
        Mon,  9 Nov 2020 10:17:40 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:17:38 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc ineffective
Message-ID: <20201109101738.GW29778@kitsune.suse.cz>
References: <20201109092041.GV29778@kitsune.suse.cz>
 <87361ilv1a.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87361ilv1a.fsf@igel.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 10:49:21AM +0100, Andreas Schwab wrote:
> On Nov 09 2020, Michal Suchánek wrote:
> 
> > I noticed I am running out of disk space, and one repository taking up
> > about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
> > and git would report it does gc after every commit.
> 
> Do you have a lot of loose objects?
{ for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
53392

> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
