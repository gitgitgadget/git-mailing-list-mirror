From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on Windows, CRLF issues
Date: Thu, 24 Apr 2008 09:11:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804240909220.26553@eeepc-johanness>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>  <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>  <20080422023918.GA5402@sigill.intra.peff.net>  <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> 
 <20080423080826.GA11935@sigill.intra.peff.net>  <480F1671.2060602@viscovery.net>  <20080423110402.GA27437@sigill.intra.peff.net>  <480F218C.3060703@viscovery.net>  <20080423214745.GA30057@sigill.intra.peff.net>  <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
 <32541b130804231604r4c439fa5va5c01bfd53a22cc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 10:12:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JowYe-00046d-Nm
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 10:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbYDXILK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 04:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYDXILK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 04:11:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:48138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbYDXILI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 04:11:08 -0400
Received: (qmail invoked by alias); 24 Apr 2008 08:11:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp045) with SMTP; 24 Apr 2008 10:11:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kXWs7wewkFS6vh+qqVfo+VnRw6FYiDyRnZU9S9O
	5gST8UV5lhp9gG
X-X-Sender: user@eeepc-johanness
In-Reply-To: <32541b130804231604r4c439fa5va5c01bfd53a22cc7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80298>

Hi,

On Wed, 23 Apr 2008, Avery Pennarun wrote:

> What I really want is the equivalent of "dos2unix --recursive *.c *.txt 
> etc" for all commits.

I start to wonder if "git fast-export --all | my-intelligent-perl-script | 
git fast-import" would not be a better solution here.

All you would have to do is to detect when a blob begins, and how long it 
is, and work with that.  If your trees do not contain any binary files, it 
should be trivial.

Ciao,
Dscho
