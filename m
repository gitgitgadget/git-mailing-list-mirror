From: Jeff King <peff@peff.net>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 15:38:55 -0400
Message-ID: <20080323193855.GA22535@coredump.intra.peff.net>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc> <alpine.LSU.1.00.0803231518340.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdW2f-0004lM-0t
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbYCWTi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbYCWTi5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:38:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3016 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082AbYCWTi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:38:57 -0400
Received: (qmail 9312 invoked by uid 111); 23 Mar 2008 19:38:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 23 Mar 2008 15:38:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Mar 2008 15:38:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803231518340.4353@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77951>

On Sun, Mar 23, 2008 at 03:19:01PM +0100, Johannes Schindelin wrote:

> > > atag = !git tag -a -m "$1"
> 
> Why so complicated?
> 
> 	atag = tag -a -m
> 
> should work already.

The problem is that he needs to duplicate the final argument. I.e., "git
atag foo" becomes "git atag -a -m foo foo".

-Peff
