From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use commit template when cherry picking
Date: Fri, 11 Jan 2008 21:24:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112123410.31053@racer.site>
References: <20080111074505.GC14022@plexity.net> <alpine.LSU.1.00.0801111208020.31053@racer.site> <7v7iig2npe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Deepak Saxena <dsaxena@plexity.net>, git@vger.kernel.org,
	Perry Wagle <pwagle@mvista.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRN9-0006Yq-2B
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbYAKVYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYAKVYa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:24:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:36144 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbYAKVY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:24:29 -0500
Received: (qmail invoked by alias); 11 Jan 2008 21:24:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 11 Jan 2008 22:24:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hr6FSJpRhK3dgl4KFaT3+FHXbT6Q3QkmL9TxSEP
	3+RV+Em87g9Ltq
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7iig2npe.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70206>

Hi,

On Fri, 11 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I would do a combination of "cherry-pick -n", "cat-file commit 
> > <commit> | sed '1,/^$/d'" and "commit -F" or "commit -f".
> 
> Doesn't cherry-pick have -e switch to allow you further edit the
> message?

Good point.  But nevertheless, Deepak wanted to have a template which is 
automatically added, and I think the only way to do that right now is as I 
described.

Ciao,
Dscho
