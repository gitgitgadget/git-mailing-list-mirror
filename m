From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATH] sed -e '/RE/r rfile/' needs space in 'r rfile'
Date: Sat, 8 Jul 2006 20:57:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607082055360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200607081727.10837.michal.rokos@nextsoft.cz>
 <Pine.LNX.4.63.0607081844580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7j2oq7h3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 20:57:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHzx-0006Aq-1c
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWGHS5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWGHS5q
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:57:46 -0400
Received: from mail.gmx.de ([213.165.64.21]:53154 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030216AbWGHS5p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 14:57:45 -0400
Received: (qmail invoked by alias); 08 Jul 2006 18:57:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 08 Jul 2006 20:57:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j2oq7h3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23497>

Hi,

On Sat, 8 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> in commit 07002287f3e219a16a948a8a6eca0a41162a491f
> >> you cleaned up 'replace ugly and unportable sed invocation' as you said.
> >> Please note, that some SEDs (like HP-UX one) mandate a space between 'r' 
> >> and 'rfile'.
> >
> > Ack. Note that this is yet-another-reason to step away from scripts.
> 
> Are you talking about doing this part in the Makefile in C ;-)?

If it is not portable, then yes ;-)

But of course, you know the spirit this was written in: I had no way to 
test with sed on HP-UX, so I do not know if my change works there. 
However, I know that if it is C -- except for bugs in HP-UX's C compiler 
-- then it works on HP-UX as expected.

Ciao,
Dscho
