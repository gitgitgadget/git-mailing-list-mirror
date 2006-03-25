From: sean <seanlkml@sympatico.ca>
Subject: Re: starting completly new repository
Date: Sat, 25 Mar 2006 16:45:19 -0500
Message-ID: <BAYC1-PASMTP06D0D5B809FAC3DB5EABDCAEDC0@CEZ.ICE>
References: <Pine.LNX.4.63.0603252148550.14361@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 22:47:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNGc1-0004Zq-Qm
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 22:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCYVry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 16:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCYVry
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 16:47:54 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:41880 "EHLO
	BAYC1-PASMTP06.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750869AbWCYVry (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 16:47:54 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP06.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 25 Mar 2006 13:49:10 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4DEB2644C17;
	Sat, 25 Mar 2006 16:47:48 -0500 (EST)
To: Grzegorz Kulewski <kangur@polcom.net>
Message-Id: <20060325164519.1081e345.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0603252148550.14361@alpha.polcom.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Mar 2006 21:49:11.0125 (UTC) FILETIME=[F350F850:01C65055]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Mar 2006 22:06:42 +0100 (CET)
Grzegorz Kulewski <kangur@polcom.net> wrote:

> (on the server)
> mkdir main
> git-init-db
> touch .git/git-daemon-export-ok
> 
> (on my computer)
> git-clone git://host/main main
> 
> But it looks like I must first do some commit on the server? But I can not 
> make empty commit just to have things started? Or maybe there is some 
> other way...

Did you actually start the git-daemon on the server?
 
> Also I wonder if I can do push over git protocol or I must use real ssh 
> account on the server? This is not clear from the docs... At least not for 
> me. How should I set up my repo (on my computer) to be able to push 
> commits into main repo?

You can't commit over the git protocol, you'll need to use ssh.  
No need to do anything to your repo in order to push.

> Also what should I set up additionally? How can I easily set author name 
> and email for each repo? 

See below.

> What is the difference between author and commiter and how should I 
> set this up here?

Just what you might imagine, the person who created the patch and
the person who entered it into the repository respectively.
 
> Is there any documentation about git config file? Can I set author name, 
> email and preffered editor in it or must I use environment?

$ git repo-config user.email "user@email.com"
$ git repo-config user.name  "full name"

use the EDITOR environment variable to choose your desired editor.

> Is there some irc channel for asking dumb questions as above and having 
> them anwsered fast or should I use this mailing list?
 
#git on irc.freenode.net

Sean
