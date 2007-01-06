From: Theodore Tso <tytso@mit.edu>
Subject: Re: New way of tracking remote branches -- question
Date: Sat, 6 Jan 2007 09:10:32 -0500
Message-ID: <20070106141032.GB28972@thunk.org>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com> <7vejq9c9tf.fsf@assigned-by-dhcp.cox.net> <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 15:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3CHu-0005vB-1n
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 15:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXAFOMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 09:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAFOMl
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 09:12:41 -0500
Received: from THUNK.ORG ([69.25.196.29]:58701 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbXAFOMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 09:12:40 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H3CMB-0006i2-60; Sat, 06 Jan 2007 09:17:11 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H3CFk-0007Mn-47; Sat, 06 Jan 2007 09:10:32 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36090>

On Fri, Jan 05, 2007 at 05:11:04PM -0800, Junio C Hamano wrote:
>  * Your heads/ namespace is of your own.  The repository clone
>    sets up arranges the master branch to start from the same
>    commit as where you cloned from, and sets up so that changes
>    made on the master at the remote is merged into your master,
>    but that is merely a convention that was deemed as the most
>    common and the most convenient.

The other nice thing about the new scheme is that if new branches
appear in the remote repository, they automatically show up in
remote/origin/*.  Before, if new branches showed up after the initial
clone, you'd never know about it and it wouldn't be possible to
automatically create new branches in heads/ since it might conflict
with an originally existing branch in the local namespace.  So IMHO,
the separation of namespace is definitely a good thing.

						- Ted
