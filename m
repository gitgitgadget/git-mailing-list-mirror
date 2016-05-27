From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2016, #08; Thu, 26)
Date: Thu, 26 May 2016 20:36:21 -0400
Message-ID: <20160527003621.GB26262@sigill.intra.peff.net>
References: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 02:36:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b65lS-0000ma-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 02:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbcE0AgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 20:36:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:44945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755289AbcE0AgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 20:36:24 -0400
Received: (qmail 25622 invoked by uid 102); 27 May 2016 00:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:36:24 -0400
Received: (qmail 24810 invoked by uid 107); 27 May 2016 00:36:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:36:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 20:36:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295705>

On Thu, May 26, 2016 at 03:50:14PM -0700, Junio C Hamano wrote:

> * jk/upload-pack-hook (2016-05-24) 6 commits
>  - upload-pack: provide a hook for running pack-objects
>  - config: add a notion of "scope"
>  - config: return configset value for current_config_ functions
>  - config: set up config_source for command-line config
>  - git_config_parse_parameter: refactor cleanup code
>  - git_config_with_options: drop "found" counting
> 
>  Allow a custom "git upload-pack" replacement to respond to
>  "fetch/clone" request.
> 
>  Will merge to 'next'.

I just sent a replacement for the fourth patch that avoids the t/helper
problem. It's probably worth dealing with before even hitting "next" so
as not to break bisection.

You should probably hold off on merging the top one. The discussion
stalled because I was on vacation, but it has resumed now (the earlier
refactoring bits are uncontroversial, I think).

-Peff
