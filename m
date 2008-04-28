From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 20:53:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
 <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:54:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZRB-0002nG-J0
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934977AbYD1Txh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933801AbYD1Txh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:53:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:42273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934970AbYD1Txf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:53:35 -0400
Received: (qmail invoked by alias); 28 Apr 2008 19:53:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 28 Apr 2008 21:53:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186Q7YMAIY6gxlymHKnjKL0u3NWulDiYP6ULBfmoS
	UtXqxbhWdbVwdH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428192837.GB21950@cuci.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80601>

Hi,

since you seem to be very new to this list: we really appreciate a 
Reply-to-all here.

On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:

> >> I have no idea, but other programs must have the same problem.  I 
> >> should
> 
> They don't.  Your patch fixes the wrong problem.  Please don't fix 
> something that wasn't broken in the first place.

So do you have any ideas what is happening there?  It seems that after 
logrotate does its thing, syslog() is stuck in the close() call.

Any constructive help is very much appreciated.

Ciao,
Dscho
