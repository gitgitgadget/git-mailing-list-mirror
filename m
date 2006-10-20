From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 15:36:30 +0200
Message-ID: <20061020133630.GH20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201151.13199.jnareb@gmail.com> <a7e835d40610200342ibc56fd9t542a60230ebe0020@mail.gmail.com> <200610201517.26702.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 15:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauY8-0004hl-U8
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 15:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946420AbWJTNgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946415AbWJTNgd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 09:36:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52359 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1946420AbWJTNgd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 09:36:33 -0400
Received: (qmail 25887 invoked by uid 2001); 20 Oct 2006 15:36:30 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610201517.26702.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29466>

Dear diary, on Fri, Oct 20, 2006 at 03:17:26PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> But you can also clone _whole_ repository, _all_ published branches with
> 
>    $ cg clone git://git.kernel.org/pub/scm/git/git.git

Nope, cg clone will in this case clone the master branch (or whatever
the remote HEAD points at). cg clone -a is planned but not implemented
yet. Very soon now, hopefully. :-)

> In GIT to work on some repository you don't (like from what I understand
> in Bazaar-NG) "checkout" some branch (which would automatically copy some
> data in case of "heavy checkout" or just save some pointer to repository
> in "lightweight checkout" case). You clone whole repository; well you can
> select which branches to clone. "Checkout" in GIT terminology means to
> populate working area with given version (and change in repository which
> branch is current, usually).

You don't need to, you can switch your working tree between various
branches.  I think Linus said he does that (or was it Junio?), and I do that
as well, as well as many others.

A good question would be "when to create another branch and when to
clone the repository". And I don't think there's any good answer, except
"when you are comfortable with it". :-) Both approaches have pros/cons.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
