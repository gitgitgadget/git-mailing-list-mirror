From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Submodule status inside nested submodule fails
Date: Wed, 9 May 2012 23:34:44 +0200
Message-ID: <20120509213443.GA74366@book.hvoigt.net>
References: <loom.20120224T104003-230@post.gmane.org> <loom.20120224T142455-253@post.gmane.org> <1336500675427-7540130.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "rollinsdr@gmail.com" <rollinsdr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:41:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEdX-0000zf-Os
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab2EIVl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 17:41:27 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40111 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932439Ab2EIVl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:41:26 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 May 2012 17:41:26 EDT
Received: (qmail 20459 invoked from network); 9 May 2012 21:34:44 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 9 May 2012 21:34:44 -0000
Content-Disposition: inline
In-Reply-To: <1336500675427-7540130.post@n2.nabble.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197518>

Hi,

On Tue, May 08, 2012 at 11:11:15AM -0700, rollinsdr@gmail.com wrote:
> I'm having the same issue. Did it ever get resolved, or is there a hack to
> fix it, or is there some link I can track it on?
> 
> 
> Charles Brossollet wrote
> > 
> > Charles Brossollet <chbrosso <at> lltech.fr> writes:
> > Using MSysGit 1.7.9 on Win7 (64 bit), I have a repo with the following 
> > structure: 
> > 
> > main/ 
> >   src/ 
> >   ext/ 
> >     submodule/ 
> >        modules/module1 
> >        modules/module2 
> > 
> > submodule is... a submodule, having itself submodules. 
> > 
> > When I query submodule status --recursive in main/, no problem. 
> > But when I query submodule status in  ext/submodule, I get error "You need

Without having looked at the code itself this smells like an issue with
the newly introduced gitlink files and git rev-parse --show-cdup not
taking this into account.

I will have a look at this issue.

Cheers Heiko
