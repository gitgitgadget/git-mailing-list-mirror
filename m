From: Alex Vandiver <alex@chmrr.net>
Subject: Re: git-config: case insensitivity for subsections
Date: Sun, 28 Aug 2011 20:50:31 -0400
Message-ID: <1314579031.10094.19.camel@umgah.localdomain>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
	 <20110825205849.GA10384@sigill.intra.peff.net>
	 <20110825215757.GA94231@hal.rescomp.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: milki <milki@rescomp.berkeley.edu>
X-From: git-owner@vger.kernel.org Mon Aug 29 03:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxqd2-0007fj-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 03:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab1H2B0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 21:26:35 -0400
Received: from chmrr.net ([209.67.253.66]:42848 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1H2B0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 21:26:33 -0400
X-Greylist: delayed 2148 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Aug 2011 21:26:33 EDT
Received: from c-67-186-135-157.hsd1.ma.comcast.net ([67.186.135.157] helo=[10.0.1.27])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1Qxq3h-00075T-Lw; Sun, 28 Aug 2011 20:50:41 -0400
In-Reply-To: <20110825215757.GA94231@hal.rescomp.berkeley.edu>
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2011-08-28 20:50:41
X-Connected-IP: 67.186.135.157:32889
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180290>

On Thu, 2011-08-25 at 14:57 -0700, milki wrote:
> This was simply surprising as I was trying to figure out what exactly
> case sensitivity meant and how it affected sections. This definitely
> clears this up for me. I'm actually working on a config parser because I
> don't think I've seen a complete implementation besides git-config in a
> different language.

For reference, https://github.com/bestpractical/config-gitlike/ is a
complete parser for git config files written in perl, which passes git's
config test suite (among other tests).  Which is not terribly
surprising, since its parsing algorithm is strongly derived from
config.c's.
 - Alex
