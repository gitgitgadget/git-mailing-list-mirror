From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 10 Feb 2008 16:48:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101647050.11591@racer.site>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <m3wspcg4hg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:48:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFM7-0002xq-Gv
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYBJQsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbYBJQsD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:48:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:59669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751296AbYBJQsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:48:01 -0500
Received: (qmail invoked by alias); 10 Feb 2008 16:48:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 10 Feb 2008 17:48:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Csb9Rn2EC2Y4NGIo/2Qe4QWadMpYyo1zLTEjq0x
	1wL+K11WNagOgr
X-X-Sender: gene099@racer.site
In-Reply-To: <m3wspcg4hg.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73373>

Hi,

On Sun, 10 Feb 2008, Jakub Narebski wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
> >  - Authentication support for pserver
> > 
> > This needs careful security audit and a fix to its password database 
> > format.  Plaintext in .git/config is not acceptable.
> 
> Does git-cvsserver understand .netrc?

It is not about the client side of authentication, but the server side.  
So no, git-cvsserver does not, and should not, understand .netrc.

Ciao,
Dscho
