From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 6 Mar 2008 18:01:26 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061800110.3941@racer.site>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org> <7vpruljunl.fsf@gitster.siamese.dyndns.org> <7v1w6xoqnm.fsf@gitster.siamese.dyndns.org> <7vy792yzd6.fsf@gitster.siamese.dyndns.org> <7vmypglfwm.fsf@gitster.siamese.dyndns.org>
 <7vk5kgieqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJTo-0008Bb-Tf
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 18:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764332AbYCFRB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 12:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764182AbYCFRBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 12:01:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:35717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760109AbYCFRBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 12:01:24 -0500
Received: (qmail invoked by alias); 06 Mar 2008 17:01:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 06 Mar 2008 18:01:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AqpB/3uCADjt9+C4lhlxclMdRDUTRqaOk688PKo
	vxuepqmGxYvh4N
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5kgieqy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76402>

Hi,

On Wed, 5 Mar 2008, Junio C Hamano wrote:

> [On Hold]
> 
> * nd/worktree (Sun Mar 2 17:35:43 2008 +0700) 10 commits
>  - Additional tests to capture worktree special cases
>  - Documentation: update api-builtin and api-setup
>  - Make setup_git_directory() auto-setup worktree if found
>  - builtin-archive: mark unused prefix "unused_prefix"
>  - Completely move out worktree setup from
>    setup_git_directory_gently()
>  - http-push: Avoid calling setup_git_directory() twice
>  - Make setup_work_tree() return new prefix
>  - Make get_git_dir() and 'git rev-parse --git-dir' absolute path
>  - Make sure setup_git_directory is called before accessing
>    repository
>  - "git read-tree -m" and the like require worktree
> 
> Every time we touch work-tree stuff we seem to unstabilize; this round 
> seems more solid but I am still treading cautiously.  Not sure if we 
> want this for 1.5.5.

I think this needs a much closer look.  Being as large as the patch series 
is right now does not help at all.  And I am awfully short on time, 
_especially_ since I get sidetracked by things that are more fun, such as 
strbuf_vaddf().

Ciao,
Dscho
