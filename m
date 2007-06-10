From: Theodore Tso <tytso@mit.edu>
Subject: Re: Please pull mergetool.git
Date: Sun, 10 Jun 2007 17:31:17 -0400
Message-ID: <20070610213117.GA15117@thunk.org>
References: <E1HxPt7-0007jV-6V@candygram.thunk.org> <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxV0X-0005TY-1Y
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXFJVb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbXFJVb0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:31:26 -0400
Received: from thunk.org ([69.25.196.29]:44560 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXFJVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:31:25 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HxV7o-0004FK-7z; Sun, 10 Jun 2007 17:39:04 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HxV0H-00053o-QP; Sun, 10 Jun 2007 17:31:17 -0400
Content-Disposition: inline
In-Reply-To: <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49769>

On Sun, Jun 10, 2007 at 12:55:13PM -0700, Junio C Hamano wrote:
> But I hope you would not be offended if I said I do not want to.
> 
> This is not such a strong objection, but I really wish that you
> did not mix in the .gitignore change; it does not belong to this
> "series".

OK, no problem.  It was something I noticed while I was preparing the
series, and I thought it was non-controverisal enough to just throw it
in.  It's at the tail of the series, so it's easy enough for me to do a 

	git reset --hard HEAD^

on the mergetool branch....   OK, done.  If you pull from 

        git://repo.or.cz/git/mergetool.git mergetool

You'll only get the first two changes to git-mergetool, and the
.gitignore change has been dropped.

Regards,

					- Ted
