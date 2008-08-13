From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
	merge_recursive_generic()
Date: Wed, 13 Aug 2008 22:05:27 +0200
Message-ID: <20080813200526.GA10758@leksak.fem-net>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <alpine.LNX.1.00.0808122309460.19665@iabervon.org> <20080813172938.GC12871@leksak.fem-net> <alpine.LNX.1.00.0808131333230.19665@iabervon.org> <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMc8-0005P5-Pr
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbYHMUFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYHMUFc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:05:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:54848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752337AbYHMUFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:05:31 -0400
Received: (qmail invoked by alias); 13 Aug 2008 20:05:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp053) with SMTP; 13 Aug 2008 22:05:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1++Dbc0cbe+bQQMkMOgCnDsTj2muecycqm9vMa3B1
	ib1YPuhYqTxKeb
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTMb1-0002nn-0r; Wed, 13 Aug 2008 22:05:27 +0200
Content-Disposition: inline
In-Reply-To: <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92258>

Hi,

Junio C Hamano wrote:
> The scripted version of revert/cherry-pick used git-merge-recursive
> because that is the Porcelain API available, and the current C-rewrite
> uses it as well, but if we are rewriting it to call merge-recursive
> machinery directly, it should be making a single merge request to
> merge_trees(), not "recursive" one.

This is an interesting point.
So perhaps we don't need stuff like my regarding merge_recursive_generic(),
at least not for revert/cherry-pick.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
