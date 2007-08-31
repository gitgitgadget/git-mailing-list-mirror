From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 03:39:35 +0200
Message-ID: <20070831013935.GM1219@pasky.or.cz>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Cuppett <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 03:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQvU4-0003rL-HN
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 03:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757724AbXHaBjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 21:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757989AbXHaBjh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 21:39:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34260 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757671AbXHaBjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 21:39:36 -0400
Received: (qmail 2112 invoked by uid 2001); 31 Aug 2007 03:39:35 +0200
Content-Disposition: inline
In-Reply-To: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57102>

On Fri, Aug 31, 2007 at 03:35:36AM CEST, Stephen Cuppett wrote:
> With this one abnormality the git repo on a normal flash drive doesn't
> work... at least in my case.

Wouldn't it be better to minimalize the restriction imposed to you by
git in case you are working on a filesystem that doesn't support
symlinks? Let's say that in that case Git will keep the symlink only in
the index... (And perhaps warn.)

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
