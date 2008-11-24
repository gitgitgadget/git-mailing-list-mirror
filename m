From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hello All and Seeking Information
Date: Mon, 24 Nov 2008 10:22:03 -0800 (PST)
Message-ID: <m3wsetj87v.fsf@localhost.localdomain>
References: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 19:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4g5s-00071q-Q8
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 19:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYKXSWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 13:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYKXSWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 13:22:09 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:17887 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYKXSWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 13:22:07 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1399736tic.23
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=rK5Fl/4mCRCyp3pkDd++t1sylnvT/ly5u21Z7+oAKIg=;
        b=jJDxr6BOwyNoJzrp/V0gyTwzoDz7vrIb/7WU2ol9gaLkvaF4FJvmtUMbOcscp1Nbhj
         16kpeVGbDRoY5FcBU1ZwBuRvJftNgCVm1kauzNi/ta0XpLkWFPbSVJcsknGbyHflMqZY
         +BzZ6gTjROLob0mWQfQUJFSthDSlS+smPe0mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=xC5fT1mM0XbxS8oufSfKh6s2M4TdHL06xwi+4nvWs4xqWDmgu4JvZOOGHxhDsHx5dA
         KSYD6NSU6GNZNkdmLhTXtPWUWJG52bvsvZ7siEKSTR1LIeNOD+UUNO76NCadMSawMnoy
         5EHnJqkw0wcG6Pog1IzYHXR7Qt6yNKanpa7iQ=
Received: by 10.110.42.17 with SMTP id p17mr1789077tip.24.1227550925447;
        Mon, 24 Nov 2008 10:22:05 -0800 (PST)
Received: from localhost.localdomain (abxd219.neoplus.adsl.tpnet.pl [83.8.253.219])
        by mx.google.com with ESMTPS id w5sm1448603tib.14.2008.11.24.10.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Nov 2008 10:22:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAOILZIm021514;
	Mon, 24 Nov 2008 19:21:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAOILOgo021510;
	Mon, 24 Nov 2008 19:21:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101620>

"Tim Visher" <tim.visher@gmail.com> writes:

> Hello Everyone,
> 
> I'm new to the list so I figured I'd introduce myself instead of just
> wall-flowering... "Hello"... :)
> 
> Anyway, I really like a lot of the concepts found in Git and the
> reported power and flexibility of it are very intriguing.  However,
> there are some issues that I can't wrap my head around, such as how
> you can guarantee that all developers are working on the same
> code-base without a central repo.  I would classify a lot of my issues
> as paradigm rather than technically related. I understand a lot of
> Git's underpinnings and the basic usage of it, I just can't wrap my
> head around the higher-order parts of it.

The idea behind Git repository format is content adressed filesystem,
which if I remember correctly was taken from Monotone (well, not
addressed by actual content, but SHA-1 cryptographic hash of
content+type). So if there is 134b8687c59e65ce06562ffb0e8be63ab7aa618b
object in some repository, it is the same object in all repositories,
even if it was created independently. That is one thing.

The other thing is that typical workflow calls for downloading changes
(fetching in git jargon) from some 'upstream' repository, the official
repository (one of official repositories) with code you are supposed
to base your changes upon.

Also easy to create branches, and very good support for merging (and
rebasing) makes it possible and easy to join (merge) lines of
development done independently from some older point of history. So
that even if you are not working on the same code-base I can
incorporate your changes, and you can incorporate mine.

> 
> I've done some Googling and I can't find a good 'Introduction to
> Distributed SCM Concepts for Centralized SCM Developers' article yet.
> Ideally, this would be an article all about the high-level thought
> processes that go into utilizing Distributed SCM in a team environment
> where having a single canonical representation of your project that
> all developers are working off of is important.

See http://git.or.cz/gitwiki/GitDocumentation (and also main page of
this git wiki, Documentation mentioned on git homepage
(http://git.or.cz) including "Git User's Manual", and "The Git
Community Book" at http://book.git-scm.com

> P.S. Anyone want to tell me why the Git Mailing List was set-up
> monolithically rather than the typical git-dev, git-user, git-admin,
> git-x etc.?  I don't plan on hacking on Git so having the Dev mail in
> the list is just noise for me.  I'm sure other people think that too.
> Just wondering.

Because this Git is not so large project, and traffic on git mailing
list is not so large to support split? IIRC there was "Git for Human
Beings" aka git-users Google Group, but it doesn't seem to be there
any more.  Also having common mailing list allow for better contact
between developers and git users (which hopefully would allow us to
avoid comon pitfalls with 'developers for developers' approach).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
