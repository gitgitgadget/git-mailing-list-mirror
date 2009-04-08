From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git
	config' access
Date: Wed, 8 Apr 2009 10:12:21 +0200
Message-ID: <20090408081221.GG8940@machine.or.cz>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Apr 08 10:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrSv2-0001hr-T9
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 10:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbZDHIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 04:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbZDHIM1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 04:12:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38786 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbZDHIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 04:12:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3FBDF1E4C02E; Wed,  8 Apr 2009 10:12:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116060>

On Mon, Apr 06, 2009 at 11:46:15AM +1200, Sam Vilain wrote:
> Add a new module, Git::Config, for a better Git configuration API.
> 
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>

I'm really sorry that I probably won't have time soon to properly review
this patch. :-(

> +			throw Error::Simple (
> +				"'$item' is specified multiple times",
> +			       );

So just one comment - in general people seem to be unhappy with this way
of exception handling, preferring die-eval to throw-catch. We might
seize the opportunity here and start using die in all new modules,
keeping Error::Simple only in legacy Git.pm (and its wrappers for the
Git::Config stuff).

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
