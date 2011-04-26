From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2011, #06; Mon, 25)
Date: Tue, 26 Apr 2011 04:13:50 -0400
Message-ID: <20110426081350.GB26874@sigill.intra.peff.net>
References: <7v39l6hqog.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 10:14:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEdPI-000815-M3
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab1DZINz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:13:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42225
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1DZINy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 04:13:54 -0400
Received: (qmail 16245 invoked by uid 107); 26 Apr 2011 08:15:32 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Apr 2011 04:15:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2011 04:13:50 -0400
Content-Disposition: inline
In-Reply-To: <7v39l6hqog.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172075>

On Mon, Apr 25, 2011 at 04:11:43PM -0700, Junio C Hamano wrote:

> * jk/maint-merge-rename-create (2011-03-25) 3 commits
>  - merge: turn on rewrite detection
>  - merge: handle renames with replacement content
>  - t3030: fix accidental success in symlink rename
> 
> Peff wanted to reroll this, so this is taken out of "next".

Thanks. I have a reproducible bug with this series, but it's with a
giant repo, so I'm trying to narrow it down to a smaller test case.

> * jk/maint-push-async-hang (2011-03-31) 4 commits
>  - send-pack: abort sideband demuxer on pack-objects error
>  - run-command: allow aborting async code prematurely
>  - finish_async: be quiet when waiting for async process
>  - teach wait_or_whine a "quiet" mode
>  (this branch is used by jk/maint-push-async-hang-threads.)
> 
> * jk/maint-push-async-hang-threads (2011-03-31) 2 commits
>  - run-command: implement abort_async for pthreads
>  - Merge branch 'jk/maint-push-async-hang' into jk/maint-push-async-hang-threads
>  (this branch uses jk/maint-push-async-hang.)
> 
> These two series aim for a good goal, but needs reroll after 1.7.5 with
> sign-offs.

These are redundant with the
js/maint-*-send-pack-stateless-rpc-deadlock-fix topics. They aim for a
different, more general solution, and it's possible we would want that
solution eventually for some other part of the code, but I don't see a
need to introduce it now. So I think they can be dropped.

-Peff
