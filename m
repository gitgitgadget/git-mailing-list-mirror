From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more.
Date: Sun, 11 Jun 2006 09:45:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606110942560.5498@g5.osdl.org>
References: <20060611100628.GA10430@bohr.gbar.dtu.dk>
 <20060611.191540.68073375.yoshfuji@linux-ipv6.org> <20060611103358.GB10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 18:45:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpT3o-0001Fn-Go
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFKQpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWFKQpH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:45:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbWFKQpF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 12:45:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BGj2gt022530
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 09:45:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BGj1Iq026193;
	Sun, 11 Jun 2006 09:45:02 -0700
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20060611103358.GB10430@bohr.gbar.dtu.dk>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21661>



On Sun, 11 Jun 2006, Peter Eriksen wrote:
> > 
> > Please include full copyright information.
> 
> Where should this information go?

Gaah, for soemthing as trivial as strlcpy(), please either just rewrite 
the function (you can only do it in so many ways), since the copyright 
message is _bigger_ and more annoying than the code itself.

Or, just attribute it. Say "this is a trivial implementation 'strlcpy()' 
shamelessly stolen from OpenBSD, originally under a BSD license, converted 
to GPLv2"

That whole "big copyright messages" thign is a _disease_. 

		Linus
