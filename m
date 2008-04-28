From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 22:09:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282209230.19187@eeepc-johanness>
References: <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness>
 <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness> <20080428204323.GA22815@cuci.nl> <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness> <20080428210003.GB22815@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:11:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqaco-0003iW-MS
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937957AbYD1VJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937954AbYD1VJo
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:09:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:51410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937950AbYD1VJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:09:43 -0400
Received: (qmail invoked by alias); 28 Apr 2008 21:09:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 28 Apr 2008 23:09:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xm4ZRbYBXx4SKZ6kmGc3MvtGNRQY1d6t6CK/sLm
	nPH620zU0LWZSC
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428210003.GB22815@cuci.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80614>

Hi,

On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:

> Johannes Schindelin wrote:
> >On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
> >> - git-daemon logs happily for a while
> >> - rotatelog rotates logfiles in /var/log and communicates with syslogd
> >>   to make sure syslogd starts new logfiles in /var/log
> >> - And then git-daemon hangs on which system/library call?
> 
> >It seems that this happens, yes.
> 
> Could you hang an strace off of git-daemon and check what system call it
> hangs on at that point in time?

I can do better than that.  I attached to the process, and like I said, it 
hung in close().

Ciao,
Dscho
