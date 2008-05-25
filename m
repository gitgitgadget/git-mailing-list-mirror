From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sun, 25 May 2008 13:35:35 +0200
Message-ID: <200805251335.36530.jnareb@gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <200805242247.07565.jnareb@gmail.com> <5d46db230805241450w71b0c587o4767becc0058ee0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sun May 25 13:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0EWo-0005qW-6G
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 13:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYEYLft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 07:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbYEYLft
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 07:35:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:59109 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbYEYLfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 07:35:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so698272nfc.21
        for <git@vger.kernel.org>; Sun, 25 May 2008 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=xriDqKYj92lRFQ427ufbi6SOkZ4K9ByxrPnIb3v7zlY=;
        b=L295yBEk3JG+8QZS0mDI+moRP8vlzpDl9fSCva3KMOckXQydqklRcl1Ou5sME+QEA5/rAObFmwed3mCKCwAuFo0CGg2GImg6PbglFF+Y/xShWGnSK/FndLBxq9wPN6eWZyUUIMrRZos1KCcVWhrAAq4PVweh5SJY6FJY/AF3lmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LSCn6JaekaeFfcY6jBmY+1X2FTOg807oBp7ipXsB+6mADtPhNSyM7tsmizpm99RZNessRGOiXd/vOTGbWleSpgfa8LC7W5UxOuxUNLiG7703qN1ddR7rkofcWpJIbibtPdL+Vn+VGSJJSLNoBjoW5fI5zJ3bK7c6GGP2ho3KfBo=
Received: by 10.210.13.17 with SMTP id 17mr2926869ebm.1.1211715346478;
        Sun, 25 May 2008 04:35:46 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.235.25])
        by mx.google.com with ESMTPS id c5sm52985663nfi.6.2008.05.25.04.35.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 May 2008 04:35:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <5d46db230805241450w71b0c587o4767becc0058ee0a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82860>

Dnia sobota 24. maja 2008 23:50, Govind Salinas napisa=B3:
> On Sat, May 24, 2008 at 3:47 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Sat, 24 May 2008, Dmitry Potapov wrote:
>>> On Sat, May 24, 2008 at 12:16:17AM -0500, Govind Salinas wrote:
>>>> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com>=
 wrote:
>>>>> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>>>>
>>>>>> 1) Reduce the number of commands.
[...]
>>>>
>>>> Sure, removing commands is not about removing features, its about
>>>> reducing the learning curve and reducing confusion.

IMHO pushing too much into single commands do not reduce confusion
but increases it.

[Searching for a good example...] For example 'mv' could be modified
to include functionality of 'rm' in the form of 'mv file-to-delete',
but nobody sane would think of doing it.  Another example: you can
use 'less' to view contents of directory, but you usually use 'ls'
to do that; and nobody sane would think of extending 'less' to accept
all 'ls' switches, to have all 'ls' functionality.



I also think that having 30+ commands does not steep learning curve
make.  For example GNU coreutils only consist of 90 commands, but base
CLI is not that hard to use.

>>> I don't see how hiding creating branch functionality behind some ot=
her
>>> command will help with learning curve or reduce confusion. If I sta=
rted
>>> to use any new SCM and had to create a new branch, I would look for=
 the
>>> "branch" command. If there is something wrong with the git-branch t=
hen
>>> it is that this command does not checkout the newly created branch =
by
>>> default. So, I usually create branches using git-checkout, which is
>>> counterintuitive.
>=20
> If you will allow me to respond to both items in this mail...
>=20
> In bzr both clone and branch are in the 'branch' command because ever=
y
> branch is its own clone.  Hg defaults to a similar way of doing thing=
s and
> You clone into a new directory to get a new branch.
>=20
> From the bzr user reference:
>=20
> Branch:
> ...
>=20
>   Aliases:
>      get, clone
> ...

Do not cater to least common denominator, please.=20

> In truth, the git notion of a branch is pretty unique among SMCs.  In=
 old
> systems a branch was just a copy of a set of files at a certain point=
=2E  In
> other DSCMs it is more likely to be a new copy of the repo.

I think git notion of branch is clean, and clearly superior to the crap
othe SCMs use ;-P.  I'd like to remind you that multiple branches in
single repository were something added at user request, at least
according to Junio's FLOSS weekly #19 follow-up in his blog
  http://gitster.livejournal.com/9970.html

> To answer your question a little better, I am looking at it like this=
:
> The predominant action is, as you say, going to be "I want to create =
a
> branch so that I can start working on something."  While I respect th=
at
> you might want to create a branch and not start doing something
> *right away*, I think this is less likely.  So...
>=20
> pyt co
>   this lists stuff you can checkout by which we mean local branches.

Note that "git checkout" defaults to HEAD.

> pyt co -r
>   this lists remote stuff you can check out, such as remote tracking
>   branches and the remotes themselves.
>=20
> pyt co -a
>   lists both of the above, maybe tags too.

These three are all about listing metadata, refs to be more exact.
'checkout' is IMHO all about getting given state recorded in repository
(or, in git case, also from index) into working area, i.e. in a way
opposite to 'commit' or 'checkin', at least as far as it is possible.
So I think this is in the same league as using 'less' to view contents
(listing) of a directory.  This IMHO does not reduce confusion, but
adds to it.

Also note that git-branch is used to create and list branches
(unfortunately it uses -l for --enable-reflog and not for --list as
other commands like git-tag do), but can be also used to delete and
rename branches.  Do you want to stuff this functionality in "pyt co"?

> pyt co <branch>
>   checkout the branch, looking at refs

It is the default.

> pyr co <uri> <remote-name> <branch>
>    the user wants to checkout something that isn't local.  So we do
>    a git remote add -t <branch> -f <remote-name> <uri> followed by
>    checkout <remote-name>/<branch>
>    There would probably be variations/flags to get different function=
ality.

Please note that result of this is very, very different from ordinary
checkout.  Either it doesn't touch working area if it is equivalent
of git-fetch, or can result in conflicts and not a clean state if
it is equivalent of git-pull.

> pyt co -n mynewbranch [start=3DHEAD]
>   creates and checks out a new branch.

Simply different name for option, I think.

> pyt co [something=3DHEAD] [--] <files>...
>   should be obvious

But it isn't obvious. =20

Let me explain.  Because in git commits are always whole-tree
snapshots, and usually (read: almost always) it makes sense to have
whole-tree commits in an SCM, this cannot switch branches.  So for
example there is a question if it is a separate mode (yet another
oveloading of 'pyt co' operator) of checkout changing working area
without changing current branch (something like svn-revert,
or hg-undo), or would it make HEAD detached and result in something
like not yet implemented "git cherry-pick <rev> -- <files>".

> The following are a little less intuitive, because they don't actuall=
y
> result in new stuff being put in the working directory.  These things=
 are
> not really a checkout activity, I will stipulate that.  However, I do=
n't think
> we need one interface to do stuff with branches and remotes, one to
> manage branches and one to mange remotes.  And I think that users
> will be able to grasp this pretty quickly.
>=20
> pyt co --create-only mynewbranch
>   just creates without switching, it is a long option because this is=
 not
>   a normal function and the user needs to understand what they are
>   doing.

This is not 'checkout', mind you.

> pyt co -d [-f] <branch-name> | <uri> | <remote>
>   delete a branch or stop tracking a remote.

Oh, so you do plan to stuff at least deleting branches and remotes
in 'pyt co'?

What was the UNIX motto: do one thing, and do it well?


>>> I don't think any commonly used SCM unites 'clone', 'branch', and
>>> 'checkout' functionality under the same name. This approach seems
>>> to be more confusing than helpful.
[...]
> See above, they in fact do.  It struck me as odd too, because I had
> started with git.  After thinking about it for a while, I saw advanta=
ges
> to it.

And it looks like you gone to far in the reducing number of commands
direction and do not see disadvantages of heavily overloaded, DWIM-ming=
,
doing multiple different things depending on options commands.  If you
don't like large number of commands (is 30+ large number?), use GUI!


What you need is to have some _users_ to tell you if you do with
Pyrite in good direction.  Or at least analysis of common git workflows
and how they could be improved...

--=20
Jakub Narebski
Poland
