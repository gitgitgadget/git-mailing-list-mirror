From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Squelch bogus progress output from
 git-rebase--interactive
Date: Tue, 15 Jan 2008 11:22:59 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801151122450.5289@eeepc-johanness>
References: <7v3aszivjk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 12:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEjtF-0006n4-Lw
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYAOLXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYAOLXE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:23:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:37604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbYAOLXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:23:03 -0500
Received: (qmail invoked by alias); 15 Jan 2008 11:22:59 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp007) with SMTP; 15 Jan 2008 12:22:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C69I7zkaC/82sCL9Mn4KBzfwipgPtcrHQNpvMrp
	TRjKKxJs0/ilZL
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v3aszivjk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70515>

Hi,

On Mon, 14 Jan 2008, Junio C Hamano wrote:

> The command repeats "Rebasing (1/1)" many times even when
> there is only one task remaining, because mark_action_done() is
> called to skip comment and empty lines in the TODO file.
> 
> This should fix it.

Yes, it should.

Thanks,
Dscho
