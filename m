From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 14:29:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151422140.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>  <200908152119.56606.trast@student.ethz.ch> <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>  <7viqgoestz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0908151324380.3162@localhost.localdomain>
 <32541b130908151405j661cde8fh9783e91cebf1e398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 23:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQpW-0001C0-8d
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 23:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZHOVaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 17:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZHOVaQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 17:30:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33203 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbZHOVaP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 17:30:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FLTXXb013039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 14:29:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FLTX5H024117;
	Sat, 15 Aug 2009 14:29:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <32541b130908151405j661cde8fh9783e91cebf1e398@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126031>



On Sat, 15 Aug 2009, Avery Pennarun wrote:
> 
> I'm guessing that "after header" was just an implementation error.  It
> was presumably intended to be "after commit", so that the only
> difference between format and tformat is the presence or absence of
> the very last terminator.
> 
> Maybe the correct fix is just to make tformat not broken?

I do agree. 'tformat' is broken. But my point was more that 'tformat' was 
introduced for all the wrong reasons (ie that 'format' was broken, and 
then instead of fixing 'format', people introduced 'tformat' with a 
_different_ brokenness).

		Linus
