From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cvsserver: avoid warning about active db handles
Date: Tue, 25 Jul 2006 17:52:59 +0200
Message-ID: <20060725155259.GU13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44C6099A.5010205@catalyst.net.nz> <Pine.LNX.4.63.0607251649190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 17:53:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5PDh-0005QP-QJ
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 17:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWGYPxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 11:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGYPxC
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 11:53:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2698 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932437AbWGYPxB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 11:53:01 -0400
Received: (qmail 11882 invoked by uid 2001); 25 Jul 2006 17:52:59 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607251649190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24177>

  Hi,

Dear diary, on Tue, Jul 25, 2006 at 04:53:16PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > That's harder. I wonder whether using libgit's XS module we can now get 
> > libgit to give us a gzipped file directly. I guess it only has 
> > performance savings for unpacked repos.

  the object in the database is compressed together with the header, so
we have to recompress it anyway.

> I still have the problem on at least two of my boxes that Git.xs does not 
> load.

  What is the problem? I must have overlooked it, sorry. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
