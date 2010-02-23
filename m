From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:51:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231450010.3980@intel-tinevez-2-302>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>  <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302> <fabb9a1e1002230507i56b32e8cwd7643a79284f6567@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjvAi-0001nC-4H
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab0BWNv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:51:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499Ab0BWNv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:51:27 -0500
Received: (qmail invoked by alias); 23 Feb 2010 13:51:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 23 Feb 2010 14:51:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7T/Fb6zm79yVzbtsUbNmRdfknbGmRJmbM45xdZs
	xAgQpGLek49y0f
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e1002230507i56b32e8cwd7643a79284f6567@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140800>

Hi,

On Tue, 23 Feb 2010, Sverre Rabbelier wrote:

> On Tue, Feb 23, 2010 at 14:03, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > May I caution against allowing "+" as part of filenames? On Windows, 
> > thanks to the DOS garb^Wheritage, "+" is not really allowed...
> 
> Would it be safe to say "raplce all occurences of '+' and '.' with
> '-'?

I'd rather only replace '+' with '-'. While "short" DOS filenames can only 
have one dot, and only up to three (upper-case) characters after that, 
"long" ones do not share that restriction.

> Is it feasible that we would want to support two protocols with a 
> different helper that map to the same 'name' using that scheme? So, 
> would there ever be a case where we want to handle "bzr+ssh" and 
> "bzr-ssh" with a different helper? I reckon not, and if it does occur 
> it's always possible to put a simple dispatcher in between?

Possible.

Ciao,
Dscho
