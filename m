From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] stash: Utilize config variable pager.stash.list in stash list command
Date: Thu, 18 Aug 2011 09:55:37 +0200
Message-ID: <4e4cc57e.51253792.bm000@wupperonline.de>
References: <20110818042620.GA19045@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 09:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtxVt-0002xV-CH
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab1HRH7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:59:36 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:51547 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755278Ab1HRH7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:59:35 -0400
Received: from point.localnet (mue-88-130-76-166.dsl.tropolys.de [88.130.76.166])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id F2B9811E37A5
	for <git@vger.kernel.org>; Thu, 18 Aug 2011 09:59:33 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QtxVl-17m-00 for <git@vger.kernel.org>; Thu, 18 Aug 2011 09:59:33 +0200
In-Reply-To: <20110818042620.GA19045@sigill.intra.peff.net>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179580>

Jeff King wrote on Wed, 17 Aug 2011 21:26:37 -0700:

> On Wed, Aug 17, 2011 at 11:44:32AM -0700, Junio C Hamano wrote:

>> What's so difficult to say "git stash list | less" or even "git -p
>> stash list"?

> Anyway, I think his problem is not "I want a pager but I am too lazy to
> type it", but rather that "git stash list" will auto-paginate by
> default, because it is chaining to "log", which auto-paginates. You can
> turn it off with "--no-pager", but pager.stash seems to have no effect.

I'd like to mention that in this particular case it is ok that stash
auto-paginates, it only is annoying that "stash list" does. And, Junio,
it is totally ok to say "git -p stash list" then, because this is exactely
what I'd do.

Ingo
