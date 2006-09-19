From: Petr Baudis <pasky@suse.cz>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:11:11 +0200
Message-ID: <20060919221111.GF8259@pasky.or.cz>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <eeppkl$rm9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnoI-0003Kj-Sk
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWISWLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWISWLO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:11:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64385 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751191AbWISWLN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:11:13 -0400
Received: (qmail 24798 invoked by uid 2001); 20 Sep 2006 00:11:11 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eeppkl$rm9$2@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27298>

Dear diary, on Wed, Sep 20, 2006 at 12:07:08AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Joel Dice wrote:
> > Rationale:
> > 
> > Incrementing revision numbers (IRNs - an acronym I just made up) are 
> > useful in that they can be treated as auto-generated tags which are easier 
> > to remember and communicate than SHA hashes, yet do not require extra 
> > effort to create like real tags.  Also, they have the advantage of being 
> > chronologically ordered, so if I assert that a bug was fixed in revision 
> > 42 of a shared repository, everyone may assume that revision 45 has that 
> > fix as well.
> 
> That is true _only_ if you have linear history. If you have multiple
> concurrent branches, revision 42 can be in branch 'next', revision '45' in
> topic branch 'xx/topic' which forked before revision 42, and do not have
> the fix.

Oops, I've completely overlooked that bit of the rationale. Of course
IRNs cannot assure this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
