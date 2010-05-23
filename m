From: Lin Mac <mkl0301@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sun, 23 May 2010 17:12:28 +0800
Message-ID: <AANLkTim8NfxY75tpHIEx1LMatWQ5P-LgCaNSeNp2KFa3@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	 <4BF7B751.7050704@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun May 23 11:12:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Eb-0002gK-Ki
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0EWJMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:12:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab0EWJMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:12:30 -0400
Received: by pwi2 with SMTP id 2so114080pwi.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zHXegvvelYaBVRZfJpIim0hzWxue3t0VaoLL/UM81lA=;
        b=vA/7dO31TA4KjKZsKRN5k+W04pCXSIvkq011zHD2uuE8Q1yYPMKLDf30wyV2b9GxEv
         D5Eek0kiXboVIni6adface2tB3tDqPmlk3fQayfDu65xMn44BF8W/D2hqLMt4LA8wd/N
         aHUfyoNdvEfWTAm6S/Yfr9D7w3zP+6TB83fro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x4X2CcFV0RD7vCqZs61OpM6hG/5mYZT4zM3ILQXKwMOFKdSn9qj4SIpGCmzEJMGzTy
         yErUfmp/xoYfS3Y7lqkiJzag7EzYiBNTrULnEAFwepheA3WhyYOjd1JX2z7Jda3wMyOh
         OhXHPe+EImOzIaPEEC1g5mKQ/B6t2VK/VsK0s=
Received: by 10.141.89.17 with SMTP id r17mr2868247rvl.185.1274605948607; Sun, 
	23 May 2010 02:12:28 -0700 (PDT)
Received: by 10.140.134.6 with HTTP; Sun, 23 May 2010 02:12:28 -0700 (PDT)
In-Reply-To: <4BF7B751.7050704@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147558>

2010/5/22 Andrew Sayers <andrew-git@pileofstuff.org>:
> Hi Daniele,
>
> I'm a developer getting towards the end of introducing my company to Git.
>  Here are some thoughts based on the (mis)steps I took.

I'm a developer who had started to learn git for 1 and a half year,
and start using git for half year. It took me 1 year to make myself
believe that I am ready to use git as my daily working project.
Although I also wants to push my company to use git, but I prefer to
start from one. I "forced" one of my colleague to use git -- I only
use git to share code with him...

BWT, we use svn as well.

> I found that advocating specific steps wasn't that effective - I just came
> across as being pushy and hard to work with.  It was more effective to
> politely show off what I could do with git-svn, and let people get jealous
> enough to work the "how" out for themselves.  Here are some examples:
>
> I would quietly bisect a hard-to-fix bug, then say "if it's any help, git
> tells me it was introduced by so-and-so in revision N".  Sometimes it was no
> help, but sometimes it was enough to provoke the appropriate "aha!" for the
> bug.
>
> I would nonchalantly use as many git features as I could while showing
> people my work.  So "here's the diff for my work... grr whitespace ... hang
> on I'll add `-w`... anyway, these are the REAL differences...". The fact it
> was all in glorious technicolour went without mention.
>
> When we had a big merge that nobody was looking forward to, I said "let me
> do it!  It'll give me a chance to practice my git-fu".
>
> When I used svn on somebody else's command-line, I'd blame the mistakes I
> made on being spoiled by Git.  So "I'll just do an `svn log`... argh no!
>  Control-C!  Control-C!  Right, `svn log | less`... my bad, git pipes to
> less automatically."
My colleague shows amazing insterest on "git add -p".
"see? you could decided what to add to the commit and what no to. you
don't have to always clean the code before you commit...."
With git-svn, he started to use git since then.

> Over the course of a few months, people became convinced that Git was
> something that makes you more productive.  Our lead developer had a go with
> git-svn for a while, before our boss decided we should all make the switch.
>
> I tried to make git-svn as painless as possible with some svn-like aliases
> and a cheatsheet, which I'd be happy to upload if the list could suggest a
> good place to put a PDF and some text.
>
> The move worked for a while, but it turned out that one-and-a-half git
> experts supporting the rest of the team wasn't enough to stop people from
> making rookie mistakes like `git merge`ing into an SVN branch with unpushed
> changes.  We had to accelerate our move to git on the server, and I got a
> lot of exercise and not much work done that month as I dashed from desk to
> desk.
>
> Things gradually calmed down as people got more comfortable with git. But I
> expect to be occasionally called over for a long time as people learn new
> tricks - "how do I, like, cherry-unpick a single commit?"
That's what I'm affraid, so I started from one :p

Even though, I'm often called for questions like "how do I check out
this?" "how do I do 'svn revert')..., and I think it will last
forever.

Before I can really start to use git, I used to joke "git is for gods
like Linus, not for mortal". Of course I don't think so now, but what
I want to say is that git have harder learning curve than svn (at
least I think so). commands are sometimes confusing, and it is very
possible that users would screw thing up if they don't pay attention
when using it.

For example:

It take times to explain the difference of "git reset", "git reset
HEAD^" and "git reset --hard", and "git add <new_file>", "git add
<old_file>", and "git add -p" (why "git add -p" doesn't add my new
file/permission changes....blablabla).

And my first time trying git failed because I found all my previous
commit are "gone", "disappearred", "losted". You could imaging how
frustrated I am. Though latter I found that my commits are not gone,
but dangling!! I commited on no-branch state. But that stop me from
learning git for some time...

Recently, I used git branch "extensively" - I have a lot of branches,
branch have branches, such that one of which became a "tree". To
rebase the "tree" to another base takes 15~20 rebase. It is
error-prone, and I find nothing could release me from such situation.
I have to change my way to add branch.

Have someone experienced with git would greatly reduce the effort and
inconvenience.

Starting from git-svn would be a goot starting point. If people could
be benefit from git-svn, switching to git wouldn't be a big problem.

Best Regards,
Mac Lin
