From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Switching between branches
Date: Thu, 21 Apr 2005 18:39:58 +0200
Message-ID: <20050421163958.GI30991@pasky.ji.cz>
References: <1114047759.20044.22.camel@dv> <20050421073123.GD31910@pasky.ji.cz> <pan.2005.04.21.14.12.46.905838@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 18:36:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeeU-0006iw-AN
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVDUQkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDUQkD
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:40:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18563 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261518AbVDUQj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:39:59 -0400
Received: (qmail 2130 invoked by uid 2001); 21 Apr 2005 16:39:58 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.04.21.14.12.46.905838@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 04:12:49PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> Hi, Petr Baudis wrote:
> 
> > Hello,
> > 
> >> Perhaps it's a naive question, but how do I switch between branches?  I
> >> mean an equivalent of "svn switch" or "cvs update -r branch" that would
> >> reuse the existing working directory.
> > 
> > you can't. There was 'git update' (and intermediate never-committed 'git
> > switch'), but I decided not to support it for now, since I don't have any
> > compelling usage case for it.
> 
> I do -- I have a project which builds several slightly-customized versions,
> and I'd like to keep the generated objects around if possible.
> 
> So I just build one version, then "git cancel FOO" to the next version,
> and let the make rules take care of rebuilding what needs to be rebuilt.

I suppose we could do with git switch then.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
