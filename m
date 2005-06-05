From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: SSH pull problems
Date: Sun, 05 Jun 2005 20:02:30 +0200
Message-ID: <42A33E36.3060702@gorzow.mm.pl>
References: <Pine.LNX.4.21.0506051336440.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 20:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezOy-0005jZ-NI
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVFESCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFESCo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 14:02:44 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:1453 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261601AbVFESCl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 14:02:41 -0400
Received: (qmail 20114 invoked from network); 5 Jun 2005 18:02:38 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <barkalow@iabervon.org>; 5 Jun 2005 18:02:38 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id A56F05C09D6;
	Sun,  5 Jun 2005 20:02:30 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506051336440.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:

>On Sat, 4 Jun 2005, Radoslaw Szkodzinski wrote:
>
>  
>
>>I had some problems today with git+ssh protocol.
>>First, when using cg-clone, it couldn't execute cg-rpush, although it's
>>there in /usr/local.
>>Maybe that has something to do with that being added to the path in
>>/etc/profile.
>>    
>>
>
>I haven't used recent Cogito, so I'm not sure, but it might actually want
>git-rpush rather than cg-rpush? Or it might be a permissions issue?
>
>  
>
Make that git-rpush, I was writing from my memory, and it couldn't find
it, as in "Command not found".
It's available for all to exec, in /usr/local.

>>Second, I don't know how to specify the port number,
>>the typical notation of git+ssh://xyz:port/repo didn't work.
>>    
>>
>
>I haven't made it understand port numbers yet; it should be pretty easy,
>though, if you want to do it. You'd probably have a better chance of
>getting it right than I would, if you've got an SSH server on a
>non-default port to test against. Just parse out the part of "host" after
>the : and make it a "-p" option in the execlp in rsh.c.
>
>  
>
That's not a problem, I'll get to it in some short time and post a patch.

AstralStorm
