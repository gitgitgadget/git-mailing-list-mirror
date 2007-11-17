From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: prevent dcommitting if the index is dirty.
Date: Sat, 17 Nov 2007 12:52:48 -0800
Message-ID: <20071117205248.GA31598@mayonaise>
References: <1194806501-4796-1-git-send-email-tsuna@lrde.epita.fr> <20071112022851.GA25675@mayonaise> <F711CC72-4A91-4B69-B26A-31B0FB6621B0@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Nov 17 21:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItUf5-0003Kc-FK
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 21:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXKQUwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 15:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXKQUwu
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 15:52:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33653 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbXKQUwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 15:52:49 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2D3D07DC0FE;
	Sat, 17 Nov 2007 12:52:48 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 12:52:48 -0800
Content-Disposition: inline
In-Reply-To: <F711CC72-4A91-4B69-B26A-31B0FB6621B0@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65305>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> On Nov 12, 2007, at 3:28 AM, Eric Wong wrote:
> >We use tabs for indentation, and spaces for alignment.
> 
> Yes, sorry again, would you consider to add `# vi: set noexpandtab:'  
> at the end of the file so that ViM users (like me) don't have to  
> think about it?  (it tells ViM to NOT expand tabs to series of spaces)

No, there are still too many cases where the modelines won't apply:
non-VIM users, VIM-users with modelines disabled.

Instead, you can try this in your .vimrc:

augroup filetype
	au BufRead git-svn.perl		set noexpandtab
augroup END

-- 
Eric Wong
