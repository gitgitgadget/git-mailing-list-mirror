From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 20:59:07 +0200
Message-ID: <20061018185907.GV20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 20:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGdG-0002S2-8H
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 20:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWJRS7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWJRS7K
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 14:59:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41355 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161007AbWJRS7J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 14:59:09 -0400
Received: (qmail 3069 invoked by uid 2001); 18 Oct 2006 20:59:07 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20061018185225.GU20017@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29251>

Dear diary, on Wed, Oct 18, 2006 at 08:52:25PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Wed, Oct 18, 2006 at 04:52:25PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > In other words, to get such a pack, we'd _literally_ just do something 
> > like
> > 
> > 	git-rev-list --objects-edge origin.. |
> > 		git-pack-objects --stdout |
> > 		uuencode
> > 
> > and that would be it. You'd still need to add a "diffstat" to the thing, 
> > and tell the other end what the current HEAD is (so that it knows what 
> > it's supposed to fast-forward to), but it _literally_ is that simple.
> > 
> > "plug-in architecture" my ass. "I recognize this - it's UNIX!".
> 
> Took me exactly an hour from mkdir cogito-bundle to cg-push to
> kernel.org. :-)

By the way, originally I just wanted to index and save the pack, but
when trying to feed it to git-index-pack, I kept getting

	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas

while feeding it to git-unpack-objects works fine. Any idea what's wrong?

(BTW, I got the id by sha1summing the pack file; is there an existing
way to name a pack properly if I have it lying around, unnamed? sha1sum
seems to be specific to a fairly new GNU coreutils version.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
