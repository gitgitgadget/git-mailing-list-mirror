From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Fri, 19 Aug 2011 00:33:01 +0200
Message-ID: <4e4d94bb.00b9e5c4.bm000@wupperonline.de>
References: <20110818215820.GA7767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:40:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBFx-00019c-0G
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab1HRWkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:40:01 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:52516 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab1HRWkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:40:00 -0400
Received: from point.localnet (mue-88-130-87-097.dsl.tropolys.de [88.130.87.97])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id DC52211E363C
	for <git@vger.kernel.org>; Fri, 19 Aug 2011 00:39:58 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QuBFl-32g-00 for <git@vger.kernel.org>; Fri, 19 Aug 2011 00:39:57 +0200
In-Reply-To: <20110818215820.GA7767@sigill.intra.peff.net>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179649>

Jeff King wrote on Thu, 18 Aug 2011 14:58:20 -0700:

> I think Ingo's original complaint was simply that pager.stash didn't
> actually do anything, not that he wanted some separate config for the
> various subcommands.

No, you're wrong.

My goal was to be able to turn off paging for "stash list" only while all
other stash commands should continue paging.

It is, of course, very usefull to be able to control paging for external
commands and aliases, but in my case I originally wanted to control a
specific subcommand.

Ingo
