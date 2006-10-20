From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 00:40:30 +0200
Message-ID: <20061020224030.GL20017@pasky.or.cz>
References: <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <eh76np$trg$1@sea.gmane.org> <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE> <4538D724.5040508@utoronto.ca> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 00:40:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb32a-0000XY-TQ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992724AbWJTWkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJTWkd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:40:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36588 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030259AbWJTWkc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 18:40:32 -0400
Received: (qmail 17220 invoked by uid 2001); 21 Oct 2006 00:40:30 +0200
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <4538EC8F.7020502@utoronto.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29546>

Dear diary, on Fri, Oct 20, 2006 at 05:34:39PM CEST, I got a letter
where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jakub Narebski wrote:
> > Aaron Bentley wrote:
> >>In Bazaar bundles, the text of the diff is an integral part of the data.
> >> It is used to generate the text of all the files in the revision.
> > 
> > 
> > I thought that the diff was combined diff of changes.
> 
> It is.  It's a description of how to produce revision X given revision
> Y, where Y is the last-merged mainline revision.

Aha, so by default a bundle can carry just a _single_ revision?

That doesn't sound right either, because then it wouldn't make sense to
talk about "combined" or "simple" diffs. So I guess sending a bundle
really is taking n revisions at your side, bundling them to a single
diff and when the other side takes it, it will result in a single
revision? That is basically what our merge --squash does.

Hmm, but that doesn't sound right either, that's certainly no revolting
functionality and seems to be in contradiction with previous bundles
description. But if it doesn't squash the changes, I don't see how the
combined diff can be integral part of the data. Sorry, I don't get it.

> The bundle format can also support sending a single bundles that
> displays the series of patches, though there's currently no UI to select
> this.
..snip..
> > I was under an impression that user sees only mega-patch of all the
> > revisions in bundle together, and rest is for machine consumption only.
> 
> All of it is for machine consumption.  The MIME-encoded sections are a
> series of patches.  They're usually MIME-encoded to avoid confusion with
> the overview patch, but this is optional.
> 
> I've attached an example of what a combined patch-by-patch bundle looks
> like.

But that's the one there's no UI to select? Or where is the combined
diff?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
