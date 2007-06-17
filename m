From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Sun, 17 Jun 2007 14:12:00 -0400
Message-ID: <20070617181200.GA15218@thunk.org>
References: <11820959413590-git-send-email-prohaska@zib.de> <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 20:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzzEU-0007pc-MC
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 20:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbXFQSMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbXFQSMM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 14:12:12 -0400
Received: from THUNK.ORG ([69.25.196.29]:53674 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbXFQSMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 14:12:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HzzLw-0006MB-Ps; Sun, 17 Jun 2007 14:19:57 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HzzEG-0007Qu-R8; Sun, 17 Jun 2007 14:12:00 -0400
Content-Disposition: inline
In-Reply-To: <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50362>

On Sun, Jun 17, 2007 at 06:13:11PM +0200, Steffen Prohaska wrote:
> 
> Hmm, now I found out that opendiff, which was already available
> as an option, actually launches FileMerge.

Yep.

> I wasn't aware of this fact. git-mergetool proposed to use vimdiff
> although I had preferred the graphical application FileMerge, which
> would have been launched by opendiff.

Do you know of a way of determining whether or not under MacOS X, a
program can easily determine whether or not the user is sitting in
front of the graphical display, as opposed to coming in via an SSH
connection?

If so, we could use that under MacOS to make the defaults be to use
opendiff under those circumstances.

Realistically, though, past a certain point we can only be so smart
with the hueristics.  If you know what you want, you should really set
the merge.tool config option in your ~/.gitconfig file, and be done
with it.

> Don't know if my patch makes any sense. Probably a note in the
> documentation that opendiff launches the GUI would be nice.

Maybe a change so that opendiff is listed as "opendiff (aka
FileMerge)", perhaps?

						- Ted
