From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9600-cvsimport.sh: set HOME before checking for cvsps
 availability
Date: Thu, 27 Mar 2008 12:07:59 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803271207190.3802@racer.site>
References: <20080326173420.16383.qmail@4b0e1e5c705f62.315fe32.mid.smarden.org> <7v8x05e5fa.fsf@gitster.siamese.dyndns.org> <20080327032834.GA5417@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 12:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JepyM-0007MI-8C
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 12:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbYC0LIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 07:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755727AbYC0LH7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 07:07:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755271AbYC0LH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 07:07:59 -0400
Received: (qmail invoked by alias); 27 Mar 2008 11:07:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 27 Mar 2008 12:07:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o1HJ1ED3oeA/exiVARsdmMzcohwGF+RRtDAZWVt
	Ctghi+FeT5seTB
X-X-Sender: gene099@racer.site
In-Reply-To: <20080327032834.GA5417@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 26 Mar 2008, Jeff King wrote:

> However, I still think setting HOME is a good idea, because it 
> eliminates one more variable in test runs. In particular, I know I have 
> gotten cvsps into a funny state that was resolved by removing the 
> ~/.cvsps cache. So it's probably worth doing as a preventative measure, 
> even if it doesn't fix a specific bug.

Yes, I did not think about 3rd party configurations when I removed that 
HOME setting.  Bad me.

Ciao,
Dscho
