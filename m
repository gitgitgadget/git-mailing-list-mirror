From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Zooko's merge testcase
Date: Thu, 15 Jan 2009 04:36:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150432530.3586@pacific.mpi-cbg.de>
References: <1231980818-24812-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, zooko <zooko@zooko.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 04:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNJ2l-0003eW-RK
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 04:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbZAODfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 22:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbZAODfv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 22:35:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:55478 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754991AbZAODfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 22:35:50 -0500
Received: (qmail invoked by alias); 15 Jan 2009 03:35:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 15 Jan 2009 04:35:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c7wgvA6GcV8xp4xfcooBB54Z8fm0DjxaXg0cIMd
	tVB0BAl/ICSa+7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231980818-24812-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105761>

Hi,

On Thu, 15 Jan 2009, Miklos Vajna wrote:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---

I think the idea can be simplified.  Given lines A, B, C in the base 
commit, one branch _prepending_ the same triplet, and the other branch 
changing the B to a D.

Only this time, nobody has a chance, even Darcs, because from the diff, 
you would not know if it was prepended or appended.

(Which happens to be the same problem as 3-way merge has with the example 
you were implementing; only when looking at the detailed history becomes 
it clear what was done.)

This all just proves again that there can be no perfect merge strategy; 
you'll always have to verify that the right thing was done.

Ciao,
Dscho
