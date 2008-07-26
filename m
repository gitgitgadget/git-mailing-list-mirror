From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] init: handle empty "template" parameter, was Re: fetch
 refspec foo/* matches foo*
Date: Sat, 26 Jul 2008 15:13:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261511490.26810@eeepc-johanness>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net>
 <20080726083356.GB10104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 15:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMjaP-0007pk-7M
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 15:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYGZNMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 09:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYGZNMZ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 09:12:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:37865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbYGZNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 09:12:24 -0400
Received: (qmail invoked by alias); 26 Jul 2008 13:12:22 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp011) with SMTP; 26 Jul 2008 15:12:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/6VtpjVq/EW5Ar3TU6DUG+7THAvyMWmb1pbgFpm
	5PP4E7odGcYB9g
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080726083356.GB10104@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90222>

Hi,

On Sat, 26 Jul 2008, Jeff King wrote:

> Also, while I have your attention, Junio, here is another bug fix
> that should go into 1.6.0. I posted the patch as a "how about this" deep
> in a thread and got no response (which means no complaints, right?).

Again it is in a thread...

> This patch just checks for that condition in copy_templates
> and aborts. As a side effect, this means that --template=
> now has the meaning "don't copy any templates."

I deem this patch obviously correct, and your reasoning as to what an 
empty parameter should mean makes sense.

Ciao,
Dscho
