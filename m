From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 09:13:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
  <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com> 
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> 
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>  <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
  <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> 
 <43FD84EB.3040704@op5.se>  <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
  <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 18:14:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCK2R-0006mK-0g
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 18:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBWRNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 12:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWBWRNz
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 12:13:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWBWRNz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 12:13:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1NHDjDZ003377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Feb 2006 09:13:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1NHDhUH004235;
	Thu, 23 Feb 2006 09:13:44 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16654>



On Thu, 23 Feb 2006, Alex Riesen wrote:
>
> Someday we'll have to start dropping features on Windows or restrict them
> beyond their usefullness.

One thing that would help a bit would be to avoid shell.

There are many portable interpreters out there, and I don't mean perl. And 
writing a small "specialized for git" one isn't even that hard. In fact, 
most of the shell (and bash) hackery we do now would be unnecessary if we 
just made a small "git interpreter" that ran "git scripts".

The fact that it would also help portability is just an added advantage.

		Linus
