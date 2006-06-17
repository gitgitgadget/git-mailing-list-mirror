From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Shrink "struct object" a bit
Date: Sat, 17 Jun 2006 12:13:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606171211580.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606141630570.5498@g5.osdl.org>
 <44942176.1070107@mindspring.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 21:14:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrgFA-0007B0-1O
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 21:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWFQTNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWFQTNz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 15:13:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWFQTNz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 15:13:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5HJDngt018118
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Jun 2006 12:13:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5HJDmDS028094;
	Sat, 17 Jun 2006 12:13:48 -0700
To: Philip Pokorny <ppokorny@mindspring.com>
In-Reply-To: <44942176.1070107@mindspring.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22026>



On Sat, 17 Jun 2006, Philip Pokorny wrote:
> 
> A minor thing, but doesn't this mean the "report_missing" message would change
> from:
> 
> > Cannot obtain needed object ab12cdef1234567890abcd
> > while processing commit fedcbadeadbeefdeadbe
> 
> to
> 
> > Cannot obtain needed none ab12cdef1234567890abcd
> > while processing commit fedcbadeadbeefdeadbe

Yeah. I guess you could either just keep the old conditional, or just 
change the object type-name for the unspecified mode 0 to something like 
"untyped object" which would cause a much more readable errors.

		Linus
