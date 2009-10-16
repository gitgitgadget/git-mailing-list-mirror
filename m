From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Add proof-of-concept %[w(width,in1,in2)<<any-string>>%]
 implementation
Date: Fri, 16 Oct 2009 13:32:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910161331350.4985@pacific.mpi-cbg.de>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <1255681702-5215-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 13:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myl6E-0004zE-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbZJPLam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbZJPLam
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:30:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:50560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758801AbZJPLal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:30:41 -0400
Received: (qmail invoked by alias); 16 Oct 2009 11:29:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 16 Oct 2009 13:29:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lkHd/OfDlAP7qIwjYQApzU2pFJWiQ7bZubMnTZx
	OvaMNLCIwWKCiN
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1255681702-5215-4-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130478>

Hi,

maybe "rewrap" would be a better name than "w"?

On Fri, 16 Oct 2009, Junio C Hamano wrote:

>   #1 "%[" introduces the nested string function.
> 
>   #2 After that, a name identifies what function to call.
> 
>   #3 The function parses its parameters ("(72,4,8)" in the above example),
>      and makes a nested expansion on the remainder of the format string.

Can't we parse it once, i.e. the first time?

Ciao,
Dscho
