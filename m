From: Theodore Tso <tytso@mit.edu>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 23:15:52 -0400
Message-ID: <20070417031552.GA18373@thunk.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org> <20070417022154.GC30340@thunk.org> <f01b9g$qqc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 05:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdeAq-0002Xt-3w
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 05:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031065AbXDQDQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 23:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031069AbXDQDQD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 23:16:03 -0400
Received: from thunk.org ([69.25.196.29]:44741 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031065AbXDQDQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 23:16:01 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdeH5-0002Zr-MB; Mon, 16 Apr 2007 23:22:36 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdeAa-0007GY-RP; Mon, 16 Apr 2007 23:15:52 -0400
Content-Disposition: inline
In-Reply-To: <f01b9g$qqc$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44714>

On Tue, Apr 17, 2007 at 04:30:47AM +0200, Jakub Narebski wrote:
> You have to use --abbrev-commit (--abbrev is opassed to log machinery, and
> covers object ids), which is undocumented option (mentioned only in passing
> in git-reflog(1)).

Sigh, I found --abbrev first from deferencing the following paragraph
from the git-log man page:

   The [git-log] command takes options applicable to the
   git-rev-list(1) command to control what is shown and how, and
   options applicable to the git-diff-tree(1) commands to control how
   the changes each commit introduces are shown.

In any case, --abrev is mentioned in git-rev-list(1)'s man page, and
specifying it doesn't cause git-log to bomb out with an illegal option
name.  It just apparently ignores it as far as I can tell.

						- Ted
