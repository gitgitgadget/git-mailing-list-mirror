Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715101F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171AbcHCTWV (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:22:21 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:33417 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbcHCTWT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:22:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id F2141462E72;
	Wed,  3 Aug 2016 20:12:20 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cC-vQ3l9QjkB; Wed,  3 Aug 2016 20:12:19 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 0206B4602FC;
	Wed,  3 Aug 2016 20:12:18 +0100 (BST)
Date:	Wed, 3 Aug 2016 20:12:02 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160803191202.GA22881@salo>
References: <20160729064055.GB25331@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729064055.GB25331@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> 
> I'd welcome any feedback, whether on the interface and workflow, the
> internals and collaboration, ideas on presenting diffs of patch series,
> or anything else.
> 

One other nice thing I've noticed about this tool is the
way series behave like regular git branches: I specify the name
of the series and from then on all other commands act on that
series until told otherwise.

git-appraise looks as though it might also have this behaviour.
I think it's a nice way to do it, since you don't generally
perform more than one review simultaneously. So I may well
use this idea in git-candidate if it's okay. :)

I haven't found time to use the tool to do any serious review
yet, but I'll try and post some more feedback when I do.

Hope this helps,
Richard
