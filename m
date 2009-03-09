From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Use a common function to get the pretty name of
 refs
Date: Mon, 9 Mar 2009 17:11:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091710020.6358@intel-tinevez-2-302>
References: <alpine.LNX.1.00.0903082104410.19665@iabervon.org> <alpine.DEB.1.00.0903091036420.10279@pacific.mpi-cbg.de> <alpine.LNX.1.00.0903091159000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgi65-0007Me-Cp
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbZCIQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbZCIQLH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:11:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:42057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbZCIQLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:11:05 -0400
Received: (qmail invoked by alias); 09 Mar 2009 16:11:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp032) with SMTP; 09 Mar 2009 17:11:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c8pZcOIicaqp664Fos+NXYCIBgXWefi7CmryQ7W
	egpDSMxJPb9tsC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.1.00.0903091159000.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112713>

Hi,

On Mon, 9 Mar 2009, Daniel Barkalow wrote:

> On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> 
> > On Sun, 8 Mar 2009, Daniel Barkalow wrote:
> > 
> > > The result should be consistent between fetch and push, so we ought 
> > > to use the same code in both cases, even though it's short.
> > 
> > You might want to mention that we cannot use skip_prefix() here, as 
> > that function does not give us any clue if something was skipped at 
> > all, and we must _not_ skip multiple prefixes.
> 
> I didn't even know about the skip_prefix() function; I just moved code 
> around.

But I know the function.  And I had to look at the code to end the 
head-scratching.  Therefore I'd like the paragraph I wrote to be part of 
the commit message, to save other people from going bald.

Ciao,
Dscho
