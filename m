X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 13:01:07 +0100
Organization: At home
Message-ID: <ei2563$m1u$1@sea.gmane.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org> <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org> <m3fyd77gsn.fsf@iny.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 29 Oct 2006 12:05:38 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Original-Lines: 160
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30428>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge9Pr-0007rF-HH for gcvg-git@gmane.org; Sun, 29 Oct
 2006 13:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932292AbWJ2MFJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWJ2MFI
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 07:05:08 -0500
Received: from main.gmane.org ([80.91.229.2]:16570 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932295AbWJ2MFG (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 07:05:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Ge9PS-0007m7-KL for git@vger.kernel.org; Sun, 29 Oct 2006 13:05:02 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 13:05:02 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 29 Oct 2006
 13:05:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Ilpo Nyyss=F6nen wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Ilpo Nyyss=F6nen wrote:
>>
>>> Usability:
>>>=20
>>> I have used bzr, bk for development and git very little for followi=
ng
>>> kernel development. I have followed this discussion quite well.
>>>=20
>>> 1. It is easier to start using something you are already familiar
>>> with. (Just try to use Mac OS X with a Windows or Linux background.=
)
>>>=20
>>> G: Something totally new and so no points from here. The way of usi=
ng
>>> git is just so different from any other similar software.
>>>=20
>>> B: Quite clearly gets points from this. Normal branches work quite
>>> like many other software, the checkout stuff works like CVS and SVN=
=2E
>>
>> I find for example concept of branches in Git extremly easy to
>> understand.
>=20
> Might be, but the point was: Git is harder as it is not like others.=20
> In other hand one can see Bazaar like other distributed SCMs and even
> like the not distributed ones as it has the checkout stuff.
>=20
> You can give Bazaar for me, a bk user, and I can understand what to d=
o
> with the branches that are like bk clones. (The repository stuff is
> later development and still optional.) Switching a CVS environment to
> Bazaar one can be done so that most of the users can be just told to
> use bzr checkout and they don't have to care about pushing.

That is of course because you are familiar with branch-centric distribu=
ted
SCM, namely BitKeeper, when trying Bazaar-NG. IMHO branch-centric view
is somewhat limiting; you can always use repository-centric SCM with
one-live-branch-per-repository paradigm and emulate branch-centric SCM,
which is not (or not always) the case for branch-centric SCM. Branch-ce=
ntric
and repo-centric SCM promote different workflows, namely parallel uncom=
mited
work on few development branches for branch-centric SCM, one-change
per-commit multiple temporary and feature branches for repo-centric SCM=
=2E

Breaking from CVS update-then-commit stupid model is IMHO very, very go=
od
idea. On the par of breaking from CVS "model" of branches. In my opinio=
n
CVS had one very good idea (perhaps it wasn't originally CVS idea), nam=
ely
using merge instead of locking files for editing; well that and the fac=
t
that it tried (emphasisis on tried) to treat module as a whole, allowin=
g
for multi-file change commits.

Take for example the case of WordProcessors: if they all would only emu=
late
the UI of leading one (most commonly used), no progress would be made.

> But with git, I clone some repository. Now it is totally new to
> understand that I didn't clone only single branch. It's like nothing
> else and that's what I saw when I first looked at it. I might have
> even not noticed the branch stuff and just cloned it further.

That's the shift of paradigm. Instead of one-branch-per-repository, and
one-branch-per-developer workflow which I think usually stems from that=
, we
have one-repository-per-developer (usually), and heavily nonlinear
development.

>> On the other side breaking with traditional concepts of _centralized=
_ SCM
>> in _distributed_ SCM (and geared towards distributed usage) is IMVHO=
 a
>> good idea. And breaking with the cruft of bad ideas of CVS is very g=
ood
>> idea.=20
>=20
> Breaking concepts can be a good idea and I somewhat think that git
> needed to do what it did. But do remember that it came with a cost:
> git is harder to understand and use. You first have to understand tha=
t
> it is different and how it is different.

The same could be said about moving from MS-DOS or later MS Windows to =
the
world of UNIX.

But yes, I understand and agree that being different than others can be
disadvantage... and can be advantage.

>> I don't understand the confusion between "git branch" and "git clone=
"
>> commands... unless you are confused by Bazaar-NG branch-centric appr=
oach
>> which mixes branch with repository.
>=20
> Those commands do so different things in different SCMs. Just look at
> the differences bk clone, git clone, git branch and bzr branch. You
> have both. At the point where I didn't yet understand that I cloned
> more than a one branch, git branch is very odd looking command.

I for example didn't understand "bzr branch" concept, being familiar ra=
ther
with "git branch".

>> Which long lasting operations lack progress bar/progress reporting?
>> "git clone" and "git fetch"/"git pull" both have progress report
>=20
> First note that I didn't notice git repack until recently so things
> got slower until that.
>=20
> At least some points they just tell that they are doing something, bu=
t
> not how much of it has been done and how much is still to do. Look at
> Bazaar and you'll see the difference, it has progress bars.

Well, having progress bars for operations which are usually fast and on=
e
step is in my opinion stupid idea. Even if there are combinations of
options which makes them slow (for example using so called pickaxe,=20
e.g. "git log -S'fragment' -- file" to find revisions which introduced
'fragment' to 'file').

I'll ask again: _which_ git commands you find lacking progress reportin=
g?

>>> You can't just diff branchA/foo branchB/foo.
>>
>> You can: either using "git diff branchA branchB -- foo" which means
>=20
> Exactly my point: it forces you to use git more. In Bazaar I can do
> this without Bazaar commands. I could even do it with some Windows GU=
I
> stuff, take two files or directories and compare.
>=20
> As you need to use git commands more than bzr commands, git has bigge=
r
> requirements for usability.

But git commands are more powerfull than equivalent GNU commands. git-d=
iff
is more powerfull than GNU diff (for example it can detect renames and
copying, it shows mode changes, it can show diff for merge using "combi=
ned
diff" format), git-grep is more powerfull than GNU grep (for example Li=
nus
finds himself to put files in git repository to use git-grep instead of
combination of GNU find and GNU grep).
=20
And don't forget about _cost_ of doing that abovementioned way, namely
having to keep two copies of working area (differing in revision, of
course).

>>> You can't just open file from old branch to check=20
>>> something while you are developing in some new branch.
>>
>> You can view file from old branch via "git cat-file -p old-branch:fi=
le".

Or you can "git commit -a -m 'TEMP'" to save changes, "git checkout
<branch>" to switch to other branch, perhaps git-clean, hack; hack; hac=
k;
commit changes, swotch back to branch, and wiether amend the commit or =
reset
index and HEAD (but not working area).

> Same thing here, in Bazaar, I can just open the file from the other
> branch. I can also compile and run the other branch while I have the
> other open.

Do you really often compile and run other branch while developing on ot=
her?

> Essentially I would need a separate git repository for each branch
> anyway. In Bazaar I can use the same.

Well, that's a fact that git lacks somewhat (but not lack completly) su=
pport
for multiple independent workplaces for the same repository (link+separ=
ate
index+separate HEAD), and lacks somewhat (but not completely) support f=
or
sharing object database between repositories aka. bzr model (you have t=
o be
very careful with pruning).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

