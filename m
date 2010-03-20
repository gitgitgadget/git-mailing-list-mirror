From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 16:06:56 -0300
Message-ID: <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com> 
	<7vvdcrowlc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 20:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt416-0003w7-6l
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 20:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab0CTTHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 15:07:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58087 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0CTTHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 15:07:17 -0400
Received: by gwaa18 with SMTP id a18so322233gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Tpxm20twucWeKxjBp53xKgdYWhqvvoMTgE2Z9Z4uur4=;
        b=kUNeEh/8qWOry0RlPbNa1iAyJv72VAg7HbqfiQ2Ok9WT5dpLk88mK7WVtI2D6GewXf
         BmC4Y0R79dXlYjp7da/oixXWuWNjdDkdPY9OW4LA2Bgwq2Vn1OsYSI/khLnmUANmDwda
         ICoYDi5QgYZHtgHOhBmoXnnuL/YyQs57y319g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jTU6ENjWCXSyzww4soM+Ojte3OEtlwcMdJW83l2seash8iVk/5eNhbxjiWpiCNeap3
         jmn8esQpFcEOJfHRftXhyi4aBY1SY/fxLeCIY2Ao67kiDHmYvFZ1TTDqCjaPGlce9h+r
         +nZ9WAsSRkAjmAaMOifapIYFEC/jWLLWuoh+k=
Received: by 10.150.2.5 with SMTP id 5mr8315865ybb.197.1269112036268; Sat, 20 
	Mar 2010 12:07:16 -0700 (PDT)
In-Reply-To: <7vvdcrowlc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142741>

Hi,

2010/3/20 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> Complete rewrite of --orphan functionality to fit it in the new desi=
gn goals
>> set by Junio. =C2=A0Now --orphan is not anymore an option of -b. =C2=
=A0It is an
>> alternative to it.
>
> You are giving me too much credit. =C2=A0I just made a suggestion, yo=
u had the
> choice to agree to or disagree with it, and I am hoping that you made=
 the
> final decision to rewrite the patch to match what I suggested not bec=
ause
> you wanted a "commit count" in the project with any form of a change,=
 but
> because you thought the suggested approach made much more sense than =
the
> earlier iterations. =C2=A0And in that case, the final decision to sub=
mit the
> patch in this form was due to _you_. =C2=A0Don't give me undue credit=
---I was
> just helping from the sideline.

If I was going to look for a commit count I would do spelling/grammar
corrections. :-)

This is the second feature I am trying to add to git.  Both changes of
mine are features I use my own.  On my compiled and customized version
of git.  I thought they were good and tried to share following the
best free software spirit (I have been always feeling guilty of just
using free software).  I am not a new developer trying to be known.  I
am not even "new"...  :-)

Anyway I think you will not hear of me anymore after we finish this
work.  I think I did enough for this project and I really don't feel
myself fitted to the task.

I realized your last critic was indeed good and that it worthed the cha=
nges.

But I have to confess that I am a little impatient to end this
development cycle though.  So trying not to argue was a change of
behavior. ;-)

>> Junio: =C2=A0I ask you to reconsider only the giving of the "short-a=
nd-sweet" -o
>> from beginning because of the new design.
>
> No. =C2=A0I don't want our hand to be tied with something that is cle=
arly a
> corner case feature from the beginning. =C2=A0It wouldn't be too late=
 to add
> one later, after it proves something people do every day (or even eve=
ry
> hour).

If it is because of its importance I think it will never deserve the up=
grade.

But I was arguing because I imagine checkout will never need the 21
remaining letters and that it was good for cosmetic and similarity (to
his brother -b) reasons.

Also because I am more used to one letter options from previous
operational systems experience (let's forget that! :-) ).

>> =C2=A0Documentation/git-checkout.txt | =C2=A0 21 +++++++++++++++-
>> =C2=A0builtin/checkout.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 19 +++++++++++++-
>> =C2=A0t/t2017-checkout-orphan.sh =C2=A0 =C2=A0 | =C2=A0 53 +++++++++=
+++++++++++++++++++++++++++++++
>> =C2=A03 files changed, 90 insertions(+), 3 deletions(-)
>> =C2=A0create mode 100755 t/t2017-checkout-orphan.sh
>>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index 37c1810..18df834 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -20,6 +20,19 @@ When <paths> are not given, this command switches=
 branches by
>> =C2=A0updating the index, working tree, and HEAD to reflect the spec=
ified
>> =C2=A0branch.
>>
>> +When you use "--orphan", a new unparented branch is created having =
the
>> +index and the working tree intact. =C2=A0This allows you to start a=
 new
>> +history that records set of paths similar to that of the start-poin=
t
>> +commit, which is useful when you want to keep different branches fo=
r
>> +different audiences you are working to like when you have an open s=
ource
>> +and commercial versions of a software, for example.
>> +
>> +If you want to start a disconnected history that records set of pat=
hs
>> +totally different from the original branch, you may want to first c=
lear
>> +the index and the working tree, by running "git rm -rf ." from the
>> +top-level of the working tree, before preparing your files (by copy=
ing
>> +from elsewhere, extracting a tarball, etc.) in the working tree.
>> +
>> =C2=A0If `-b` is given, a new branch is created and checked out, as =
if
>> =C2=A0linkgit:git-branch[1] were called; in this case you can
>> =C2=A0use the --track or --no-track options, which will be passed to=
 `git
>
> It feels wrong to talk about --orphan before readers learned -b. =C2=A0=
Does the
> text flow nicely if we just swap the paragraphs? =C2=A0Better yet, pe=
rhaps we
> shouldn't have any of this in the general description section. =C2=A0=
Move this
> and consolidate it with the text in "OPTIONS" section under "--orphan=
"?

As you wish.

>> @@ -63,6 +76,12 @@ entries; instead, unmerged entries are ignored.
>> =C2=A0 =C2=A0 =C2=A0 When checking out paths from the index, check o=
ut stage #2
>> =C2=A0 =C2=A0 =C2=A0 ('ours') or #3 ('theirs') for unmerged paths.
>>
>> +--orphan::
>> + =C2=A0 =C2=A0 Create a new branch named <new_branch>, unparented t=
o any other
>> + =C2=A0 =C2=A0 branch. =C2=A0The new branch you switch to does not =
have any commit
>> + =C2=A0 =C2=A0 and after the first one it will become the root of a=
 new history
>> + =C2=A0 =C2=A0 completely unconnected from all the other branches.
>> +
>> =C2=A0-b::
>> =C2=A0 =C2=A0 =C2=A0 Create a new branch named <new_branch> and star=
t it at
>> =C2=A0 =C2=A0 =C2=A0 <start_point>; see linkgit:git-branch[1] for de=
tails.
>
> Likewise. =C2=A0I think "--orphan" should come after -b/-t/-l (all ab=
out the
> normal cases of switching to a different branch either new or existin=
g).

All right.

> Oh, by the way, how does this new option work with -t? =C2=A0I think =
the
> combination should be rejected, no?

Yes it should.  And it is.  By --track itself which is directly
connected to -b.  Test done just before --orphan test by someone else.

> I have a suspicion that you are trying "git co-o new old" case where =
old
> is not the current branch (so that you would want to adjust the index=
 and
> the working tree files to that of "old" while carrying local changes
> forward), _but_ if that is the case that should have been already don=
e
> with the logic in switch_branches() where it calls merge_working_tree=
(),
> and not here in the call chain.

My fault.  Forget that.  Fast unverified work in a hurry. :-\

>> @@ -677,6 +686,12 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.new_branch =3D=
 argv0 + 1;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (opts.new_orphan_branch) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.new_branch)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("--orphan and -b are mutually exclusive");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.new_branch =3D opts=
=2Enew_orphan_branch;
>> + =C2=A0 =C2=A0 }
>
> How should this interact with opts.track? =C2=A0I think (and please c=
orrect
> me if you disagree):
>
> =C2=A0- "git checkout -t --orphan new [old]" should fail; new is root=
less and
> =C2=A0 does not track either the current branch or "old";
>
> =C2=A0- opts.track that came from git_branch_track (default read from=
 config)
> =C2=A0 should not cause a failure, but be silently ignored.

It is just working like you have pictured.

>> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
>> new file mode 100755
>> index 0000000..e6d88b1
>> --- /dev/null
>> +++ b/t/t2017-checkout-orphan.sh
>> @@ -0,0 +1,53 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2010 Erick Mattos
>> +#
>> +
>> +test_description=3D'git checkout --orphan
>> +
>> +Main Tests for --orphan functionality.'
>> +
>> +. ./test-lib.sh
>> +
>> +TEST_FILE=3Dfoo
>> +
>> +test_expect_success 'Setup' '
>> + =C2=A0 =C2=A0 echo "Initial" >"$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -m "First Commit"
>> + =C2=A0 =C2=A0 test_tick &&
>> + =C2=A0 =C2=A0 echo "State 1" >>"$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -m "Second Commit"
>
> No tick before this one?

I will add another then.

>> +'
>> +
>> +test_expect_success '--orphan creates a new orphan branch from HEAD=
' '
>> + =C2=A0 =C2=A0 git checkout --orphan alpha &&
>> + =C2=A0 =C2=A0 test_must_fail PAGER=3D git log >/dev/null 2>/dev/nu=
ll &&
>> + =C2=A0 =C2=A0 test "alpha" =3D "$(git symbolic-ref HEAD | sed "s,.=
*/,,")" &&
>
> What is this PAGER=3D doing here?
>
> I think it is more direct to check that:
>
> =C2=A0- "rev-parse --verify HEAD" fails; and
> =C2=A0- "symbolic-ref HEAD" says refs/heads/alpha.
>> + =C2=A0 =C2=A0 test_tick &&
>> + =C2=A0 =C2=A0 git commit -m "Third Commit" &&
>
> Tricky but correct ;-)

Indeed.  Easier your way though.

>> + =C2=A0 =C2=A0 test 0 -eq $(git cat-file -p HEAD | grep "^parent" |=
 wc -l) &&
>
> =C2=A0 =C2=A0test_must_fail git rev-parse --verify HEAD^
>
>> + =C2=A0 =C2=A0 git cat-file -p master | grep "^tree" >base &&
>
> =C2=A0 =C2=A0git rev-parse master^{tree} >base
>
>> + =C2=A0 =C2=A0 git cat-file -p HEAD | grep "^tree" >actual &&
>> + =C2=A0 =C2=A0 test_cmp base actual
>> +'
>
> Or you can just replace the above three lines with:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-tree --quiet master alpha
>
>> +test_expect_success '--orphan creates a new orphan branch from <sta=
rt_point>' '
>> ...
>> +'
>
> Similar.
>
>> +test_expect_success '--orphan must be rejected with -b' '
>> + =C2=A0 =C2=A0 test_must_fail git checkout --orphan new -b newer
>> +'

All your suggestions are going to be added.

> Ok. =C2=A0You have the basics covered well; there are a few more thin=
gs to
> test, I think.
>
> With local changes in the index/working tree without "start commit" (=
which
> should never fail) and with "start commit" (which should fail if HEAD=
 and
> start commit has differences to the same paths as you have local chan=
ges
> to).

It is behaving like that already and that is intrinsically a
switch_branches() logic, not a special --orphan need.  It is not part
of this implementation and It is probably tested elsewhere (you
probably do know where).

> Also you would want to check with -t, --no-t, branch.autosetupmrebe s=
et to
> always in the configuration with -t and without -t from the command l=
ine,

The actual implementation is just ignoring track and -t is not even
allowed.  So it is pointless.

> Thanks.
>

I will be sending a new patch version soon.

Regards
