From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 5 Jun 2011 13:10:56 +0200
Message-ID: <201106051311.00951.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Nahas <mike@nahas.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 13:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTBEp-0003c5-Ck
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 13:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735Ab1FELLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2011 07:11:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34917 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab1FELLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 07:11:16 -0400
Received: by fxm17 with SMTP id 17so1958029fxm.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cjOdZS3FKQCAxm2iJnYpjPpUhwt65/NtkSpd/hV5gWc=;
        b=RI1GHZLRuq+6o47Uyr56mRvgcAo4KI9/LHff0s2MBNE0NqOh6C4KyztcgNkhgpWBNb
         js8P4CRblY6LXTPfwX7sqMsmGLjlA13akGaiFlgvES8eABJvWO9pE8cA7tOxTSF1vDbq
         90KKj1VplmSgTkaFehcT+q/+8KLIHx0l++6KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hRN/aHitlZ5aN6Va0fq7iYl5zdtxhpnivq1TGpqQ+HndgRaXYG/iWygCVj8680paRl
         Z3CNbPWaqasISqAcjG5bgaYtbcg/+bm2QOjYOLFuST7BW1apan2nN/GXjPXW9+baq4wZ
         VbZuzJBMSr7CXz6IRThajRXGbnFv+lNynbBjo=
Received: by 10.223.77.92 with SMTP id f28mr4043939fak.37.1307272274165;
        Sun, 05 Jun 2011 04:11:14 -0700 (PDT)
Received: from [192.168.1.13] (abvi97.neoplus.adsl.tpnet.pl [83.8.206.97])
        by mx.google.com with ESMTPS id n15sm1001103fag.42.2011.06.05.04.11.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 04:11:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175073>

On Sun, 5 Jun 2011, Michael Nahas wrote:
> On Sat, Jun 4, 2011 at 5:49 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Michael Nahas <mike.nahas@gmail.com> writes:
>>
>>> Quick list of recommendations:
>>>
>>> 1. Pick aliases for the next commit and the working tree that act l=
ike
>>> =A0 =A0commits on the command-line.
>>
>> No go. =A0This was asked for many times, and each time shot down.
>> Those "aliases" / pseudo-refs looks like commits but do not behave
>> exactly like commits. =A0This would increase connfusion.
>=20
> I'm glad it was discussed.  I think users would know that those
> commits were special (they are writeable after all), but I'm sure mor=
e
> informed people than I made the same arguments.

Perhaps we should add conclusion / summary of this discussion either
somewhere on git wiki (http://git.wiki.kernel.org), or e.g. on gitcli(7=
)
manpage, so that it won't get reiterated again and again.  It is sort
of frequently asked question^W request.
=20
>> See also gitcli(7) manpage for description of --index and --cached
>> options (and other git command line conventions).
>=20
> Thanks for the pointer.  I've now read it.
[...]
>> BTW. have you read gitcli(7) manpage?
>=20
> I have now.  I'd swear I've read close to 30 manpages but never
> heard-of/noticed that one until you mentioned it.  Thanks for the
> pointer; it's good to have --index and --cached clarified.

Hmmm... gitcli(7) is linked only from git(1) and git-rev-parse(1)
manpages.  Perhaps link to it should be added to user-manual at
least, to make it easier to find?

>>> 2. Adopt a (semi-)formal notation for describing what commands do.
>>
>> Whom it would help? =A0Not an ordinary user.
>=20
> I think it would help experts in discussing exactly what happens.  Fo=
r
> ordinary users that are hitting an intricate case (or don't know
> English very well), it would be good if there was something that woul=
d
> tell them mathematically what occurs.

Well, semi-formal notation could help, but I am not sure if it would
really be easier to understand than textual description.

There is also kind of "meta" problem: people who do not understand
English well instead of not understanding textual description of git
behavior would now not understand explanation of said formal notation.

  Cargill's quandary: "any design problem can be solved by adding an
  additional level of indirection, except for too many levels of
  indirection."

;-)

>>> 3. Move the operations "checkout -- <file>" and "reset -- <file>" t=
o
>>> =A0 =A0their own command names
>>
>> Proposed "git unadd <pathspec>..." doesn't cover all features of
>> "git reset <rev> -- <path>" nor "git checkout [<rev>] -- <path>".
>=20
> I'm confused.  How can it not cover all the features?  I'm just
> suggesting renaming the command.  From "git reset -- <path>" to "git
> unadd [--] <path>".

What about (well, more rarely used) "git reset <commit> -- <path>"?
But I quite like "git unadd" alias, even if "git unadd <commit> <path>"
looks strange; we have precedent in the form of "git stage" command
(alias).

> (And renaming "git checkout -- <path>" to some=20
> yet-to-be-named other command.)

I think this one could be left as is, at least until a really good name
for said replacement appears ("git revert" means something else, and
"git revert-file" is a bit long, and can be confused with currently
not existing but proposed and discussed "git revert <revision> <pathspe=
c>".)
=20
>>> 4. Deemphasize the "branch" command for creating branches.
>>
>> Or add "git branch --checkout <newbranch>".
>=20
> Would that operation be the different from the existing "git checkout
> -b <new branch>", or just another way to write it?

No, it would be just another way to do it.


>>> My recommendations are:
>>>
>>> 1. Pick aliases for the next commit and the working tree that act l=
ike
>>> commits on the command-line.
[...]
>>> For the alias for the next commit and working tree, I suggest "NEXT=
"
>>> and "WTREE".=A0 Creating these aliases will make the interface more
>>> regular. It will remove oddities like "diff --cached FOO" and repla=
ce
>>> them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can b=
e
>>> explained as "diff WTREE NEXT" and "diff WTREE FOO".
>>
>> This idea ws proposed multiple time on git mailing list, and every
>> time it was rejected.
[...]
> That this idea has been brought up multiple times says that it does
> have some merit.  But apparently not enough merit.

No, this only means that people *think* it has merit.  And perhaps
that they are poisoned by Subversion's pseudo-refs ;-P=20
=20
>> BTW. both index and worktree have their own "aliases", namely ':0:'
>> for index (stage 0), and ':' or ':/' for top tree.
>=20
> Really?  Where can these aliases be used?

Well, actually they _currently_ cannot be used in many places.

You can view version of file as it is in the index with

  $ git show :0:path/to/file

You can add file from a top of project directory (given new enough git;
I think it isn't in any released git version yet) with

  $ git add :/path/to/file

independently on subdirectory you are in (i.e. --full-tree).


But the main point was meant to be that even if there was some merit
to the pseudo-tree-ish aliases, ':0:' or '::' or ':0' would be better
that NEXT / STAGE / INDEX that looks like symbolic refs and therefore
commits but ain't, and ':/' would be better that WORK / WTREE.

I'm sorry, I should have written it more clearly.
=20
>> Second, it doesn't solve issue of needing --cached and/or --index
>> swiches completely. =A0Those pseudo-almost-refs hide them for "git d=
iff",
>> "git grep", "git ls-files", perhaps "git submodule" where we *read*
>> from index, but not for "git apply", "git rm" or "git stash" where
>> those swicthes affect *writing*.
>=20
> I agree with you that it would not get rid of all switches.  I never
> expected it to.  My major aim was to simplify things like the "diff"
> command, which I have trouble remembering the different variations of=
=2E

You miss the point of this.  The issue is that you have to learn about
'--cached' and '--index' *anyway* (because pseudo-almost-refs do not
solve everything), and for consistency and backward compatibility we
need to support '--cached' for "git diff" etc., so you proposal brings
nothing but new thing to learn (and not only syntax, but quirks as well=
).

So you only add to required knowledgebase, not reduce it.

>>> 2. Adopt a notation for describing what commands do.
>>>
>>> I am sure in developer discussions there are descriptions of the
>>> "commit" command as something like:
>>> =A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
>>> =A0=A0 NEXT =3D HEAD
>>
>> Basic algebra fail
>>
>> =A0HEAD + (NEXT-HEAD) =3D=3D NEXT
>>
>> Besides "git commit" creates commit from state of index, no diffing =
or
>> patching is involved.
>=20
> I would claim that the "state of index" is an approximation of
> (NEXT-HEAD).  Also, the new Tree and Blob objects that get written
> during the commit are another approximation of (NEXT-HEAD).  Neither
> of these is exactly a patch applied to HEAD, but that's the intent I
> was going for with my algebraic identity.  (It's not a fail; it's an
> unoptimization!)

It's still fail.  Git is at its repository model _snapshot_ based, not
_changeset_ (delta) based.  "git commit" takes _exact_ state of index,
and does not care about HEAD version.  Nb. your case does not cover
creating root commit (including but not limited to initial commit).

If you want to describe what "git commit" does it would be:

  commit =3D new Commit
  commit^{tree} =3D :0:       # or NEXT
  commit^ =3D HEAD^{commit}   # i.e. HEAD, but be more explicit
  HEAD@ =3D commit            # or @{0}, i.e. branch pointed by HEAD
                            # or HEAD itself if it is detached (no bran=
ch)
=20
The above does not cover commit message, author and committer info,
and in some cases 'encoding' header (for commit message).

>>> Where "-" creates a patch between versions and + applies a patch.=A0=
 Git
>>> already has some operators like "^", which refers to the parent of =
a
>>> commit. Those are useful for defining things like "commit --amend":
>>> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
>>> =A0=A0 NEXT =3D HEAD
>>
>> Which is again not true.

Again, snapshot, not delta.
=20
> [Addressed below, where the "what if HEAD is a merge commit with
> multiple predecessors" is mentioned.]
>=20
>>> Having this notation and using it in the man pages will make the ex=
act
>>> nature of the operation clear. (Right now, it takes a lot of readin=
g
>>> to figure out what happens to NEXT with the various command-line
>>> options of "reset".)
>>
>> It's not that difficult: only "git reset --soft [<rev>]" doesn't
>> affect index.
>>
>> Hrmmm... how this notation would explain differences between
>> "git reset --hard", "git reset --keep" and "git reset --merge"?
>=20
> I don't understand what "git reset --keep" and "git reset --merge" do=
=2E
> I've read the manpage but am still confused.  One of my reasons for
> suggesting a notation is so that there is a clear mathematical
> representation of what the commands do.  Once I understand them, I ca=
n
> make an attempt at a notation that can explain them.

What I meant here is that above notation wouldn't help explaining the
differences between --hard, --keep and --merge.  Perhaps a table could
help there.

But IMVHO is more important for documentation to tell *when* one would
use one or another, not how they work.
=20
[...]
>>> [I've included git commands in a not-formal-enough notation at the =
end
>>> of this email.]
>>
>> NEVERTHELESS some kind of semi-formal notation might be useful.
>=20
> I'm glad you agree.  Do you think my not-formal-enough notation is a
> good start or do you want to propose another notation to start from?

Well, I am not sure if it is good enough idea to waste time on it...
Hmmm... maybe revctrl.org guys would be interested?  Just a thought.

>>> 3. Move the operations "checkout -- <file>" and "reset -- <file>" t=
o
>>> their own command names
>>>
>>> This is my biggest and most important suggestion.
>>>
>>> "checkout -- foo.txt" copies foo.txt from NEXT to WTREE. Similarly,
>>> "reset -- foo.txt" will copy foo.txt from HEAD to NEXT.
>>
>> =A0"checkout HEAD -- foo.txt" copies foo.txt from HEAD to NEXT and W=
TREE
>>
>> =A0"checkout HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT and=
 WTREE
>> =A0"reset HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT
>>
>>> These are operations to designate/undesignate files in the next com=
mit
>>> and should be grouped with others like them: "add", "rm" and "mv". =
(In
>>> fact, the man page for "reset -- <file>" even says that it is the
>>> opposite of "add"!)
[...]

>>>=A0For the other, my best suggestion is "head-to-next", but I'm sure
>>> someone can do better.
>>
>> I'd rather remember that "git checkout" is about checking out
>> something to a working area.
>=20
> Now that I've separated these two usages of "checkout" in my brain,
> "git checkout <branch>" is all about changing to a different branch.
> That files in the working tree change is just incidental to moving to
> the new branch.
>=20
> The manpage paragraph for "git checkout -- <file>" has in bold that
> this usage "does not switch branches".  So, for me, it's a completely
> different usage and should be a different command.

=46or me it is about "checking out" two different entities: a branch
(or related case of non-branch ref, e.g. "git checkout v1.7.3", or
"git checkout HEAD~2"), or a pathspec (file or directory).  Checking
out branch means making it current branch, checking out file means
making this version of a file current.
=20
> I wish I had a reasonable name to suggest for the new command.

Good name is a required prerequisite here, unfortunately...

[cut]

>>> "commit --amend"
>>> =A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
>>> =A0=A0 NEXT =3D HEAD
>>
>> =A0HEAD^ + (NEXT-HEAD^) =3D=3D NEXT
>>
>> "git commit --amend" works correctly even if HEAD is a merge commit!
>=20
> Another good issue.  A formal notation will need to specify how to
> deal with cases of a commit with more than one predecessor.

Perhaps, in extension notation proposed for describing what "git commit=
"
does perhaps

   commit^@ =3D HEAD^@

or just

   commit =3D copy(HEAD^{commit})
   commit^{tree} =3D :0:
=20
Note however that "git commit" has more modes.  Not including exotic
ones there is "git commit -a", "git commit [--only] <file>", and
rarely used "git commit --include <file>".

>>> "checkout FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
>>
>> No such requirement. =A0It's all about which files differ between HE=
AD
>> and FOO. =A0If you start working on some file, and decide that you
>> should have made the change on different branch, "git checkout FOO"
>> allow to move to FOO branch... assuming that changed file has the sa=
me
>> contents in HEAD and in FOO.
>=20
> Okay.  I will have to think about how a formal notation can denote th=
at...

I think that table with HEAD version, worktree version, switched to bra=
nch
version, and result for plain checkout, -f/--force and -m/--merge would
be a better solution than formal notation.

>>> =A0=A0 WTREE =3D FOO
>>> =A0=A0 NEXT =3D FOO
>>> =A0=A0 HEAD ::=3D FOO // changes the alias of HEAD to refer to FOO
>>
>> And this is supposed to be easier to understand?
>=20
> "checkout" is a very simple command to describe in English, so the
> mathematical description will be more convoluted.  I don't (yet)
> understand some of the variants of "git reset" even though they are
> written in English.  I'm hoping a formal notation will make them
> easier to understand.

Hmmm...
=20
>>> "stash save"
>>> =A0=A0 STASH =3D new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
>>> =A0=A0 NEXT =3D HEAD
>>> =A0=A0 WTREE =3D HEAD
>>> =A0=A0 push(STASH)
>>> "stash pop"
>>> =A0=A0 STASH =3D pop()
>>> =A0=A0 WTREE =3D HEAD + (STASH-STASH^^)
>>> =A0=A0 NEXT =3D HEAD + (STASH^-STASH^^)
>>
>> ???
>=20
> "stash save" makes two new consecutive commits: one equal to NEXT and
> another equal to WTREE.

No, "stash save" doesn't make two _consecutive_ commits.  It makes
a commit which has state of worktree as one parent, and state of index
as other parent (i.e. a merge commit).

> (This is "STASH" above, with my unoptimizations.)
> I don't know where the SHA of the final commit gets=20
> stored, so I just created push() and pop() commands.

It is stored in 'refs/stash' and its reflog.
=20
> Rereading the man page, the commit containing WTREE has two parents.
> This notation doesn't have a way to denote that.

Right.
=20
--=20
Jakub Narebski
Poland
