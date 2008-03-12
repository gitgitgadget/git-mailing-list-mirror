From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 12 Mar 2008 13:18:50 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803121316360.1656@racer.site>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 13:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZPvY-0002Ar-Sy
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 13:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbYCLMSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 08:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYCLMSq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 08:18:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:41339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbYCLMSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 08:18:45 -0400
Received: (qmail invoked by alias); 12 Mar 2008 12:18:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 12 Mar 2008 13:18:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18edpwInsYeHi28pgGTbaJfzN4QOcxUnxXbnY3vbC
	JAiWJchOPAHrFE
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76946>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

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

I am sure we do not want this for 1.5.5.

It is too complicated a patch series to be obviously correct, and as I 
said earlier, a few design goals are not to my liking, such as trying to 
separate git_dir from work_tree logic with a sledgehammer.

Ciao,
Dscho
