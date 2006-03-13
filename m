From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Mon, 13 Mar 2006 17:37:07 +0100
Message-ID: <20060313163707.GB87487@dspnet.fr.eu.org>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com> <4414E000.9030902@zytor.com> <4414F6B1.9080107@gmail.com> <Pine.LNX.4.64.0603122103440.3618@g5.osdl.org> <44151330.7020905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Mar 13 17:42:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIq2n-0007Id-Ol
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWCMQhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWCMQhN
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:37:13 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3341 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751505AbWCMQhM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:37:12 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 58C49A376D; Mon, 13 Mar 2006 17:37:07 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <44151330.7020905@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17572>

On Sun, Mar 12, 2006 at 10:37:36PM -0800, H. Peter Anvin wrote:
> On "real" machines, the biggest reason you'd care is that a lot of 
> compilers, *especially* in C++ mode, really still define NULL as "0"; 
> ostensibly because defining it as "((void *)0)" breaks some obscure C++ 
> casting rule.

Not obscure, just a religious issue.  Somehow in the creation of the
C++ standard the definition of void * got changed from "generic
pointer" to something else I've been unable to fathom.  That
definition, whatever it is, justifies forbidding implicit casts from
void * to anything else.  Some of the priests of the new definition
consider the existence in C of a usable generic pointer type to be a
failing of the language too.

  OG.
