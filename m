From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 11:54:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602231151580.3771@g5.osdl.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602232037260.30630@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 20:54:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMY1-0003HZ-9p
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWBWTym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWBWTym
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:54:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751777AbWBWTyl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 14:54:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1NJsZDZ011921
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Feb 2006 11:54:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1NJsVUS011122;
	Thu, 23 Feb 2006 11:54:33 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602232037260.30630@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16662>



On Thu, 23 Feb 2006, Johannes Schindelin wrote:
> > 
> > Before anybody mentions tcl ;-).
> 
> Darn, I had my suggestion sent out: Java ;-)

I do see the smileys, but the fact is, "perl" is a hell of a lot more 
portable than either, if we want to talk executing processes and pipelines 
etc. But even perl is clearly not portable enough, and has tons of version 
skew.

Java, afaik, has absolutely _zero_ support for creating a new process and 
piping its output to another one and doing things like safe argument 
expansion. Which is what almost all of the git scripts are all about.

		Linus
