From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] include header to define uint32_t, necessary on Mac OS
 X
Date: Sat, 20 May 2006 09:50:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605200943270.10823@g5.osdl.org>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
 <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org> <7viroav534.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605142056320.3038@mundungus.clifford.ac>
 <Pine.LNX.4.64.0605142057220.10680@mundungus.clifford.ac>
 <20060520144111.GA5798@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Clifford <benc@hawaga.org.uk>, Junio C Hamano <junkio@cox.net>,
	Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 18:50:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhUfI-0000i9-Cw
	for gcvg-git@gmane.org; Sat, 20 May 2006 18:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWETQuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWETQuu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 12:50:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751419AbWETQut (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 12:50:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4KGoStH031727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 20 May 2006 09:50:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4KGoOlo001124;
	Sat, 20 May 2006 09:50:24 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060520144111.GA5798@steel.home>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20384>



On Sat, 20 May 2006, Alex Riesen wrote:

> Ben Clifford, Sun, May 14, 2006 22:58:33 +0200:
> >   #include <sys/time.h>
> >   #include <signal.h>
> > +#include <stdint.h>
> > 
> 
> BTW, Ben, how did you produce this patch? It has some unusual
> indentations...

I don't think it's the patch producer. It's some mail-mangler. Some broken 
mailers seem to add an extra space at the beginning of a line that already 
begins with a space - I've seen this before.

The headers would seem to say "Pine":

	Message-ID: <Pine.LNX.4.64.0605142057220.10680@mundungus.clifford.ac>

but that makes no sense, because mine certainly doesn't. But pine does 
have a few config options to mangle whitespace, so who knows..

It could also be the actual send path, of course.

		Linus
