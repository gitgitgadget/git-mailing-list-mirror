From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 14:28:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121428310.30431@racer>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Mon May 12 15:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvY6G-0000iE-E9
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 15:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYELN3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 09:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYELN3E
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 09:29:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:33344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbYELN3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 09:29:03 -0400
Received: (qmail invoked by alias); 12 May 2008 13:29:00 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp034) with SMTP; 12 May 2008 15:29:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mFqFCq0mmerz7fT1hu25Wml8ZiOGnMMQZza/pNe
	Dvzsb6DyT/Xu5M
X-X-Sender: gene099@racer
In-Reply-To: <87ej87is50.fsf@offby1.atm01.sea.blarg.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81864>

Hi,

On Mon, 12 May 2008, Eric Hanchrow wrote:

> >>>>> "bill" == bill lam <cbill.lam@gmail.com> writes:
> 
>     bill> Hello, this should be a simple question.  How to backup a git
>     bill> repository but excluding files that not under versioned?  If I
>     bill> cp or tar or rsync the directory.  All non-versioned files are
>     bill> added.
> 
> I'd rsync just the .git directory.

Note that this is necessary if you want to keep the reflogs (clone would 
not copy them).

Ciao,
Dscho
