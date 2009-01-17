From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible git bug
Date: Sat, 17 Jan 2009 16:16:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171613540.3586@pacific.mpi-cbg.de>
References: <87zlhqca4m.fsf@inbox.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Damon LaCrosse <arid@inbox.ru>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOCuk-0000Hv-LA
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132AbZAQPPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757965AbZAQPPW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:15:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57788 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758087AbZAQPPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:15:21 -0500
Received: (qmail invoked by alias); 17 Jan 2009 15:15:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 17 Jan 2009 16:15:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xlvVRHYIxZogRlxRz2Nq6aCE6kNnwjA2MtLoLGl
	177HzuO46OdiG4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87zlhqca4m.fsf@inbox.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106056>

Hi,

On Sat, 17 Jan 2009, Damon LaCrosse wrote:

> any chances the attached patch reveals a git bug?

You mean that it produces a merge conflict when a file was modified in one 
branch, and deleted in the other?

Because that's what you did, basically.  You did not rename file1 to 
file2.  You completely changed the contents.  I mean, completely.

Ciao,
Dscho
