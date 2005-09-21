From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 12:06:31 +0200
Message-ID: <20050921100631.GQ14206@kiste.smurf.noris.de>
References: <11253960093915-git-send-email-martin@catalyst.net.nz> <pan.2005.09.21.07.33.14.533314@smurf.noris.de> <20050921081547.GA24902@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 12:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI1VQ-0007BC-Cf
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVIUKHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVIUKHA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:07:00 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:61643 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750808AbVIUKG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 06:06:59 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EI1Ul-00079Q-VP; Wed, 21 Sep 2005 12:06:43 +0200
Received: (nullmailer pid 24899 invoked by uid 501);
	Wed, 21 Sep 2005 10:06:31 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050921081547.GA24902@pasky.or.cz>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9038>

Hi,

Petr Baudis:
> 
> $filter is a file name. -s tests whether the file of that name exists
> and is non-empty.
> 
True -- but it's still a bug.

If the name itself is empty (or has spaces), you get wrong results.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #385:

Dyslexics retyping hosts file on servers
