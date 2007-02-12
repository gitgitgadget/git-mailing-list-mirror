From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 22:56:24 -0500
Message-ID: <20070212035613.GA18010@thunk.org>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu> <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu> <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070211001346.GA19656@thunk.org> <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070211162136.GA26461@thunk.org> <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUqQ-0003Wh-9f
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbXBLGjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbXBLGjL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:39:11 -0500
Received: from thunk.org ([69.25.196.29]:35541 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933032AbXBLGjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:39:10 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGUvK-0000hf-6S; Mon, 12 Feb 2007 01:44:26 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGSIi-00023J-2N; Sun, 11 Feb 2007 22:56:25 -0500
Content-Disposition: inline
In-Reply-To: <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39378>

On Sun, Feb 11, 2007 at 01:44:25PM -0800, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > ..., I think we're
> > still safe, since aliases can't override commands.  
> 
> I feel a bit uneasy to hear safety argument based on that
> current restriction, since we might want to loosen it later.

Loosen which restriction?

1) The ability for aliases to shadow existing git commands?
2) The ability for untrusted users to make arbitrary changes to the 
      config file?
3) The ability for untrusted users to execute arbitrary git commands via 
      git-shell?

You hjave to loosen at least 2 of the 3 current restrictions before
the ability to execute shell commands out of aliases becomes a problem
--- and I would argue that either (2) or (3) are things that we would
be insane to loosen at least to the point of allowing untrusted users
to make arbitrary changes to the config or execute arbitrary git
commands, since even today, they could do a huge amount of damage
already.

						- Ted
