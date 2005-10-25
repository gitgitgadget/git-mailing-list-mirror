From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 25 Oct 2005 17:53:19 +0200
Message-ID: <200510251753.20164.blaisorblade@yahoo.it>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <tnxwtk1lj58.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ben Clifford <benc@hawaga.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 18:07:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EURIi-0007fn-Nh
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJYQFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 12:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVJYQFS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 12:05:18 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:43440 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932192AbVJYQFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 12:05:16 -0400
Received: (qmail 52909 invoked from network); 25 Oct 2005 15:49:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=a6/lON8IuK2pIWwY5b/CiFfWQo0fVbOqSmccKNvdgeXF/hZ/UnCinjTIjd8QLCeCReEIqXcUzJAyRk73s51twl/lG2R5tAytEMy3YqhEMv7GtdGGFm2x3NbrBWBTRvuNAsvoczGsyv55KSoGyIeFt+ol6OVsV4Q/yTdW3zz4XJk=  ;
Received: from unknown (HELO ?151.97.230.22?) (blaisorblade@151.97.230.22 with login)
  by smtp002.mail.ukl.yahoo.com with SMTP; 25 Oct 2005 15:49:37 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.3
In-Reply-To: <tnxwtk1lj58.fsf@arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10593>

On Tuesday 25 October 2005 17:18, Catalin Marinas wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > I'm using stgit on the Linux kernel so when on a command I don't have tab
> > completion I add the needed one (having the time and feeling to do
> > it).

> You can have a look at the tlacontrib project scripts (I can forward
> them to you since you would need tla/baz to clone/checkout the project
> and this procedure is a combination of 'tag' and 'get' commands). They
> automatically generate the commands together with the options and are
> later used in completion.

> Of course, your approach would work as well but it requires more
> maintance.

_Yes_, it wasn't ever intended to be published, and the help output doesn't 
seem, at a quick look, trivially parsable (the source is better to parse but 
I refuse that. Also, some options require still a special handling.

The best idea seems to write a Python script sourcing the Stgit source 
(stgit/main.py to get commands, and then loading each class and iterating 
over the "options" module member). I'm not fluent in Python enough currently, 
but when I'll find time I'll probably study a bit reflection and write this 
down (my Python experience amounts to some random readings on reviews and a 
couple of days with Python docs).

> >> if so, do you have any more formalised distribution process (like a
> >> git repo!) rather than grabbing code out of email list postings? I
> >> can't seem to find much on google...

> > Well, Catalin's TODO included "bash completions", so I assume the
> > thing could be merged by him. Anyway, I'm attaching the current
> > version.

> When you think it is ready, I'm happy to include it (though I would
> prefer a more dynamic approach like the tla one but since I don't have
> time for it I'll just use yours).

Btw, what do you think about speeding up completions by reimplementing things 
like "stg applied" or "stg unapplied" via cat (as noted in the comments at 
the beginning of the script)? Tab completions can easily livelock a shell on 
a busy system, so it's worthy speeding the thing up.

> Thanks.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
