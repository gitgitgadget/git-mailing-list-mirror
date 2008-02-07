From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using thunderbird to post/apply patches?
Date: Thu, 7 Feb 2008 23:34:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802072333120.11591@racer.site>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNGGO-0003yy-KN
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbYBGXeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761185AbYBGXeB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:34:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:48740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758504AbYBGXeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:34:00 -0500
Received: (qmail invoked by alias); 07 Feb 2008 23:33:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 08 Feb 2008 00:33:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bFxRLSPRbx6N/bZQzr8kK82LDK+iNkr4IsX+aaY
	EA5FCSetfsOLiX
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73019>

Hi,

On Fri, 8 Feb 2008, Martin Langhoff wrote:

> Is there anyone using thunderbird/mozilla to post patches with 
> additional email commentary like Junio and Linus do? Are there good 
> tricks for this? Or otherwise a similar MUA that does things right?
> 
> The 2 workflows I am after are...
> 
>  - Load up a patch created with git-format-patch into my email editor
> to add some commentary before sending. Should not munge the patch
> itself!

The "Thunderbird" section in Documentation/SubmittingPatches should help 
here.

>  - Feed an email I am reading to git-apply-mbox so that if it's
> reasonably formatted as a patch it will do the right thing and apply
> it.

Recently, git-am learnt to apply mails in maildir format.  Thunderbird 
uses maildir format internally, if I am not mistaken.

Hth,
Dscho
