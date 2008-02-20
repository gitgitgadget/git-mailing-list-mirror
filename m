From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix "git push $there +HEAD"
Date: Wed, 20 Feb 2008 13:02:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802201301230.17164@racer.site>
References: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 14:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRobU-0005GK-4i
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 14:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763470AbYBTNCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 08:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763440AbYBTNCi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 08:02:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:48745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760444AbYBTNCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 08:02:37 -0500
Received: (qmail invoked by alias); 20 Feb 2008 13:02:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 20 Feb 2008 14:02:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lyNNxBtblEFCp4TwjLCGIxb794VkvOO02m2mIhQ
	xiG6ZHuIFzCQGK
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74511>

Hi,

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> An earlier commit 47d996a (push: support pushing HEAD to real branch 
> name) added support for "git push $there HEAD" by introducing a rewrite 
> rule for the refspecs obtained from the command line.  However, unlike 
> the usual refspecs, it did not allow prefixing with '+' to mean forcing 
> the branch.

Heh.  I realised that yesterday, and put it in my TODO list.  Thanks for 
doing it for me! ;-)

The patch looks obviously correct to me.

Ciao,
Dscho
