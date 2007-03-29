From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: Replace use of "echo -n" with printf(3) to be more portable
Date: Thu, 29 Mar 2007 18:15:44 -0400
Message-ID: <20070329221544.GB30858@thunk.org>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <20070329155741.GA18413@moooo.ath.cx> <20070329170914.GA9435@thunk.org> <7vwt0z1zel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXFlT-0006BM-5H
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 13:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933620AbXC3L7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 07:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933638AbXC3L7X
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 07:59:23 -0400
Received: from thunk.org ([69.25.196.29]:34771 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933620AbXC3L7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 07:59:22 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXFrJ-0001t1-Hu; Fri, 30 Mar 2007 08:05:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HX2uG-0002Wj-UH; Thu, 29 Mar 2007 18:15:44 -0400
Content-Disposition: inline
In-Reply-To: <7vwt0z1zel.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2007 at 03:02:42PM -0700, Junio C Hamano wrote:
> Really?  I push with '+' (aka "single force") all the time to
> alt-git.git repository and haven't noticed that:

Oh, cool, it never occurred to me that it would work with push on a
remote repository (but that makes perfect sense in retrospect :-).

						- Ted
