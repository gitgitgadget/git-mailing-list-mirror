From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Sun, 11 Mar 2007 22:57:36 -0400
Message-ID: <20070312025736.GA28505@thunk.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 05:53:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQcWt-0005Ct-1m
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 05:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbXCLEw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 00:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbXCLEw4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 00:52:56 -0400
Received: from THUNK.ORG ([69.25.196.29]:59979 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965060AbXCLEw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 00:52:56 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HQccP-000352-31; Mon, 12 Mar 2007 00:58:45 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HQajA-0007ul-SW; Sun, 11 Mar 2007 22:57:36 -0400
Content-Disposition: inline
In-Reply-To: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42008>

On Sun, Mar 11, 2007 at 06:06:56PM -0400, James Bowes wrote:
> The following two patches make git-gc a builtin command.

What's the advantage in making git-gc a builtin command?  It's not
like it's going to help performance a whole lot (especially since
you're just forking separate processes to run git-prune,
git-pack-refs, et.al.), and as a shell script it's a lot easier to
explain to people what git-gc is actually doing, so there is
pedagogical value to keeping it as a shell script.

Regards,

						- Ted
