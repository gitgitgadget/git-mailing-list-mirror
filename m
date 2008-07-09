From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
	subroutines
Date: Wed, 9 Jul 2008 17:23:40 +0200
Message-ID: <20080709152340.GK10151@machine.or.cz>
References: <200807031824.55958.jnareb@gmail.com> <486D36CB.3090400@gmail.com> <200807040145.14724.jnareb@gmail.com> <48726D5C.9080801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGbX9-000611-Ae
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 17:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYGIPXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbYGIPXp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 11:23:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39043 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbYGIPXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 11:23:44 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 82AAA2C4C023; Wed,  9 Jul 2008 17:23:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48726D5C.9080801@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87888>

On Mon, Jul 07, 2008 at 09:24:12PM +0200, Lea Wiemann wrote:
> Jakub Narebski wrote:
> > Git::Repo / Git::Config could use methods / subroutines from Git.pm;
> 
> I don't think that's possible, since Git.pm has a pretty long-running
> (and complicated) instantiation method, whereas Git::Repo has (and must
> have) instantaneous instantiation (without system calls).

There can be an alternative instantiation method that is faster.

> Also, Git.pm is so strange (design-wise) that I'm not very happy with
> depending on it as it is.  I'll write more about that later though.

I'm curious to hear about your reservations to Git.pm design when you
get to writing up something. But I think you should have _very_ good
reasons for introducing a completely separate alternative API and show
convincingly why the current one cannot be extended and build upon,
since going that way is bound to get quite messy. Please avoid the NIH
syndrome and don't reinvent the wheel needlessly. ;-)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
