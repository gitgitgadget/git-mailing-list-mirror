From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and Media repositories....
Date: Mon, 3 Nov 2008 07:56:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811030755270.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225655428.11693.10.camel@vaio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:50:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwtGc-0000BA-UQ
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbYKCGtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYKCGtK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:49:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:52202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751995AbYKCGtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:49:09 -0500
Received: (qmail invoked by alias); 03 Nov 2008 06:49:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 03 Nov 2008 07:49:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gV1BjXjLgHzrmN/QhF4xmC3A8UXlk2ktqXzN+ap
	gDZJ0f0/V8Qvqf
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1225655428.11693.10.camel@vaio>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99905>

Hi,

On Sun, 2 Nov 2008, Tim Ansell wrote:

> Last week at the gittogether I lead some discussions about how we could 
> make Git better support large media repositories (which is one area 
> where Subversion still make sense). It was suggested that I post to this 
> list to get a discussion going.
> 
> The general idea is that we always clone the complete meta-data (tags, 
> commits and trees) and then only clone blobs when they are needed (using 
> something like alternates). This allows us to support shallow, narrow 
> and sparse checkouts while still being able to perform operations such 
> as committing and merging.
> 
> You can find a copy of the summary presentation at
>  http://www.thousandparsec.net/~tim/media+git.pdf
> 
> I have started working on adapting git to check a remote http alternate 
> to provide a proof of concept.
> 
> I appreciate any help or suggestions.

You might find this message (and others from the same time frame and 
author) pretty interesting:

http://article.gmane.org/gmane.comp.version-control.git/48485

Ciao,
Dscho
