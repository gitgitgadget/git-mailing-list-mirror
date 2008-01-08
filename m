From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: config: add 'help.*' and 'instaweb.*'
 variables.
Date: Tue, 8 Jan 2008 10:32:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801081030580.10101@racer.site>
References: <20080108045514.1a506761.chriscool@tuxfamily.org> <7vmyrgx26h.fsf@gitster.siamese.dyndns.org> <200801080843.35693.chriscool@tuxfamily.org> <7vabngwyra.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 11:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBlq-00041n-UR
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYAHKcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 05:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYAHKcz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:32:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:51904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbYAHKcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 05:32:54 -0500
Received: (qmail invoked by alias); 08 Jan 2008 10:32:52 -0000
Received: from host86-149-202-249.range86-149.btcentralplus.com (EHLO [192.168.1.3]) [86.149.202.249]
  by mail.gmx.net (mp006) with SMTP; 08 Jan 2008 11:32:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aMJsKQ1iaXDJgEL8qmfJDUEH4/SOG9nJFXA4/rz
	TdKEE5gcazXnr0
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabngwyra.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69859>

Hi,

On Mon, 7 Jan 2008, Junio C Hamano wrote:

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > By the way I had no comment on my RFC/Patch to run the test scripts 
> > under valgrind. Maybe it's useless because it doesn't find any bug 
> > right now.
> 
> I found it interesting myself.  I did not know how well it fits into the 
> rest of the testing infrastructure, though.  Perhaps you would want to 
> reopen the issue after 1.5.4?

I meant to rewrite it as a patch to test-lib.sh, because I found the use 
of perl not necessary.  Besides, I would like to integrate it better, i.e. 
"make USE_VALGRIND=yes" or "make USE_VALGRIND=t1501:2".

Ciao,
Dscho
