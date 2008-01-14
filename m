From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Mon, 14 Jan 2008 12:18:13 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801141202240.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 12:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JENL4-0001Go-Ku
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 12:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbYANLSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 06:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755544AbYANLSR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 06:18:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:34413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754645AbYANLSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 06:18:16 -0500
Received: (qmail invoked by alias); 14 Jan 2008 11:18:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp058) with SMTP; 14 Jan 2008 12:18:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+jzwZzZE+L5TlS4D4w1sWDSrN+N8CjpHnKwSPvd
	wh1NLikuW6Zd89
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70453>

Hi,

On Sun, 13 Jan 2008, Junio C Hamano wrote:

> And we already have "clone -o" and claim to support that option.

My understanding was _always_ that the "-o" option was meant for the case 
that you want to clone from somewhere else than where you want to pull 
from.  Something like an initial clone from a USB disk.

>  * test scripts to use valgrind (Jeff King, but there was another
>    one in the past -- can their efforts compared and coordinated
>    better?).

Yes, that was written in Perl by Christian Couder:

http://article.gmane.org/gmane.comp.version-control.git/69236

Peff's version does not need Perl, and is better integrated with the 
testsuite (via the new option -m).  Christian's version parses the output, 
and might therefore be nicer to look at.

However, I think that both versions do not account for scripts, and I 
imagine that going through Git.pm and git-sh-setup is necessary for that.

Also, it might be a good idea to be able to provide extra arguments, such 
as "--attach-db=yes".

Post 1.5.4, definitely.

Ciao,
Dscho
