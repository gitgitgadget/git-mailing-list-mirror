From: Jeff King <peff@github.com>
Subject: Re: What's cooking in git.git (Jun 2011, #03; Fri, 17)
Date: Tue, 21 Jun 2011 21:54:30 -0400
Message-ID: <20110622015430.GB30733@sigill.intra.peff.net>
References: <7viprz6ja2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCeN-00072U-I3
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791Ab1FVByf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:54:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35381
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728Ab1FVByd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:54:33 -0400
Received: (qmail 7867 invoked by uid 107); 22 Jun 2011 01:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:54:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:54:30 -0400
Content-Disposition: inline
In-Reply-To: <7viprz6ja2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176214>

On Tue, Jun 21, 2011 at 01:07:01PM -0700, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
> 
> We have passed v1.7.6-rc2 and it seems things are really in releaseable
> form, so I am tempted to skip -rc3 and tag the final sometime next week.

Yeah, things seem pretty quiet.

> * jk/clone-cmdline-config (2011-06-11) 10 commits
>  - clone: accept config options on the command line
>  - config: make git_config_parse_parameter a public function
>  - remote: use new OPT_STRING_LIST
>  - parse-options: add OPT_STRING_LIST helper
>  - config: use strbuf_split_str instead of a temporary strbuf
>  - strbuf: allow strbuf_split to work on non-strbufs
>  - config: avoid segfault when parsing command-line config
>  - config: die on error in command-line config
>  - fix "git -c" parsing of values with equals signs
>  - strbuf_split: add a max parameter

The bottom 4 are bugfixes that may be maint-worthy. They don't fix
regressions in the 1.7.6 cycle[1], so they are probably not worth
another -rc round, but you may want to consider them for 1.7.6.1.

-Peff

[1] I didn't bisect them, but the relevant feature dates back to 1.7.2,
so they are probably that old.
