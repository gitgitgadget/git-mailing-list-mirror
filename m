From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v2 1/5] checkout: don't crash on file checkout before
	running post-checkout hook
Date: Sun, 18 Jan 2009 03:05:31 +0100
Message-ID: <20090118020531.GC11992@leksak.fem-net>
References: <20090116172521.GD28177@leksak.fem-net> <1232133002-21725-1-git-send-email-s-beyer@gmx.net> <7vd4el2x7g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 03:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LON4X-00005P-9i
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 03:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbZARCFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 21:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757380AbZARCFl
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 21:05:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:53396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757265AbZARCFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 21:05:40 -0500
Received: (qmail invoked by alias); 18 Jan 2009 02:05:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 18 Jan 2009 03:05:38 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19It5Y1eZZIQxDeDzop68/c4ZoNdTH08cAAmvCsWv
	xUicDuwc5klsaU
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LON2Z-0007Ie-Hm; Sun, 18 Jan 2009 03:05:31 +0100
Content-Disposition: inline
In-Reply-To: <7vd4el2x7g.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106132>

Hi,

Junio C Hamano wrote:
> All looked good to me except one thing; you need to initialize argv to
> NULL as ALLOC_GROW() calls xrealloc on it in the last one.

This is true. Sorry.

> Will queue with an amend.

Thank you.

  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
