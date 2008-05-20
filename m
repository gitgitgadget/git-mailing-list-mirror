From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin-clone does not fallback to copy when link fails
Date: Tue, 20 May 2008 22:48:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805202248000.30431@racer>
References: <oguFi9b5ZAq84dsDzWpm0tpI_xzucMxL23YhxIjDS5NTdpslAnzo6w@cipher.nrlssc.navy.mil> <C6tFzFdDycYRRcjxtVG00CVX-Nsu7-UblPCaZmTxmWIUTFAsgReYbQ@cipher.nrlssc.navy.mil> <alpine.LNX.1.00.0805201311180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 20 23:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyZhs-0001qk-RD
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 23:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbYETVs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760811AbYETVs0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:48:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:42449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757127AbYETVsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:48:25 -0400
Received: (qmail invoked by alias); 20 May 2008 21:48:23 -0000
Received: from R03d1.r.pppool.de (EHLO racer.local) [89.54.3.209]
  by mail.gmx.net (mp049) with SMTP; 20 May 2008 23:48:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RfdlKchqRmYX5sWW1E1/TlpAswBMKcmOESAfzRv
	hvnjEOBjbrUl0+
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0805201311180.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82507>

Hi,

On Tue, 20 May 2008, Daniel Barkalow wrote:

> How about:
> 
> -----
> commit 83afef6a159365c1b9a7a1961cb4c95df24fbcac
> Author: Daniel Barkalow <barkalow@iabervon.org>
> Date:   Tue May 20 14:15:14 2008 -0400
> 
>     Fall back to copying if hardlinking fails
>     
>     Note that it stops trying hardlinks if any fail.
>     
>     Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

I like it.

Ciao,
Dscho
