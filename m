From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix --signoff in builtin-commit differently.
Date: Sun, 2 Dec 2007 22:31:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712022230480.27959@racer.site>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
 <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net>
 <7vmyssvn55.fsf@gitster.siamese.dyndns.org> <7v63zgvkl5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxMv-0004sD-6o
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXLBWcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXLBWcf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:32:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbXLBWce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:32:34 -0500
Received: (qmail invoked by alias); 02 Dec 2007 22:32:32 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 02 Dec 2007 23:32:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19scvlsX9xs1rCw6Xyvy9+Hr0DJ4J2Foepw6gIli/
	5ZnvhRVz/bxcZJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7v63zgvkl5.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66827>

Hi,

On Sun, 2 Dec 2007, Junio C Hamano wrote:

> Introduce fmt_name() specifically meant for formatting the name and
> email pair, to add signed-off-by value.  This reverts parts of
> 13208572fbe8838fd8835548d7502202d1f7b21d (builtin-commit: fix --signoff)
> so that an empty datestamp string given to fmt_ident() by mistake will
> error out as before.

>From a quick glance, looks good to me.

Sorry for the breakage,
Dscho
