From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] fatal error during merge
Date: Mon, 11 May 2009 10:34:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905111033400.27348@pacific.mpi-cbg.de>
References: <20090510163336.GA27241@blimp.localdomain> <41870.bFoQE3daRhY=.1242027423.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon May 11 10:35:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Qyb-0006M2-0F
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 10:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZEKIex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 04:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbZEKIex
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 04:34:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:57052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753262AbZEKIew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 04:34:52 -0400
Received: (qmail invoked by alias); 11 May 2009 08:34:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 11 May 2009 10:34:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q2VstRllqNU+Dh81jtRyYJZK7pA8NM1z8zn6jOA
	lDhmYN+/BWMdQW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <41870.bFoQE3daRhY=.1242027423.squirrel@webmail.hotelhot.dk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118782>

Hi,

On Mon, 11 May 2009, Anders Melchiorsen wrote:

> On Sun, 10 May 2009 18:33:36 +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
> 
> > I still have the patch below (rebased) in my tree.
> > Was the problem fixed somehow differently?
> 
> > Subject: [PATCH] Update index after refusing to rewrite files unchanged
> > during merge
> 
> I tested recently, and it does not appear to be fixed yet.
> 
> However, your patch was not enough to fix my test case completely,
> so I am unsure whether it makes sense to apply it as a partial fix.
> 
> The test is here:
> 
>    http://article.gmane.org/gmane.comp.version-control.git/116999

Maybe you can turn this into a patch adding a test (with 
test_expect_failure to mark it as a bug)?  This would make debugging a lot 
easier, as a non-installed Git could be tested.

Ciao,
Dscho
