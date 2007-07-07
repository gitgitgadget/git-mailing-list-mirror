From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-lib.c: don't strdup twice
Date: Sat, 7 Jul 2007 19:52:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071951340.4093@racer.site>
References: <468FD91C.7040506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jul 07 20:59:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7FVa-0003cT-Ej
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 20:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbXGGS7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbXGGS7t
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 14:59:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:33366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753309AbXGGS7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 14:59:47 -0400
Received: (qmail invoked by alias); 07 Jul 2007 18:59:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 07 Jul 2007 20:59:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M0QEh/+JM3eCMicqhq+PxZJ2+kOyTdnnFQhwPnw
	maJwgNvsj3NEbV
X-X-Sender: gene099@racer.site
In-Reply-To: <468FD91C.7040506@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51834>

Hi,

On Sat, 7 Jul 2007, Ren? Scharfe wrote:

> The static function read_directory in diff-lib.c is only ever called 
> with struct path_list lists with .strdup_paths turned on, i.e. 
> path_list_insert will strdup the paths for us (again).  Let's take 
> advantage of that and stop doing it twice.

Indeed.

Acked-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho
