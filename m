From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [WIP PATCH 0/3] implement merge strategy for submodule
	links
Date: Sat, 19 Jun 2010 12:17:41 +0200
Message-ID: <20100619101736.GA3539@book.hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de> <201006181140.16652.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 19 12:19:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPv91-0003m5-Mo
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 12:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab0FSKRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 06:17:42 -0400
Received: from darksea.de ([83.133.111.250]:35536 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750985Ab0FSKRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 06:17:42 -0400
Received: (qmail 15914 invoked from network); 19 Jun 2010 12:17:40 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 19 Jun 2010 12:17:40 +0200
Content-Disposition: inline
In-Reply-To: <201006181140.16652.johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149377>

Hi,

On Fri, Jun 18, 2010 at 11:40:16AM +0200, Johan Herland wrote:
> [1]: To put the search in general terms: Find all merge commits that has 
> _both_ (or in the case of octopus; _all_) of the candidate commits (but none 
> of the other merges) somewhere in its ancestry. You could implement this by 
> first intersecting the sets returned from these commands (run in the 
> submodule):
> 
>   git rev-list --merges --ancestry-path --all ^B
>   git rev-list --merges --ancestry-path --all ^F
> 
> to get the set of merges descending from both 'B' and 'F', and then prune 
> each member in the remaining set that has another set member in its 
> ancestry.

Is the --ancestry-path option already implemented? Because on my git
1.7.1 it does not seem to. What does it do?

cheers Heiko
