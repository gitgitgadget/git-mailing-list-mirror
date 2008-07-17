From: Petr Baudis <pasky@suse.cz>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 22:26:09 +0200
Message-ID: <20080717202609.GA32184@machine.or.cz>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org> <861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain> <86k5fk1ooq.fsf@lola.quinscape.zz> <m3k5fks2et.fsf@localhost.localdomain> <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJa4F-0002Q7-Pg
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760484AbYGQU0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760251AbYGQU0M
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:26:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56132 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760201AbYGQU0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:26:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6B404393A2DF; Thu, 17 Jul 2008 22:26:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88910>

On Thu, Jul 17, 2008 at 01:12:57PM -0700, Kevin Ballard wrote:
> There is one facet of submodules that annoys me, because it prevents me 
> from using them as a replacement for svn:externals. Namely, the submodule 
> refers to a specific repository, but not a path within that repository. I 
> work with svn repos that use svn:externals to peg revisions (as is 
> appropriate) but they all refer to various paths within the other 
> repositories, and the only way I can deal with that is to throw symlinks 
> everywhere.

Actually, is this a big problem? Git can track symlinks and without
adding support for overall partial checkouts, adding this would feel
like too huge a hack to me.

Also, when converting to a different VCS, it might be sensible to adjust
your modules setup a bit as well - the requirement to include only
particular subdirectory of a submodule sounds rather strange to me.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
