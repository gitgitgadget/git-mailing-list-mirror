From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 21:24:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112122300.3870@racer.site>
References: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOg8t-00032E-EP
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbYBKVYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbYBKVYK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:24:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:36742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751716AbYBKVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:24:09 -0500
Received: (qmail invoked by alias); 11 Feb 2008 21:24:07 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 11 Feb 2008 22:24:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aUt1dgiZa5qUKwIV0orZqT/+EI5ZCwFnWeN6m0H
	XF2uunis9Osc4Q
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73588>

Hi,

On Mon, 11 Feb 2008, Linus Torvalds wrote:

>  #define DIFF_FORMAT_SHORTSTAT	0x0020
> +#define DIFF_FORMAT_DIRSTAT	0x0020

Certainly you meant 0x0040 for DIRSTAT, n'est-ce pas?

Also, are you sure that you do not want to make the minimal percentage 
configurable, maybe with --dirstat[=<min-percent>]?  I mean, sometimes 
even 0.01% is worth showing.

Ciao,
Dscho
