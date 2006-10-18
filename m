From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:42:09 +0200
Message-ID: <20061018004209.GL20017__44651.6417236582$1161134941$gmane$org@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018002523.GJ20017@pasky.or.cz> <4535778D.40006@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Sean <seanlkml@sympatico.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:49:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzVe-0000Q6-V4
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJRAmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWJRAmM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:42:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23184 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751194AbWJRAmK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:42:10 -0400
Received: (qmail 15967 invoked by uid 2001); 18 Oct 2006 02:42:09 +0200
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <4535778D.40006@utoronto.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29161>

Dear diary, on Wed, Oct 18, 2006 at 02:38:37AM CEST, I got a letter
where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> Petr Baudis wrote:
> >> this only makes sense if
> >> you have a fast access to the repository (otherwise, you consider your
> >> local repository as a cache, and you're ready to pay the disk space
> >> price to save your bandwidth). In this case, it's often in your
> >> filesystem (local or NFS).
> > 
> > So how is the light checkout actually implemented? Do you grab the
> > complete new snapshot each time the remote repository is updated?
> 
> No, the lightweight checkouts store very little.  They have
> - a copy of tree shape (filenames, paths, sha1 sums) from the last
>   commit.
> - a copy of tree shape for the current working directory
> - a map from stat values to sha-1 hashes

I see, I guess that means "the index file and tree objects for the last
commit" in git-speak. Thanks.

> > Do all
> > the (at least read-only, like "log" and "diff", perhaps "status")
> > commands work on such a light checkout?
> 
> Yes.  And if you check out from a read-write branch, all write commands,
> work, too.

Ok, one last question - do you do most of the work locally, fetching
bits of data as you need, or remotely, only taking input/producing
output over the network (the pserver model)?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
