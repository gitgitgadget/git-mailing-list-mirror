From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: Clean up description of files and prompts for merge resolutions
Date: Thu, 29 Mar 2007 22:54:11 -0400
Message-ID: <20070330025411.GD3198@thunk.org>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830652230-git-send-email-tytso@mit.edu> <20070329222905.GA25347@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXFlH-00069l-FH
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 13:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933566AbXC3L7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 07:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933618AbXC3L7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 07:59:16 -0400
Received: from thunk.org ([69.25.196.29]:34756 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933566AbXC3L7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 07:59:15 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXFrE-0001t1-Ui; Fri, 30 Mar 2007 08:05:29 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HX7Fj-0007wK-5k; Thu, 29 Mar 2007 22:54:11 -0400
Content-Disposition: inline
In-Reply-To: <20070329222905.GA25347@moooo.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2007 at 12:29:05AM +0200, Matthias Lederhofer wrote:
> Theodore Ts'o <tytso@mit.edu> wrote:
> > +    printf "  {$branch}: "
> This should use %s too.

It's strictly not necessary since $branch is either "local" or "remote".

						- Ted
