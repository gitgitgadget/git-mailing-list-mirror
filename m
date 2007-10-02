From: Steven Grimm <koreth@midwinter.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 01 Oct 2007 23:41:15 -0700
Message-ID: <4701E80B.3030007@midwinter.com>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 08:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcbRf-0008Dx-KG
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXJBGlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXJBGlS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:41:18 -0400
Received: from tater.midwinter.com ([216.32.86.90]:34971 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbXJBGlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:41:17 -0400
Received: (qmail 16652 invoked from network); 2 Oct 2007 06:41:16 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=udAzopZdcFbFE75NkM6/ZQgSUJ5nn4zhJgM0Y5UA8y70P5+h+yM0Kh39rf80GvOR  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 2 Oct 2007 06:41:16 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59666>

Junio C Hamano wrote:
> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>  + rebase: allow starting from a dirty tree.
>  + stash: implement "stash create"
>
> Instead of refusing to rebase, telling you that your work tree
> is dirty, this stashes your local changes, runs rebase and then
> unstashes automatically.  That _sounds_ nicer and easier to use,
> but I am not sure if it is a wise/sane thing to do.  We may want
> to revert the "autostash" from rebase.  Opinions?
>   

I can say that for people coming from svn (who are often using "git svn 
rebase" rather than directly running "git rebase") this is a nice 
workflow improvement. It eliminates one more "Why is this more of a pain 
to do in git than in svn?" complaint.

I don't see any circumstance in my use of git -- either in a git-svn 
context or not -- where this wouldn't be an improvement over the 
existing behavior. However, I don't claim to be using git in any 
particularly interesting way, so I suppose it's possible that this will 
break someone's workflow horribly.

-Steve
