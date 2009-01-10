From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Get format-patch to show first commit after root
 commit
Date: Sat, 10 Jan 2009 11:27:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101122570.30769@pacific.mpi-cbg.de>
References: <49679f61.1b068e0a.048f.70e4@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 10 11:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLb4N-0001r1-V4
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbZAJK03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZAJK03
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:26:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:50594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121AbZAJK02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:26:28 -0500
Received: (qmail invoked by alias); 10 Jan 2009 10:26:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 10 Jan 2009 11:26:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pt5pGWRdpx0C3Oo+j0KIBsKndrzMYWaBCm7scwJ
	hGj8Jn8i5WXgaj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49679f61.1b068e0a.048f.70e4@mx.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105084>

Hi,

your mailing process has a problem; neither the recipients nor the subject 
made it into the mail header.

On Fri, 9 Jan 2009, nathan.panike@gmail.com wrote:

> >From 65c4fed27fe9752ffd0e3b7cb6807561a4dd4601 Mon Sep 17 00: 00:00 2001
> From: Nathan W. Panike <nathan.panike@gmail.com>
> Date: Fri, 9 Jan 2009 11:53:43 -0600
> Subject: [PATCH] Get format-patch to show first commit after root commit
> 
> Currently, the command
> 
> git format-patch -1 e83c5163316f89bfbde

You do not need -1, and using 19 digits seems a bit arbitrary; the 
convention seems to be 7 digits (that is what --abbrev-commit does).

> 
> in the git repository creates an empty file.  Instead, one is
> forced to do
> 
> git format-patch -1 --root e83c5163316f89bfbde
> 
> This seems arbitrary.  This patch fixes this case, so that
> 
> git format-patch -1 e83c5163316f89bfbde
> 
> will produce an actual patch.

IMHO mentioning --root is misleading, as the real bug is the empty diff.

Apart from that, I like the patch, though.

Thanks,
Dscho
