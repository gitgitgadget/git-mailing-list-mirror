From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Sat, 15 Aug 2009 02:08:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nico@cam.org, gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 15 02:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc6ok-00057Q-CM
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 02:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbZHOAIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 20:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbZHOAIF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 20:08:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:35581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753611AbZHOAIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 20:08:05 -0400
Received: (qmail invoked by alias); 15 Aug 2009 00:08:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 15 Aug 2009 02:08:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tsbd0kwrt+YZkoIjBbc2ebl8aH9eYt+4dj0uqLV
	BYEzlroa3pioiZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125968>

Hi,

On Fri, 14 Aug 2009, Brandon Casey wrote:

> Some compilers produce errors when arithmetic is attempted on pointers to
> void.  So cast to uintptr_t when performing arithmetic on void pointers.

I am confused.  Is sizeof(*(uintptr_t)NULL) not larger than 1, and as a 
consequence ((uintptr_t)p)+1 not different from ((void *)p)+1?

Ciao,
Dscho
