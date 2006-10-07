From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 7 Oct 2006 23:15:31 +0200
Message-ID: <20061007211531.GH20017@pasky.or.cz>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> <eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz> <eg9378$rln$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 23:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJWC-0005Ra-7J
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWJGVPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbWJGVPd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:15:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65454 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932866AbWJGVPd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 17:15:33 -0400
Received: (qmail 4125 invoked by uid 2001); 7 Oct 2006 23:15:31 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg9378$rln$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28508>

Dear diary, on Sat, Oct 07, 2006 at 10:38:51PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > So, I'd like to either have the view links or the filenames in classical
> > link style so that it's apparent they are clickable; I didn't post a
> > patch since I didn't have time/energy to fight for it yet. ;-)
> 
> There is a tradeout. Either have easily distinguishable directories and
> files, by using both different color and decoration (underline), or we have
> filename/directory name clearly marked as link. One or the other.
> 
> That is why I'd rather have this "redundant" blob/tree link (perhaps in
> separate column).

As I suggested in another mail, perhaps the whole problem is wrong and
you shouldn't have to dug for trees in a bunch of blobs in the first
place - let's group all the trees at the top, as all the well-behaved
directory listings do.

> But this is a matter of policy, unless we want to add theme support to
> gitweb ;-))

We _do_ have that - you can supply your own gitweb.css. But the defaults
should be sensible.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
