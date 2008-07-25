From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 15:41:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251541230.11976@eeepc-johanness>
References: <4889B66D.4020306@keyaccess.nl> <4889B912.9040006@viscovery.net> <alpine.DEB.1.00.0807251519290.11976@eeepc-johanness> <4889D66E.9090802@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Herman <rene.herman@keyaccess.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMNYe-0003bM-Qg
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbYGYNks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYGYNks
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:40:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751833AbYGYNkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:40:47 -0400
Received: (qmail invoked by alias); 25 Jul 2008 13:40:45 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp014) with SMTP; 25 Jul 2008 15:40:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/paUBGIBPpEbz7Y0R8YUvQE3J/5UL3edNTkfOBQA
	FJwcw9QfkHIW1z
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4889D66E.9090802@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90050>

Hi,

On Fri, 25 Jul 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Fri, 25 Jul 2008, Johannes Sixt wrote:
> > 
> >>   comm -13 <(git diff --name-only your-rev-here) <(git ls-files)
> > 
> > But should it not be -12?
> 
> I don't think so:
> 
>   -1 .. suppress lines unique to 1st arg, i.e. removed files
>   -2 .. suppress lines unique to 2nd arg, i.e. unmodified files
>   -3 .. suppress lines in both, i.e. modified and added files
> 
> We want to keep lines that -2 would remove, that leaves -1 and -3.

Oh, but of course!

Thanks again,
Dscho
