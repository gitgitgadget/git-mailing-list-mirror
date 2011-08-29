From: milki <milki@rescomp.berkeley.edu>
Subject: Re: git-config: case insensitivity for subsections
Date: Sun, 28 Aug 2011 22:42:40 -0700
Message-ID: <20110829054240.GB94231@hal.rescomp.berkeley.edu>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
 <20110825205849.GA10384@sigill.intra.peff.net>
 <20110825215757.GA94231@hal.rescomp.berkeley.edu>
 <1314579031.10094.19.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 07:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxucP-0000T8-RX
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 07:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab1H2Fmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 01:42:42 -0400
Received: from hal.Rescomp.Berkeley.EDU ([169.229.70.150]:63280 "EHLO
	hal.rescomp.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1H2Fmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 01:42:40 -0400
Received: by hal.rescomp.berkeley.edu (Postfix, from userid 1070)
	id 3AA6B119E35; Sun, 28 Aug 2011 22:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314579031.10094.19.camel@umgah.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180295>

On 20:50 Sun 28 Aug     , Alex Vandiver wrote:
> For reference, https://github.com/bestpractical/config-gitlike/ is a
> complete parser for git config files written in perl, which passes git's
> config test suite (among other tests).  Which is not terribly
> surprising, since its parsing algorithm is strongly derived from
> config.c's.

Yes, I've been looking at it and forked a majority of it into python,
but I can't seem to replicate some of the expected quoting behaviour of
git-config, among other things (now off-topic). My implementation so
far can be seen at [0]. A user gave me a link [1] to his git-config
and I cannot correctly parse, for example, his alias.last.

-milki


[0] https://github.com/jelmer/dulwich/pull/31#issuecomment-1918904
[1] https://github.com/kergoth/homefiles/blob/master/.gitconfig#L67
