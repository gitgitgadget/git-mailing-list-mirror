From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: SIGSEGV in merge recursive
Date: Sat, 30 Dec 2006 17:42:06 -0800 (PST)
Message-ID: <10871.51671.qm@web31801.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0piL-00073r-BN
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWLaBmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLaBmJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:42:09 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:43227 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932572AbWLaBmI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Dec 2006 20:42:08 -0500
Received: (qmail 51928 invoked by uid 60001); 31 Dec 2006 01:42:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Gpu87ZNoGvOSAG3sqYTtyvxITsl9gCWbmlgO+gsbVFiUHM5Rzi8A8eC4GmVnikXSmjCY6zbDKvUtolhB3G7fF7AcDwnv1tv35rl5/OrTVQETainEDk8CGMy0/Te8G78mesijGNJajbWUQqhjtiyXZ8yN1GuRi0kOhN5pCU3HNfM=;
X-YMail-OSG: MsuGciIVM1kn62L6BBeySK8yLqZ3EueCA9r8HdlWhxA4Spg7B4S87j8PU_81I3FR2uO75SNT8lrmGq9BgvIFhZp9zEMhapi2TvCaIazdp22dWjjAD0Ov7TrfZYe6d8Fg_LgiH7JkGdLE7CrapSDdwSAFpL8Oo4cXQF5YPDjciOhW7ip1mDXlJSTW
Received: from [71.84.31.238] by web31801.mail.mud.yahoo.com via HTTP; Sat, 30 Dec 2006 17:42:06 PST
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35643>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 29 Dec 2006, Luben Tuikov wrote:
> 
> > > > Failed to read a valid object file image from memory.
> > > 
> > > Who says this?
> 
> Again, who says this? I cannot find _anything_ in my local repo (with its 
> own set of modifications, which do not hide such a message).

GDB.  This message is not present when I run it manually from shell prompt.

> Given that there is a fix in master for a segfault, I have to admit that I 
> believe you did not use _that_ version, but a git without that fix.

A-ha!  Since I never run master, after I read your message, I compiled
master, installed it and tried the same merge/pull and it succeeded -- i.e.
didn't segfault, but complained about unresolved conflicts (as it should).

So it appears that the fix is in "master", but not in "next".

Junio, can you confirm this?

    Luben


> Besides, Alexandre hit an interesting bug, which is not at all easy to 
> reproduce (except with three 70k files which I don't want to include in 
> the test set). Since Alexandre provided _examples_ where I can _reproduce_ 
> the problem, I will be working on that bug, and not yours.
> 
> Ciao,
> Dscho
> 
> 
