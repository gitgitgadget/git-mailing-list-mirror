From: Martin Mares <mj@ucw.cz>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 22:05:57 +0200
Message-ID: <mj+md-20070827.195605.14967.albireo@ucw.cz>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org> <20070827004153.GN1219@pasky.or.cz> <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPlAo-0005wb-VX
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762967AbXH0U0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762956AbXH0U0S
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:26:18 -0400
Received: from jabberwock.ucw.cz ([89.250.246.4]:39938 "EHLO jabberwock.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761186AbXH0U0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:26:16 -0400
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2007 16:26:16 EDT
Received: from albireo.ucw.cz (albireo.ucw.cz [88.208.93.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTP id E094C343F2
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 22:05:40 +0200 (CEST)
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id C2091324060; Mon, 27 Aug 2007 22:05:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56878>

Hello, world!\n

> "ssh://" is the *protocol*. What is actually done over the protocol is 
> specified by the program.
> 
> This is not at all git specific.

Really?

What does `ssh://what.the.hell.org/some/file' per se mean?

SSH is a protocol, but rather in the sense similar to TLS, not to HTTP.
If it has some addressable objects, which could be referred to by the
path part of the URL, they should be the programs to execute at the
remote server, i.e., in our case the path to the GIT client binary,
and certainly not the name of the repository, which has nothing to do
with the SSH protocol.

(Just for completeness: I do not advocate using git+ssh, but your arguments
against it look somewhat illogical.)

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Only dead fish swim with the stream.
