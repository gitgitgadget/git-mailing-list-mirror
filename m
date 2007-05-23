From: Petr Baudis <pasky@suse.cz>
Subject: Re: HTTP trees trailing GIT trees
Date: Wed, 23 May 2007 16:05:52 +0200
Message-ID: <20070523140552.GN4489@pasky.or.cz>
References: <loom.20070523T154909-285@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Wed May 23 16:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqrTS-0006Ev-GL
	for gcvg-git@gmane.org; Wed, 23 May 2007 16:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbXEWOFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 10:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbXEWOFy
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 10:05:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33978 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337AbXEWOFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 10:05:53 -0400
Received: (qmail 5372 invoked by uid 2001); 23 May 2007 16:05:52 +0200
Content-Disposition: inline
In-Reply-To: <loom.20070523T154909-285@post.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48157>

  Hi,

On Wed, May 23, 2007 at 04:01:33PM CEST, Panagiotis Issaris wrote:
> I reported this to the person who had setup the repository:
> http://article.gmane.org/gmane.comp.video.ffmpeg.devel/51151
> 
> But unfortunately, the problem seems to remain.
> 
> Is this a known problem, or might this be a bug or misconfiguration?

  did any push happenned since the post-update hook was enabled? It
takes effect only after the next push. So far,

	http://git.mplayerhq.hu/ffmpeg/info/refs

and

	http://git.mplayerhq.hu/ffmpeg/refs/heads/master

is still out-of-sync (keeping this in sync is what is the job of the
post-update hook, or git-update-server-info respectively).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
