From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Wed, 4 Mar 2009 17:06:06 -0500
Message-ID: <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <20090227171248.GB14187@raven.wolf.lan>
	 <49A826C8.1060300@drmicha.warpmail.net>
	 <20090227220512.GC14187@raven.wolf.lan>
	 <49A97B7A.8010005@drmicha.warpmail.net>
	 <20090303185108.GA11278@raven.wolf.lan>
	 <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
	 <20090303223600.GB11278@raven.wolf.lan>
	 <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
	 <20090304192752.GC11278@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 23:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LezFd-0000XG-MU
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 23:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbZCDWGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbZCDWGM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 17:06:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:34982 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZCDWGK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 17:06:10 -0500
Received: by gxk22 with SMTP id 22so6926355gxk.13
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=5h8VNCzYTM+tsbbGKYYM9oic3PiuYpCmzBdabVXBAuI=;
        b=lkzwb9mhS17qWbc8kqYN5NFzyx6ZWPZTR0gkLP8lRkU4NrZhSr9+UQtPw5qeVw3eue
         ami88RW1BRFNo2OlIqs8fdMAD2DOIojHeFesr2RRizHUm39lQLt4Zb7ukqeBKNV7jpTs
         FdAaPSTYBYRrnMB+ylig76T/vqMBbtMEwfnDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=E96WosW5W7FcEtwIINmrgt+wuqn8YzzS/YzBJ+37GQNXQ2d/elU1BZVHJabjYPaLQa
         v+zNXnMgsz/0fcrhNZN3O+nimHpBnQuVZm/oYKCVDsAE+aeRpfDQ20PuAAQDmV9qMjfU
         xa3LX0IES2X3SD4/WCaG/cN4Qrl5J0uPULVUM=
Received: by 10.220.76.132 with SMTP id c4mr167382vck.94.1236204367505; Wed, 
	04 Mar 2009 14:06:07 -0800 (PST)
In-Reply-To: <20090304192752.GC11278@raven.wolf.lan>
X-Google-Sender-Auth: 94788732f65562db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112242>

On Wed, Mar 4, 2009 at 2:27 PM, Josef Wolf wrote:
> On Tue, Mar 03, 2009 at 07:18:04PM -0500, Peter Harris wrote:
>>
>> Sounds like subversion isn't properly caching your credentials, or
>> your admin is paranoid and turned off the svn credential cache. I
>> can't remember the last time I had to enter a password.
>
> What credential cache are you talking about? =A0I don't know of any
> worth to be mentioned. =A0If you talk about "store-passwords=3Dyes" i=
n
> subversion's config

Yes, that's the one.

> you might be interested to read
> http://curl.haxx.se/docs/adv_20090303.html

Not really, since I use svn:// :-)

> BTW: The paranoid admin is myself. =A0 ;-)
> BTW1: I know there's the possibility of client certificates. =A0But A=
=46AIK,
> =A0 =A0 =A0there's no equivalent to ssh-agent, so it's pointless.

I thought that this was already a part of svn, but it appears in the
1.6 (not quite final yet) release notes: "SSL client certificate
passphrases can be stored in KWallet, GNOME Keyring, Mac OS Keychain,
a Windows CryptoAPI encrypted form or in plaintext form."

> Within svn, the author field seems to be correct (at least, it is
> identical to those of the commits that were done directly to svn)
> But when the commits come back to git, it is set to
> "jw <jw@041dc122-08ea-11de-a769-bddc3e64b585>" with the host-part bei=
ng
> the uuid of the svn-repo.
>
> Any ideas how to fix that?

"git help svn" and look for "--authors-file", maybe. I don't use it
myself, so I'm afraid I can't help with that one. Personally, I don't
mind user@uuid. Plus, user@uuid is so obviously different from git's
standard format that it is immediately obvious to me which commits are
in svn, and which aren't, when running gitk.

> Oh, and what happens if svn's rev-properties (commit log, author, dat=
e...)
> are changed?

Too late. git svn will ignore the change to the history, since git
forces you to rewrite your entire history if any part changes. Cue
standard "log messages should [not] be mutable" flamewar.

Ah, here it is... <flamebait version>: Nothing happens. git will
correctly store your *true* log/author/date, ignoring any and all
attempts by malicious parties to destroy useful historical
information.

Of course, you're a paranoid admin, so you already have a
pre-revprop-change hook in your svn server that prevents
log/author/date changes. Right? ;-)

> In contrast, working directly against an svn repository is _very_
> tedious.

Tell me about it. Fortunately, we have git-svn to save us from the
default svn client. ;-)
(Sorry, couldn't resist pulling that one out of context)

> =A0With a dozen commits pending, you have to enter your password
> about 30..50 times in "git svn dcommit".

Maybe svn 1.6 will fix that for you?

>> I think he meant to say "git pull ../cloneN && git rebase trunk".
>
> Did you mean "git pull ../cloneN && git rebase master"? =A0There's no
> trunk in git, AFAIK?

If a local branch isn't found, git will automatically look in remotes,
so it will use remotes/trunk (the svn tracking branch). Modify to suit
if you renamed remotes/trunk, of course.

"git branch -r" to see the remote branches git-svn has set up for you.

I'm pretty sure I didn't mean to suggest a no-op. Assuming you git
pull'd into master, "git rebase master" will be a no-op. rebase "all
commits in (current branch) that aren't in master" -> set operation
(master - master =3D empty set) -> rebase (empty set) -> done.

> =A0# 2. move commits from clone to subversion
> =A0#
> =A0cd git-svn-repos
> =A0git svn rebase
> =A0git pull ../clone$clone topic-branch =A0 # need rebase?

Yeah, a "git svn rebase -l" after this line wouldn't hurt, and is
suggested by "git help svn". Or even reverse those two lines, to save
adding a third:
  git pull ../clone$clone topic-branch
  git svn rebase

Alternatively, you can avoid potential pull conflicts by using a
temporary branch to avoid the merge you are about to throw away with
rebase -- remember that 'pull' is short for 'fetch && merge':

git fetch ../clone$clone topic-branch:scratch
git checkout scratch
git rebase trunk
git svn dcommit
git checkout master
git svn rebase -l # fast-forward master to where scratch is
git branch -d scratch

=2E..which should result in seeing only the rebase conflict(s). And
ought to work if cloneN's topic-branch is on a different svn branch
from master (although you'd need to -D scratch instead of -d).

Peter Harris
