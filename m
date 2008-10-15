From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git graph on GitHub
Date: Wed, 15 Oct 2008 14:20:22 +0200
Message-ID: <20081015122022.GW10544@machine.or.cz>
References: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq5Ns-0005ZE-52
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYJOMUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYJOMU3
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:20:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52650 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbYJOMU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:20:28 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 82EB01E4C02B; Wed, 15 Oct 2008 14:20:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98267>

  Hi,

On Wed, Oct 15, 2008 at 12:47:52AM -0700, Tom Werner wrote:
> We've just pushed out an update to the Network Graph on GitHub this
> evening that finally allows us to draw very large repositories
> (including Git). We're mirroring the Git repo on the site and I
> thought it might be interesting for people to see this visualization.
> Enjoy!
> 
> http://github.com/git/git/network
> 
> Let me know if you have any ideas for improvements on the graph. I'm
> always looking for ways to enhance it.

  it's generally nice, but I think it could be much more useful yet. :-)

  Generally, I find its information density very low. I see only tiny
dots connected by lines at the top of the screen (rest grey) and if I
want to know _what_ commits are actually there, I need to carefully
hover over the scattered tiny dots. So my question is, exactly what kind
of information do you seek to present primarily? Based on what I see,
the answer seems to be just "how hairy the project history is", and I'm
wondering if maybe some other class of information would be more
interesting. IOW, what about using that blank grey area to show the
commit subjects? ;-)

  Right now, your repository contains only the 'master' branch. I guess
you want to setup a --mirror repository instead of pulling?

  Also, it would be pretty nifty if you could tag lines of past topic
branches based on the merge commit message. E.g. mark the blue line
short in the past as pb/gitweb-tagcloud based on the 3e3d4ee merge. On
the other hand, I'm not sure how well would it work visually if the
topic branches are very short and merged right away.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
