From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Write diff output to a file in struct diff_options
Date: Mon, 10 Mar 2008 12:06:06 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101204250.3975@racer.site>
References: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfq9-0002Ol-18
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYCJLGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYCJLGF
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:06:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:58746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751206AbYCJLGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:06:03 -0400
Received: (qmail invoked by alias); 10 Mar 2008 11:06:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp005) with SMTP; 10 Mar 2008 12:06:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cf80sjCMcNy1q8MruGOEv7GjTsyEerUv0n12LIZ
	k1Mvy3UpLMpLKi
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76716>

Hi,

On Sun, 9 Mar 2008, Daniel Barkalow wrote:

> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I remember there being some expectation that this would be difficult, but 
> it was a pretty straightforward conversion, so I'm wondering if I've 
> missed something. In any case, this is missing tests and documentation for 
> --output=, but I really want it to use directly for rebase-interactive, 
> and I only did the command line option so I could do informal testing.

I think I posted this link in that discussion already:

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=899fac730a75a0a8e6dd426e61beea113e75ac4b

But without user, this commit is not useful.  Therefore, here another 
link:

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=b5a44da9ecd15391e06c85fe8a2bb04b86f4f8d1

Eventually, Hannes solved the problem differently, so I did not bother to 
submit this officially, since it is not needed.

Ciao,
Dscho
