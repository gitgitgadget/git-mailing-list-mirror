From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator
 ';'.
Date: Fri, 29 Feb 2008 12:59:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291257150.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org> <200802282143.19322.johannes.sixt@telecom.at> <47C7BAEE.2020408@gnu.org> <alpine.LSU.1.00.0802291214160.22527@racer.site>
 <47C7FE7B.3030309@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 14:00:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4qa-0001Nc-Mc
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 14:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYB2M7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 07:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754405AbYB2M7o
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 07:59:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:53354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754276AbYB2M7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 07:59:43 -0500
Received: (qmail invoked by alias); 29 Feb 2008 12:59:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 29 Feb 2008 13:59:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196tkB6Net6IsnrgZjMJhBc3w0TP19lND+pM/bEGb
	vbp36IkbVIABnD
X-X-Sender: gene099@racer.site
In-Reply-To: <47C7FE7B.3030309@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75531>

Hi,

On Fri, 29 Feb 2008, Paolo Bonzini wrote:

> > However, there is something ugly waiting for us: we often have
> > 
> > 	case '/':
> > 
> > and for Windows, this needs to add
> > 
> > 	case '\\':
> 
> More often than in an "if" statement (so you can add IS_DIR_SEPARATOR 
> which is much less ugly than CASE_DIR_SEPARATOR)?

I have not grepped through the patches (as yourself, I am too lazy), but I 
remember seeing the "case" case in two instances, and I do not remember 
seeing the "if" case.

In the end, I think suggesting something like PATH_SEPARATOR is good.  But 
insisting on it without working on it is less good.

So I think that it is up to Hannes now; he got enough input, and he has a 
fine sense of taste, so he will do the Right Thing.

Ciao,
Dscho

