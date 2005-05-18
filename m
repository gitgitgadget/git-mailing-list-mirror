From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Thu, 19 May 2005 00:30:34 +0200
Message-ID: <20050518223034.GH10358@pasky.ji.cz>
References: <tnx64xm5b2b.fsf@arm.com> <20050514110941.GB3905@pasky.ji.cz> <tnx3bsoki2j.fsf@arm.com> <pan.2005.05.15.17.36.37.623874@smurf.noris.de> <tnxis1jk1sn.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:33:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYX4W-0001ii-Cl
	for gcvg-git@gmane.org; Thu, 19 May 2005 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVERWbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVERWbQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 18:31:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39053 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262379AbVERWai (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 18:30:38 -0400
Received: (qmail 15115 invoked by uid 2001); 18 May 2005 22:30:34 -0000
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Disposition: inline
In-Reply-To: <tnxis1jk1sn.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 16, 2005 at 10:33:44AM CEST, I got a letter
where Catalin Marinas <catalin.marinas@arm.com> told me that...
> Matthias Urlichs <smurf@smurf.noris.de> wrote:
> >> +	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [BNAME] [BNAME]] [FILE]...
> >
> > That should be
> >
> > [-m [BNAME [BNAME]]]
> 
> You are right.
> 
> > though I'd suggest something more mnemonic than two BNAMEs.
> 
> Another try, see attached.

Unfortunately I can't comment on it well when it's not either in the
body or as text/plain attachment.

I think the -m usage doesn't make much sense now. What about dropping
branch1 and instead using what the user passed as the -r argument?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
