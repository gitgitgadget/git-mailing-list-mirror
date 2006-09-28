From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 12:18:15 -0700 (PDT)
Message-ID: <20060928191816.76466.qmail@web51014.mail.yahoo.com>
References: <Pine.LNX.4.64.0609281043380.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:18:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1On-0001qI-Ab
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWI1TSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWI1TSS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:18:18 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:6805 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030378AbWI1TSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:18:17 -0400
Received: (qmail 76468 invoked by uid 60001); 28 Sep 2006 19:18:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W8JMSUZW0A+qKpfOUOyQtnPnJ0HjOy1MGAB6IAtelvsvPaZnY+pSHtwHbOp9SzY3IgtODJvzlUlwcXKUj2eP0ygRdV1A6roza2Nv3c4nXNZ692PeI3v+/1/P7NEpGgOx0eEX64VuJ5NABIxIqe5SFX3Hny4kF7qt2HjGrrMx6do=  ;
Received: from [207.172.80.85] by web51014.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 12:18:15 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281043380.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28039>

--- Linus Torvalds <torvalds@osdl.org> wrote:
 
>  - it means that the -same- exact project, when looked at frm two 
>    different sites that mirror it, have totally different times. In other 
>    words, the times have become pointless for something like gitweb.

Mirrored git repos probably should use the same timestamp, e.g. the "master" or "private" git
server's local time. Replicated repos have a delay compared to when you made changes in your
private repo, that is ok, replication is not what makes commit order inconsistent with time, it's
the act of pulling/merging from a server with misconfigured time and gitweb.cgi trusting "creation
time", right?  Or is replication the same thing as merging/pulling? 

-Matt 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
