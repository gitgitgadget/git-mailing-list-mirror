From: Petr Baudis <pasky@suse.cz>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 22:14:21 +0200
Message-ID: <20110417201421.GV3258@machine.or.cz>
References: <201102142039.59416.jnareb@gmail.com>
 <201104141154.55078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:23:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBYV9-0003jk-P9
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 22:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab1DQUXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 16:23:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40573 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab1DQUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 16:23:01 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Apr 2011 16:23:01 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id 423FA1700280; Sun, 17 Apr 2011 22:14:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201104141154.55078.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171730>

  Hi!

On Thu, Apr 14, 2011 at 11:54:53AM +0200, Jakub Narebski wrote:
> Unfortunately the decision to use JavaScript framework brings its own
> new problems.
> 
> First issue is which JavaScript framework or library to use:
> * jQuery (lightweight, most popular, used e.g. by MediaWiki)
> * MooTools (lightweight, 2nd most popular, opbject-oriented)
> * YUI, The Yahoo! User Interface Library 
> * other: Prototype, Dojo, ExtJS, SproutCore,...

  Girocco uses MooTools, and I also used it in an old private branch
of gitweb. I have had pretty good experience with it. But since I wasn't
able to find anyone to maintain Girocco's gitweb (or even keep it in
sync with upstream) and the patch flow to core git has dried up, it's
probably not too relevant argument. :-)

> So what are your ideas and comments on the issue of JavaScript code
> and JavaScript libraries / frameworks in gitweb?

  It seems most common sense to use CDN by default but allow providing
pre-downloaded file with the library at build time as an alternative.

-- 
				Petr "Pasky" Baudis
UNIX is user friendly, it's just picky about who its friends are.
