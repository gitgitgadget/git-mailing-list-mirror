From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 21:39:41 -0000
Message-ID: <gje4ff$ip6$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org> <gjdmm6$9oj$4@ger.gmane.org> <3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 22:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmLJ-0000xV-PZ
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYL3VkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYL3VkU
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:40:20 -0500
Received: from main.gmane.org ([80.91.229.2]:55643 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbYL3VkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 16:40:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHmJw-0003Zz-80
	for git@vger.kernel.org; Tue, 30 Dec 2008 21:40:12 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 21:40:12 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 21:40:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104209>

Thnks for reviewing !

"Jeff Whiteside" <jeff.m.whiteside@gmail.com> wrote in message 
news:3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com...
>> commit -a detects that files have been deleted, and takes them out of the 
>> index !
>> could also have used $ git rm <specific files> and then $ git commit ..
>
> hey! i like your changes! the post is pretty polished now.  the only
> thing else i would change (srysry), is the above.  "-a detects that
> files have been deleted"  -> heh, not true.  you don't need -a here;
> it does something else.

** haven't had time to review this but from what you say it looks like I 
forgot to take this out

> okay i just recreated your repo and did the same thing.  with your
> syntax "git checkout versionA ." i got the same result, and i'm not
> sure why, but i think it was because of the detached head.

** at Yves' (demerphq) request I reproduced and posted the exact sequence of 
commands
this was from a reboot, going straight into git bash and running the warmup 
with NO git-resets at all

> good news, use "git checkout versionA", not "git checkout versionA ."
> (so, use it wihtout the dot), and you should be back in working order.

** yes but I don't get the files copied out into the tree which is all my 
little heart ever desired

> the other (good?)  news is that you probably _do_ want to be using git
> reset --hard in your case, because you're trying to build up a history
> from some project, so you do want to erase some faulty commits after
> you bodge something or miss some files.

** yes, now I know that git-reset is only for destruction, not navigation

> the bad news is that my opinion is that you should probably move on
> with your life, because my own past tells me that you'll never
> actually use those old project versions, hahah :p

** LOL, I have to admit I am enjoying this though, even if its driving me 
slightly potty - haha
I didn't write these early versions so I just wanna have them around to 
rollback to if I end up hacking the thing to bits.
But you're right - chances of using are slim - but you could say that about 
every version sitting in any given SCM repo.
Thats why we have SCM, and why we insure our cars etc etc. :-) 
