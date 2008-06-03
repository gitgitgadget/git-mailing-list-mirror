From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 09:31:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806030929540.13507@racer.site.net>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7v3anv5fy3.fsf@gitster.siamese.dyndns.org> <7vskvv3xmx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806030627440.13507@racer.site.net>
 <7vod6j3whp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 10:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Rxm-0003Ub-Vk
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 10:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYFCIc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 04:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYFCIc5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 04:32:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:58142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbYFCIc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 04:32:56 -0400
Received: (qmail invoked by alias); 03 Jun 2008 08:32:55 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp053) with SMTP; 03 Jun 2008 10:32:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r/xtnQsJrw+Imkrrwjns5R5cg/3FxfwTbvGT1MF
	0QXTqk08okLbk/
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vod6j3whp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83627>

Hi,

On Mon, 2 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Would it not be better (simpler, cleaner) to just use an object flag?
> 
> No.  Can you tell which flag is safe to use in this context without 
> digging around too much?

Was this not in builtin-commit.c?  AFAIR we said that the revision 
machinery must not use flags higher than 1<<12 or so, which would be left 
for users.

But I see that you already have the patch in 'master', so I guess you will 
not change it.

Ciao,
Dscho
