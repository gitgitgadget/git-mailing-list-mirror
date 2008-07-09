From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rerere: Separate libgit and builtin functions
Date: Wed, 9 Jul 2008 14:00:30 +0200
Message-ID: <20080709120030.GA10528@leksak.fem-net>
References: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness> <1215598683-9685-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807091355220.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYMV-0005Vn-EY
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYGIMAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYGIMAd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:00:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:44326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbYGIMAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:00:33 -0400
Received: (qmail invoked by alias); 09 Jul 2008 12:00:31 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp045) with SMTP; 09 Jul 2008 14:00:31 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+HcyxXCveHQx5kaNWI6a/rN8x2McgBiRj4FyzHmB
	PGx/gwkl+w778V
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGYLW-0004mo-3D; Wed, 09 Jul 2008 14:00:30 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807091355220.5277@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87872>

> > This patch moves rerere()-related functions into a newly created 
> > rerere.c file.  Also setup_rerere() is moved into rerere.c to decrease 
> > code duplications for rerere.c and builtin-rerere.c.
> 
> It is not moved to decrease code duplication, but because it is needed by 
> rerere().

Right.

And btw the patch seems to be broken. (At least I can't apply it
here...)   Sorry :( Usually I test applying before sending but this time
lunch was eliciting.

Well, I'm going to fix that.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
