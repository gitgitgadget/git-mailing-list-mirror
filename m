From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Mon, 24 May 2010 19:37:14 +0200
Message-ID: <AANLkTilhVbdaZgE4NINrl4RA6ArkeMstyFdnq9eD4o8B@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	 <4BF7B751.7050704@pileofstuff.org> <1274543552.21346.166.camel@Luffy>
	 <4BF94138.5000007@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon May 24 19:37:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGbae-0005ij-BO
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 19:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab0EXRhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 13:37:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41307 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab0EXRhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 13:37:16 -0400
Received: by gwaa20 with SMTP id a20so1600537gwa.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fBq+u1MORkETbgGdObo7k3JtnbsmRwegAw6gKCIcP+Y=;
        b=E4Q5z648YFfGqdjPQBqBQttUzcTNbiFfSKBr//BpdMyxv5J9632bsiyYt/rBHnW2bp
         HDzlBpbwjspmswzgU8aGfTVDJJ7TKc2vfnMBC1+YKI/QTp7bxq0Jz9WOWxmO2L5E7fFh
         OfeN2vPQFm5Pm2Ok5EdmlYt0ibVargk84Epfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MagUgoikLXXx4+21Z1vVDiODhkxpFDmfQtOpynq/EruxAFGRf7drPL5deyVtQgB9FG
         qnZ3UmmRqALnIrWi2540lSmlTxapKP1iaYMqdf4ozTE+33Q5mYYEZFJSK2lceH9LXyCQ
         Blhk+xbtcIrqQXFHxnAcIOGxLvMH4sbQXA58o=
Received: by 10.101.106.33 with SMTP id i33mr6844285anm.161.1274722635350; 
	Mon, 24 May 2010 10:37:15 -0700 (PDT)
Received: by 10.100.34.5 with HTTP; Mon, 24 May 2010 10:37:14 -0700 (PDT)
In-Reply-To: <4BF94138.5000007@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147639>

On Sun, May 23, 2010 at 4:52 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> I agree that a lead developer moving a team from graphical SVN is a
> different problem. =C2=A0I don't think git-gui does SVN, I couldn't w=
ork out
> how to make TortioseGit work with SVN, and I doubt EGit will like SVN
> very much.

EGit do not work with git-svn, it probably work just fine with "pure" g=
it tough.
I've seen TortoiseGit, it work very well but I found it somewhat more
difficult then the command line:
probably because I don't know where to find the command i daily use on =
git.
I extensively use git grep and probably there isn't anything like it
in TortoiseGit.

> You're also right that git-svn has limitations with merging and
> rebasing. =C2=A0Specifically, don't use them unless you know what you=
're
> doing - see `man git-svn` for more. =C2=A0Git-svn is also less
> newbie-friendly than either git or svn on its own.

Yes, that's why I'd like to skip git-svn and go directly with git,
unless I know the people I'm teaching to can
handle it.

> Having said that, I'd still recommend you try moving a few developers=
 to
> git during the lifetime of your current project. =C2=A0In my experien=
ce,
> those developers most willing to try something new in the middle of a
> project are also the ones that want to get hacking right away on a ne=
w
> project. =C2=A0Getting even one developer to start migrating now will=
 be good
> practice for you, and will double the number of eyeballs looking at g=
it
> issues later on.

Yeah, there is one developer tired of Subversion that asked me to
teach him git(-svn).
He's not in my team but I think it's a starting point :)

> Slowing down for less than a week is a very ambitious target - I thin=
k
> we had about 2 weeks of noticeably reduced productivity, even when I'=
d
> done a lot of work to spread the pain over several months. =C2=A0Star=
ting git
> with a new project might reduce that time a bit - for example, there'=
s
> no chance of uncommitted work in an SVN checkout failing to make the
> switch. =C2=A0But it can be more expensive in the long-run, because y=
ou have
> to make all of your architectural decisions based on what you can
> explain to SVN users on day one - for example, my team took about 2-3
> weeks to understand how a commit is different from a push, and why th=
ey
> should care. =C2=A0But because they understood before we made the big=
 leap,
> we were able decentralise our workflow as much as we needed.


Probably it will be a svn-like architecture from the beginning, I'll
not dare to move it any
further until I know that developers are ready to handle it properly :)
I'm not sure myself I can manage a workflow different from subversion
(1 main server and N developers
pushing to it) because I never did anything different.


> If you do go via git-svn, I'd recommend you read `man git-rerere` and
> set the config option "rerere.enabled" to "true" for all users. =C2=A0=
I
> needed to blow away a few messy merges to fix rookie mistakes, and
> `git-rerere` would have made a painful experience much easier.

I did not know about this.. That's really interesting, I just enabled
it in my local repo.
Thanks for the hint!

> Even if you go straight into git, you might think about finding/writi=
ng
> hooks to synchronise an SVN repository and a git repository. =C2=A0Th=
ere will
> probably be a few people you can't switch right away - e.g. a sysadmi=
n
> that would need months to rewrite all his scripts, or a designer that
> doesn't want to learn a different tool just for your team. =C2=A0Prov=
iding a
> semi-functional legacy interface for those people will let you raise =
the
> pressure on them more gradually.

Sysadmins shouldn't be a problem, we don't have sysadmins here and if
the custumer
require us to use his own versioning system we can't push them to git,
so I think that wouldn't be
a proble for us. But that's a good point.

> I forgot to mention education in my previous post, which was actually
> one of the biggest problems during the move. =C2=A0I was surprised ho=
w
> everyone had such different learning styles - some wanted to learn th=
e
> theory then be left alone, some wanted to be told each solution at th=
e
> moment they faced the problem, some wanted to learn by watching how I
> worked, etc. =C2=A0The only real pattern seems to be that the busier =
people
> are, the more they like to feel they're pulling information out of yo=
u,
> and the less receptive they are when you push information at them. =C2=
=A0I
> muddled through by trying to give everyone more of whatever they each
> reacted best to.

Thanks, I'll keep that in mind when I'll face the big switch.


> Because my team needed time to unlearn a lot of these SVN issues, I
> didn't try to push much deep git tech at them early on. =C2=A0A few m=
onths
> into the move though, it's starting to seem like a better idea. =C2=A0=
One of
> my team-mates got me to start reading "Version Control with Git"
> (http://oreilly.com/catalog/9780596520137) - from what I've seen so f=
ar,
> I'd definitely recommend it to people that like book-learning and are
> ready to learn git without bringing their old SVN baggage. =C2=A0On t=
he other
> hand, you can cobble the same information together from various onlin=
e
> sources if you prefer (http://book.git-scm.com/ is a personal favouri=
te).


Thanks about the book suggestion, I'll give them both a try!

Regards,
Daniele Segato
