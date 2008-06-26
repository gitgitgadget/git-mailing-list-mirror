From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH] daemon: accept "git program" as well
Date: Thu, 26 Jun 2008 11:20:13 +0300
Message-ID: <20080626082013.GT22344@eagain.net>
References: <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> <20080625230228.GR11793@spearce.org> <7vmyl9w0y1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBmqi-0004Ga-G4
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYFZI2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYFZI2B
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:28:01 -0400
Received: from eagain.net ([208.78.102.120]:48065 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbYFZI2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:28:00 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 04:28:00 EDT
Received: from musti.eagain.net (a91-155-203-19.elisa-laajakaista.fi [91.155.203.19])
	by eagain.net (Postfix) with ESMTPS id 053351EC03E;
	Thu, 26 Jun 2008 08:19:27 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 0FB9550838F; Thu, 26 Jun 2008 11:20:13 +0300 (EEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmyl9w0y1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86414>

On Wed, Jun 25, 2008 at 04:26:46PM -0700, Junio C Hamano wrote:
> By the way I looked at gitosis (Tommi CC'ed).
> 
>     http://repo.or.cz/w/gitosis.git?a=blob;f=gitosis/serve.py;h=c0b7135bf45305ee1079b0dcab3b4ed1ce988aab;hb=38561aa6a51a2ef6cc04aa119481df62d213ffa4
> 
> In gitosis/serve.py, there are COMMANDS_READONLY and COMMANDS_WRITE array
> that holds 'git-upload-pack' and 'git-receive-pack' commands, and they are
> compared with user commands after doing:

Yeah, that's pretty much a trivial change, doing it now to future-proof
gitosis.

-- 
:(){ :|:&};:
