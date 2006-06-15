From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 10:02:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
 <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 19:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqvEi-0003XT-Kd
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 19:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWFORCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWFORCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 13:02:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030367AbWFORCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 13:02:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5FH2Bgt006541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 10:02:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5FH2AiK019210;
	Thu, 15 Jun 2006 10:02:10 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060615163209.GJ7766@nowhere.earth>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21897>



On Thu, 15 Jun 2006, Yann Dirson wrote:
> 
> Well, being hated is often the fate of tools for which users got no
> training, but are forced to used because of a corporate decision.

That's one possible reason.

> That does not necessarily mean the tool is bad in itself.

It does not _necessarily_ mean that, but let's face it, it really usually 
does.

Too many developers shrug off the "it's hard to use" argument. THEY think 
it's fine. THEY think it's "lack of training". THEY think the tools are 
fine, and the problem is the user.

THEY are wrong.

Almost every time when a user says "it's hard to use", the user is right. 
Sometimes it's a lack of documentation, but quite often it's just that the 
tool interfaces are bad.

Oh, I'm sure git has the same problems, but dammit, I think we've tried 
very hard to listen to user opinions, and make the things that make them 
go "that's hard" be more obvious. All the things that were _possible_ to 
do if you did them by hand, that you now can do pretty obviously without 
even knowing what it really does. "git commit -a". "git log -p". "git show 
<name>", etc etc. 

Sometimes the problem space makes the interfaces fundamentally hard. But 
sometimes the program itself just makes things ugly and hard, and autoconf 
and automake definitely didn't make it easier for users - they were 
designed for people who knew fifteen different versions of UNIX, and not 
for sane people.

These days, there aren't fifteen different versions of UNIX. There's a 
couple, and it's perfectly ok to actually say "fix your damn system and 
just install GNU make". It's easier to install GNU make than it is to 
install autoconf/automake.

		Linus
