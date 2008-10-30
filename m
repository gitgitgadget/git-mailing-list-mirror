From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Thu, 30 Oct 2008 08:26:10 +0100
Message-ID: <20081030072610.GA1052@steel.home>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <20081029215444.GA19874@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 08:27:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvRwF-0002gJ-Th
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 08:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbYJ3H0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 03:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYJ3H0O
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 03:26:14 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:16735 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYJ3H0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 03:26:14 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BU83rXw=
Received: from tigra.home (Fae26.f.strato-dslnet.de [195.4.174.38])
	by post.webmailer.de (fruni mo30) (RZmta 17.14)
	with ESMTP id n00230k9U5wnVM ; Thu, 30 Oct 2008 08:26:10 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 87F80277C8;
	Thu, 30 Oct 2008 08:26:10 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3A2DB56D27; Thu, 30 Oct 2008 08:26:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081029215444.GA19874@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99447>

Jeff King, Wed, Oct 29, 2008 22:54:45 +0100:
> On Wed, Oct 29, 2008 at 11:38:32AM +0100, Alex Riesen wrote:
> 
> > There can be a problem with "-printf": Open Group SUS does not specify
> > -printf for find(1), so it is probably a problem somewhere. I just don't know.
> > [...]
> > +     find extract/a/a -printf "%T@\\n" >b.mtime &&
> 
> $ uname -sr
> FreeBSD 6.1-RELEASE-p17-jc1
> $ find . -printf "%T@\\n"
> find: -printf: unknown option
> 
> > There is always a fallback, which is to write a small program which calls
> > native stat(2). Or modify test-chmtime to just print mtime when asked.
> 
> I think that makes the most sense.
> 

Ok, will do.
