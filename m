From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Fri, 16 May 2008 21:25:28 -0400
Message-ID: <20080517012528.GA15137@foursquare.net>
References: <20080517011614.GA11029@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 03:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxBBu-0005Jq-RZ
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 03:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYEQBZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 21:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYEQBZj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 21:25:39 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:54946 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYEQBZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 21:25:38 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4H1PSHF015723
	for <git@vger.kernel.org>; Fri, 16 May 2008 21:25:28 -0400
Content-Disposition: inline
In-Reply-To: <20080517011614.GA11029@foursquare.net>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82329>

On Fri, May 16, 2008 at 09:16:14PM -0400, Chris Frey wrote:
> 	The drawback to this patch is that once git installs its own
> 	copy, it will always install its own copy, unless the user
> 	uninstalls the old git first.  Usually this is the desired
> 	behaviour, but my perl-fu isn't strong enough to make this
> 	check even smarter.  Ideally, if a newer version is on the
> 	system already, git shouldn't have to install its own.

The other way to deal with this is to put the check in ./configure,
and don't let the user build unless the dependencies are solved.

How important is that private-Error.pm?

- Chris
