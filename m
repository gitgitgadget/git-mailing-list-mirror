From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 03:15:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:16:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKk0f-0003EZ-5T
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbYGUBPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbYGUBPD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:15:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:42443 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756141AbYGUBPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:15:02 -0400
Received: (qmail invoked by alias); 21 Jul 2008 01:15:00 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp043) with SMTP; 21 Jul 2008 03:15:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/K2/xMA2XKpxmho9wHflY6MO5hgEqJHRALaLSdVe
	ouGtuieTM4I41k
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89286>

Hi,

On Mon, 21 Jul 2008, Fredrik Tolf wrote:

> I'm following my previous SSH patch up with this one, which should at
> least solve the problems discussed, and probably some more. If anything,
> it might be considered a bit overkill for the problem at hand.

I am not assuming it is overkill, but since you do not reuse functions 
such as strbuf_expand() and split_cmdline(), your patch ends up pretty 
large.

And since you use very short and undescriptive variable names, with ugly 
assignments inside arithmetic expressions, I will be less likely 
reviewing it in detail.

> I assume it might have to be documented as well, if people approve of it.

Catch 22.  Since you have not documented what %P should be useful for, 
people might not approve of the patch, because they do not understand what
it is supposed to do.

People like me,
Dscho
