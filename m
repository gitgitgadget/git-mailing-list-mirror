From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 5 Jan 2007 16:16:57 -0800 (PST)
Message-ID: <224619.92262.qm@web31810.mail.mud.yahoo.com>
References: <7vzm8xcbcp.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zF6-0002zl-Vm
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXAFAQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXAFAQ6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:16:58 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:47160 "HELO
	web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751001AbXAFAQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 19:16:58 -0500
Received: (qmail 92834 invoked by uid 60001); 6 Jan 2007 00:16:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=L7u0t3oV8pCUevOuWNcyf7rxf1Xy9AokMdxdfFKUuT4fphBL3iL686i4Q3dwMrBhsm4Zac4TNXLTRFdzYbKc4FvMrjJLiW0jGLwRH8edc4UfU77ZZkeqr5cxUsQ7rnGdvTYKMj/FRtWOIWWxQ3exHIK7K5C0aCym/D6Hk0B6kHY=;
X-YMail-OSG: dTFfK8oVM1kMtSk3QP0GVC8IC_VzaE2W6pDAKRLMfh6e6uYuD98LzDn46KNAx9P3WMMYM2.cYj4r0PsN2cVQ88hBme68fngQ1z3gOp6gNYmhbZhxieqvJW2ht5Et3mXJkI7bZ0dwnh8cYFqclK3kE_SpwLk6Jx20wTHI8ONi3P5ZnmUIcEszef30
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 16:16:57 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm8xcbcp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36057>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > I can see that the remote heads are where they are supposed to be
> > but no local tracking heads are created (by default).  I had
> > to do this manually.
> >
> > Old behavior was that git did that for you automatically.
> > So I suppose this is another newbie protection.
> 
> A very fuzzily stated question which is hard to answer, but I do
> not think it is another newbie protection, if it apparently is
> actively hurting you.  Also the documentation may need to be
> updated to teach you enough about how to achieve what you want.
> 
> You can see where remote heads are by doing what?  ls-remote?
> "Old behaviour" for what configuration?
> 
> A fresh clone made with a recent version sets things up to track
> all remote branches from the repository you cloned from under
> remotes/origin/, and it even tracks new ones as they are added
> at the remote, so you probably are doing something different
> from the default configuration that has:
> 
>     remotes.origin.fetch = +refs/heads/*:refs/remotes/origin/*

That's exactly what I have, but "git branch" shows only "master".
The other branches are indeed in refs/remotes/origin/ but I want
them in refs/heads/ so I had to do that manually by creating
the head and add this into .git/config.

Old behavior was more _convenient_.

    Luben
