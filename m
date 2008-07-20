From: Petr Baudis <pasky@suse.cz>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
	add new Git::Repo API)
Date: Sun, 20 Jul 2008 12:49:35 +0200
Message-ID: <20080720104935.GB10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com> <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 12:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKWVm-0001uL-EU
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbYGTKti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbYGTKti
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:49:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56888 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbYGTKti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:49:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 84B1E393B31D; Sun, 20 Jul 2008 12:49:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89181>

  Hi,

On Sun, Jul 20, 2008 at 12:38:07PM +0200, Johannes Schindelin wrote:
> You call that "worse"?  Pasky tried to convert all Perl scripts at once 
> IIRC, and my numerous problems just _making_ the Git scripts led me to 
> rewrite a few Perl scripts in C, so I could safely exclude the Perl 
> scripts from my personal fork.

  I don't remember any concrete report of such problems ever reaching
me; exactly what trouble are you hitting with the Perl scripts using
Git.pm?  I will be glad to try to fix it.

> I guess that it was this experience which prevented more of the old 
> scripts from being converted.
> 
> But your mention of git-add--interactive actually brings up my pet-peeve: 
> this script is the only Perl script needed for common operations, i.e. the 
> only reason msysGit has to ship bloated with Perl.

  _Many_ people seem to be using git-svn, whether we like it or not. ;-)
Also, isn't git-send-mail rather commonly used? (I wouldn't know, me
using stg mail.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
