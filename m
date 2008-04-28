From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 19:08:50 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:10:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXn7-0004zO-99
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbYD1SIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbYD1SIl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:08:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:35403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934311AbYD1SIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:08:40 -0400
Received: (qmail invoked by alias); 28 Apr 2008 18:08:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 28 Apr 2008 20:08:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cQ/9z8vvcb7Las1rDkDAT97wBSotXDApgqDItHy
	IyQ5o4XHq/Rrm5
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80575>

Hi,

On Mon, 28 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With rotating logs, there is a problem when the syslog is opened only 
> > once (in the beginning).  So open the log everytime we write 
> > something, and close it directly after writing.
> 
> Gaah, this is ugly.
> 
> Is this something all the daemons need to deal with?

I have no idea, but it seems to fix a real issue.

Ciao,
Dscho
