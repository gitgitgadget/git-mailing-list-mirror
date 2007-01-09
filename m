From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: New way of tracking remote branches -- question
Date: Tue, 9 Jan 2007 00:41:30 -0800 (PST)
Message-ID: <181306.34035.qm@web31814.mail.mud.yahoo.com>
References: <7vejq4r4ci.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 09:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4CYD-0000MK-1C
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXAIIlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbXAIIlc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:41:32 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:31805 "HELO
	web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751124AbXAIIlb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 03:41:31 -0500
Received: (qmail 35212 invoked by uid 60001); 9 Jan 2007 08:41:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KBqEjp6U50W12emjKsaRo2RK9V+CqO/cCdabFnjgahxC4d6ubVag7WLxA20YZen9fbMifQzG0aowybU8+JAAciobXz3cgUST7uzKWj8mFcJ0Jx3iOsiJ6Axa7PEopKJQyh2EnSIMXEVh0ax0vJK8YholvcvkXuwwh9Cz6AsJ5II=;
X-YMail-OSG: DspbrFcVM1mX0aekcaduYsphl4ZH7DFxyALm2moybBQLqlZ_tjFCHrpyGYm2aNR6R2SRHxPaKLEQoLQfB3CpbEPy1xS5cIQ0B8MOrN7e7nNkGrpwmfNPBrEVuBPB9WuJc6nDz77zd08-
Received: from [71.80.231.208] by web31814.mail.mud.yahoo.com via HTTP; Tue, 09 Jan 2007 00:41:30 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejq4r4ci.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36330>

--- Junio C Hamano <junkio@cox.net> wrote:
> > I guess, what I want is still to be able to "see" remotes/
> > when I do "git branch".
> 
> Then do not use "remotes/" but hang everything underneath
> "heads/" (or "git branch -a").
> 
> Of course, the next complaint from you would be that the latest
> git-clone would not make the traditional layout, but ...

What I meant was something of the lines of "git branch -r".
As I said, I don't mind the new way of seprating remote
branches per repo as is done by remotes/*/ .

> We've taken "one step at a time" by first introducing separate
> remote layout as an option, taught 'git branch' the needed
> options such as -a and -r, and then made this the default
> layout.  It still looks _different_ to me from what I am used
> to, but that's just traditionalist speaking and I cannot really
> deny the advantage of the separate remote layout offers.  In
> other words, we have been doing "one step at a time".

Me neither.  I also think there is an advantage of separately
tracking remotes as per remotes/*/ , so that organization is
better, i.e. per remote repo.

    Luben
