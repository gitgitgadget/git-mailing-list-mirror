From: Petr Baudis <pasky@suse.cz>
Subject: Re: How-to setup an empty remote repository?
Date: Sun, 26 Aug 2007 00:06:29 +0200
Message-ID: <20070825220629.GC1219@pasky.or.cz>
References: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP3m6-0006VP-SM
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbXHYWGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbXHYWGb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:06:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50218 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbXHYWGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:06:31 -0400
Received: (qmail 31285 invoked by uid 2001); 26 Aug 2007 00:06:29 +0200
Content-Disposition: inline
In-Reply-To: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56652>

On Sat, Aug 25, 2007 at 11:00:33PM CEST, Wink Saville wrote:
> In the instructions I followed for setting up a remote repository,
> http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html,
> it uses an existing repository. So is it true you can't clone an
> empty remote repository, or did I do something wrong?

It is true that you can't clone it. "Cloning remote repository" means
just "get all the remote branches and set them up locally". In empty
repository there are no branches yet, so there's nothing to clone.

I guess this should be covered in the FAQ (if it isn't already), it is
one of the top questions repo.or.cz users have and I think I see it
frequently on IRC as well.

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
