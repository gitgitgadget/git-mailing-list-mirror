From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 13:47:11 +0100
Message-ID: <200509181347.11403.alan@chandlerfamily.org.uk>
References: <alan@chandlerfamily.org.uk> <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl> <46a038f9050918035436352f71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 18 14:47:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGyZj-0000oZ-HR
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 14:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVIRMrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVIRMrM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 08:47:12 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:13727
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751115AbVIRMrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 08:47:12 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EGyZa-00033g-V0
	for git@vger.kernel.org; Sun, 18 Sep 2005 13:47:10 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <46a038f9050918035436352f71@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8781>

On Sunday 18 Sep 2005 11:54, Martin Langhoff wrote:
> On 9/18/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > The easiest way of doing this is using cogito (near where you found
> > git). It automates some tasks using git as backendq, in this case it
> > would only need:
> >
> >    cg-init
>
> +1 -- I work with a small team and we are migrating to cogito/git.
> There's still a few things we have to call git utilities for (change
> branch, for instance) but for "intuitive" usage, cogito is the cat's
> whiskers.

Yes - I had increasingly believed that with all the scripts being generated 
with git that cogito was becoming irrelevant.  However experience of the last 
day has shown me that is far from the case.

I really like cg-commit where it lists the files its going to commit for you, 
and where if you delete the line it doesn't.  If I've been doing a bit too 
many things at once it helps commit in small chunks

Seems cogito branch handling only really deals with linking to others. I have 
ended up also using git branch and git checkout -f to keep lots of little 
local branches in my repository.

Still struggling with how to cherry pick parts a previous update (between 
possibly two other branches) and apply them to a current branch - all the 
tutorials assume you want it all, and I can't really understand what the 
cherry pick commands do from their manuals.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
