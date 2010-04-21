From: Petr Baudis <pasky@suse.cz>
Subject: Re: CIA hook for contrib/
Date: Wed, 21 Apr 2010 23:04:27 +0200
Message-ID: <20100421210427.GF3563@machine.or.cz>
References: <20100327102632.GA5043@thyrsus.com>
 <20100421101002.GD3563@machine.or.cz>
 <20100421155149.GA11223@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:04:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4h66-00021l-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab0DUVEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:04:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55803 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab0DUVEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:04:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B17FC125A174; Wed, 21 Apr 2010 23:04:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100421155149.GA11223@thyrsus.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145453>

Thanks for doing all the changes!

On Wed, Apr 21, 2010 at 11:51:49AM -0400, Eric Raymond wrote:
> Petr Baudis <pasky@suse.cz>:
> > I would personally prefer to have this configurable; I consider trying
> > to protect your e-mail address against harvesters is a lost fight anyway
> > and you'd be much better off just getting a good spam filter, rather
> > than making yours and others' life harder by trying to fight in vain.
> > But it's not too important for me since I can just disable this easily.
> 
> But email name collisions within projects are vanishingly rare, so I
> don't see a lot of benefit in publishing the FQDN.

That's a good point, I guess I was just ranting in general. ;-)

> > Your life would be much easier in both the shell and python script if
> > you used something like:
> > 
> > 	git log -1 '--pretty=format:%an <%ae>%n%at%n%s'
> > 
> > You would also get <ts> in the correct format, incl. timezone correction.
> 
> Good point.  I inherited that nasty code; perhaps this facility did not
> exist when it was written.

It most probably wasn't, the original perl script in particular was
written at the very dawn of time from git history perspective.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
