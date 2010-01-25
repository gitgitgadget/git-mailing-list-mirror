From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 19:19:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001251916030.8733@intel-tinevez-2-302>
References: <201001250155.47664.robin.rosenberg@dewire.com>  <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302> <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 25 19:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZU3L-0004gL-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab0AYSwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241Ab0AYSwn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:52:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:36796 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752288Ab0AYSwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 13:52:42 -0500
Received: (qmail invoked by alias); 25 Jan 2010 18:19:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 25 Jan 2010 19:19:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190CGQLafJ0kLyfP1SmXDXBauC1GdeS70puaov3qU
	gO0gjoCL4+Va+Q
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137977>

Hi,

On Mon, 25 Jan 2010, Erik Faye-Lund wrote:

> On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Mon, 25 Jan 2010, Robin Rosenberg wrote:
> >
> >> >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 2001
> >> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> >> Date: Mon, 25 Jan 2010 01:41:03 +0100
> >> Subject: [PATCH] Handle UNC paths everywhere
> >>
> >> In Windows paths beginning with // are knows as UNC paths. They are
> >> absolute paths, usually referring to a shared resource on a server.
> >
> > And even a simple "cd" with them does not work.
> >
> 
> But it does, at least for me - both in bash and cmd.exe. I just need
> to log on to the server first, unless it's a public share.

I love it when people say "it works for me, so let's do it".

_My_ _only_ instance of Windows cmd says this:

	C:\Blah> cd \\localhost
	'\\localhost'
	CMD does not support UNC paths as current directories.
	
	C:\Blah>

So.

Besides, the patch was not in a form where I can say that it was obviously 
fixing the issue. It was rather in a form where I would have to have set 
aside a substantial amount of time to verify that nothing undesired was 
introduced as a side effect.

Ciao,
Dscho
