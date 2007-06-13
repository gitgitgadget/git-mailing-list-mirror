From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 13 Jun 2007 23:44:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706132334060.4059@racer.site>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
 <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
 <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hybci-0000Xb-E4
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXFMWr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbXFMWr1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:47:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:41057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753398AbXFMWr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:47:26 -0400
Received: (qmail invoked by alias); 13 Jun 2007 22:47:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 14 Jun 2007 00:47:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BW6IFVnxBK+gL4I3Ucrx4p9N/scT8DLFeU6x1kf
	LXg8qO18rbhjy1
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50141>

Hi,

On Wed, 13 Jun 2007, Junio C Hamano wrote:

> * js/filter (Fri Jun 8 23:28:50 2007 +0200) 11 commits

Isn't that convenient? That's already the second project the two JS'es are 
working together...

> * jc/oneline (Mon Jun 11 22:10:55 2007 -0700) 2 commits
>  + Extend --pretty=oneline to cover the first paragraph,
>  + Lift 16kB limit of log message output
> 
> Hoping to be able to merge them to 'master', but haven't
> convinced myself that these changes are correct.  Help is
> appreciated.

I haven't had a chance to look at the patch yet, but the intention is 
sound.

> * ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200)
>  - filter-branch: always export GIT_DIR if it is set
> * ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
>  - make git barf when an alias changes environment variables
>  - setup_git_directory: fix segfault if repository is found in cwd
>  - test GIT_WORK_TREE
>  - extend rev-parse test for --is-inside-work-tree
>  - Use new semantics of is_bare/inside_git_dir/inside_work_tree
>  - introduce GIT_WORK_TREE to specify the work tree
>  - test git rev-parse
>  - rev-parse: introduce --is-bare-repository
>  - rev-parse: document --is-inside-git-dir
> 
> Undecided.  Some people would want to have a way to have GIT_DIR
> point at somewhere unusual and still want to work from within a
> subdirectory, which is probably a valid thing to support.  This
> is not something I would use myself, so I am mostly worried
> about the impact these changes may have on people who do not use
> this feature.

Yeah, it is something to worry about. As far as I am concerned, these 
changes are too deep for too obscure a feature.

But then, I see that people need it.

And I can't think of a better way to implement it. So unless somebody 
comes up with a nice solution, I think we should live with it, rather than 
let it simmer in pu.

Ciao,
Dscho
