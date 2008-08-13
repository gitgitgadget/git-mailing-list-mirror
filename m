From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
	merge_recursive_generic()
Date: Wed, 13 Aug 2008 19:29:38 +0200
Message-ID: <20080813172938.GC12871@leksak.fem-net>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <alpine.LNX.1.00.0808122309460.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:30:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKBM-0004Yo-N8
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbYHMR3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbYHMR3o
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:29:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:35766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753742AbYHMR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:29:43 -0400
Received: (qmail invoked by alias); 13 Aug 2008 17:29:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 13 Aug 2008 19:29:41 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/iSdZDaDni/TcVEeENc8LZEfpbFaeH6OEE8n4Oxn
	23aFgPS1DLfE0Q
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTKAE-0003bO-Op; Wed, 13 Aug 2008 19:29:38 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0808122309460.19665@iabervon.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92248>

Hi,

Daniel Barkalow wrote:
> You might look at builtin-checkout and see if merge_working_tree() could 
> be made cleaner with this API, or if some other API could accomodate both 
> cases more nicely.

Puhh, I've not dug into merging stuff that deep, but for me it does not
look that this can be done in a useful way, i.e. merge_working_tree()
does not do a recursive merge.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
