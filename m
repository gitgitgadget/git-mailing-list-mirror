From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Tue, 17 Feb 2009 23:57:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302> <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYsx-0002xP-Ag
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZBQW4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbZBQW4N
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:56:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:50345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751778AbZBQW4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:56:12 -0500
Received: (qmail invoked by alias); 17 Feb 2009 22:56:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 17 Feb 2009 23:56:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QwAIYcSGQOEgD6jI/GGrrZgQVc0R0m/S2AyF5gk
	ws6X6Ue3iUJGtu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110465>

Hi,

On Tue, 17 Feb 2009, Keith Cascio wrote:

> On Tue, 17 Feb 2009, Johannes Schindelin wrote:
> 
> But these improvements stand well on their own.

That was my point; without anything on top I would not like to risk 
regressions that easily.

> > ... this does not look good to me, without a compelling reason why we 
> > want to have the patch nevertheless.
> 
> Is there something you dislike about the code style?  As always I'm 
> happy to adjust it.

If you had not so conveniently clipped what I quoted just before the three 
dots, I could point out that it adds roughly double the number of lines 
as it removes.

Ciao,
Dscho
