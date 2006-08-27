From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Starting to think about sha-256?
Date: Sun, 27 Aug 2006 23:14:34 +0200
Message-ID: <m3hczxdgp1.fsf@defiant.localdomain>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 23:14:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHRxw-00088X-Ot
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWH0VOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWH0VOh
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:14:37 -0400
Received: from khc.piap.pl ([195.187.100.11]:2001 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932257AbWH0VOh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 17:14:37 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 6FBF110811; Sun, 27 Aug 2006 23:14:35 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org> (Linus Torvalds's message of "Sun, 27 Aug 2006 13:46:57 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26113>

Linus Torvalds <torvalds@osdl.org> writes:

> Modifying git-convert-objects.c to rewrite the regular sha1 into a sha256 
> should be fairly straightforward. It's never been used since the early 
> days (and has limits like a maximum of a million objects etc that can need 
> fixing), but it shouldn't be "fundamentally hard" per se.

Sure. I was rather thinking of rapidly increasing number of git
repositories, each with growing history.
-- 
Krzysztof Halasa
