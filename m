From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-mkpatch use case
Date: Tue, 2 May 2006 23:57:03 +0200
Message-ID: <20060502215703.GK27689@pasky.or.cz>
References: <44570E8E.5070402@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 23:56:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2qr-0000GB-9g
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWEBV4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEBV4H
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:56:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19603 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965011AbWEBV4G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 17:56:06 -0400
Received: (qmail 8200 invoked by uid 2001); 2 May 2006 23:57:03 +0200
To: Belmar-Letelier <luis@itaapy.com>
Content-Disposition: inline
In-Reply-To: <44570E8E.5070402@itaapy.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19432>

  Hi,

Dear diary, on Tue, May 02, 2006 at 09:47:26AM CEST, I got a letter
where Belmar-Letelier <luis@itaapy.com> said that...
> I have 3 questions about cg-mkpatch
> 
> 1. I've receive a file "xxx.patch", this content came from
>   cg-mkpatch, but I can't apply it.
>   For example if I try git-am I get::
> 
>     $ git-am --signoff xxx.patch
>     Patch does not have a valid e-mail address.
> 
>   What is the Cogito way to apply the result of "cg-mkpatch"

  cg-mkpatch is a very old tool which has been long neglected and
not many people actually use it nowadays, I believe. You can apply it
back using cg-patch (or even patch itself, or git-apply if you are
lucky), but it won't automagically extract the commit message and
authorship information.

> 2. What are the difference between usecases with "cg-mkpatch"
>   and "git-format-patch" ?

  git-format-patch outputs stuff in the mailbox format while cg-mkpatch
outputs it in a more "human readable" (well, but quite historical)
format, but really, you probably want to use git-format-patch in almost
every case. In the (probably relatively near) future, cg-mkpatch might
become merely a git-format-patch wrapper.

> 3. It seem that if a commit as a binary file they are no way to manage
>   it by email patches. Any plan about this in Cogito ?

  Not any clear plans. I will welcome patches but it is not high
priority for me currently.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
