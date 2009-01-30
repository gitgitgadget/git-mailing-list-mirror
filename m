From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] fsck: HEAD is part of refs
Date: Fri, 30 Jan 2009 17:47:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301746370.3586@pacific.mpi-cbg.de>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com> <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu> <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain> <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwXo-0003NJ-Kh
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZA3QrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbZA3QrN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:47:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:49868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752506AbZA3QrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:47:13 -0500
Received: (qmail invoked by alias); 30 Jan 2009 16:47:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 30 Jan 2009 17:47:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m3bkcenGmcW1AsQXUooT3kteqv3UtF5XmskfvZj
	zTRBfbTQQskUDP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107848>

Hi,

On Fri, 30 Jan 2009, Junio C Hamano wrote:

> By default we looked at all refs but not HEAD.  The only thing that
> made fsck not lose sight of comments that are only reachable from a
> detached HEAD was the reflog for the HEAD.

When fixing the revision machinery to imply HEAD with --all, I thought of 
fsck, too, but forgot to check if it does actually use the revision 
walker.

Sorry about this,
Dscho
