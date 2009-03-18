From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git {log,diff} against tracked branch?
Date: Wed, 18 Mar 2009 19:26:03 +0100
Message-ID: <20090318182603.GM8940@machine.or.cz>
References: <200903181448.50706.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0UO-0004ZS-E8
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367AbZCRS0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758182AbZCRS0J
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:26:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57400 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756653AbZCRS0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:26:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6B8C01E4C030; Wed, 18 Mar 2009 19:26:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200903181448.50706.agruen@suse.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113647>

  Hi,

On Wed, Mar 18, 2009 at 02:48:50PM +0100, Andreas Gruenbacher wrote:
> I often want to see what the differences are between a local branch and the 
> branch it tracks (if it tracks a branch). I currently do something like "git 
> log master..origin/master". This is a lot of unnecessary typing though 
> compared to something like "git log -t master", or even "git log -t" when on 
> the master branch.

  sorry, I think Git can't do anything like this either. :-(

  However, I think something like this would be useful and probably easy
to do? Maybe someone on the list will get inspired to implement
a special refspec character to represent the "tracked branch"
relationship, so e.g. %master would expand to %origin/master. Then you
should be able to do something like:

	git log %..

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
