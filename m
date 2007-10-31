From: Petr Baudis <pasky@suse.cz>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 18:13:08 +0100
Message-ID: <20071031171308.GS18279@machine.or.cz>
References: <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pascal Obry <pascal@obry.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 18:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InH8h-0008Pu-SN
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 18:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbXJaRNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 13:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756917AbXJaRNM
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 13:13:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38731 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881AbXJaRNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 13:13:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E98A15A30E; Wed, 31 Oct 2007 18:13:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071030235823.GA22747@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62851>

On Tue, Oct 30, 2007 at 07:58:23PM -0400, Jeff King wrote:
>   http://host/git repo with spaces in the path
> 
> compared to:
> 
>   http://host/git+repo+with+spaces+in+the+path

Just pedantic side-note: these two URLs are not equivalent. '+' is valid
substitute for a space only in query string part of URL. In path you
have to use %20.

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
