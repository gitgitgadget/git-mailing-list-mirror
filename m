From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] upload-pack: Initialize the exec-path.
Date: Tue, 12 Feb 2008 11:49:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802121149220.3870@racer.site>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com> <m31w7iegk6.fsf@localhost.localdomain> <47B15ADC.8080309@viscovery.net> <alpine.LSU.1.00.0802121028290.3870@racer.site> <47B182C1.60006@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOteO-0007Nl-DR
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 12:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYBLLti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 06:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYBLLth
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 06:49:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:48720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751046AbYBLLtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 06:49:36 -0500
Received: (qmail invoked by alias); 12 Feb 2008 11:49:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 12 Feb 2008 12:49:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cYlQ40LdchmhO5DXnVsTnxsTMjKiUe58nDIe17P
	814TxZLUdRTbt6
X-X-Sender: gene099@racer.site
In-Reply-To: <47B182C1.60006@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73655>

Hi,

On Tue, 12 Feb 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > Hi,
> > 
> > On Tue, 12 Feb 2008, Johannes Sixt wrote:
> >> The problem is that git-upload-pack (which is not a built-in) does not
> >> call setup_path() and so does not extend PATH to contain the special
> >> installation location. Now, when git-upload-pack tries to exec
> >> git-pack-objects, it fails since this is not in PATH.
> > 
> > So, let's make git-upload-pack a builtin, no?
> 
> How about this (almost) one-liner instead?

I'm fine with it.

Ciao,
Dscho
