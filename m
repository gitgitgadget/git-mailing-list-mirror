From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 14:38:45 -0400
Message-ID: <20160422183844.GB7595@sigill.intra.peff.net>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
 <20160422044258.GA31619@sigill.intra.peff.net>
 <xmqqa8klr21p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:39:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfyx-0004L3-6s
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbcDVSit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:38:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:54319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbcDVSis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:38:48 -0400
Received: (qmail 18332 invoked by uid 102); 22 Apr 2016 18:38:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:38:47 -0400
Received: (qmail 8976 invoked by uid 107); 22 Apr 2016 18:38:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:38:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 14:38:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8klr21p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292241>

On Fri, Apr 22, 2016 at 10:22:42AM -0700, Junio C Hamano wrote:

> >> * jk/push-client-deadlock-fix (2016-04-20) 5 commits
> [...]
> Thanks.  Something like this, perhaps?
> 
>   "git push" from a corrupt repository that attempts to push a large
>   number of refs deadlocked; the thread to relay rejection notices
>   for these ref updates blocked on writing them to the main thread,
>   after the main thread at the receiving end notices that the push
>   failed and decides not to read these notices and return a failure.

Yep, that's perfect.

> >> * da/user-useconfigonly (2016-04-01) 2 commits
> [...]
> What often happens is that I start waiting, and then when
> necessary actions to move things forward is never taken, and there
> are many other topics that need my attention to move forward, I stop
> caring, especially when the topic is not something other people care
> about (if the original author does not care deeply enough, why
> should we?).
> 
> Let me read it over again as it has been a while and then move it
> forward with your Reviewed-by's.

It is a minor bugfix, but I think worth doing. Adding reviewed-by me is
definitely fine.

-Peff
