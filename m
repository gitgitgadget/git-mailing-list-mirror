From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Mon, 26 Sep 2011 11:34:04 +1000
Message-ID: <CAH5451nk9FnqwhEe0SWxDc3TnLiTLnFgD6zB3jDehFZn6=qWvw@mail.gmail.com>
References: <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
 <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
 <201109242259.p8OMxqIM026259@no.baka.org> <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
 <m31uv4rc47.fsf@localhost.localdomain> <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
 <m3oby8pcfz.fsf@localhost.localdomain> <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net>
 <20110926003447.GG10955@localhost.localdomain> <1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 03:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R805W-000053-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 03:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab1IZBe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 21:34:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37617 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab1IZBeZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 21:34:25 -0400
Received: by fxe4 with SMTP id 4so5564591fxe.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LK5oFdYkocubElguqvDaKYc9IKfWL5CuRPwRCEvTIEM=;
        b=bYUkn7DImr/tnEI4mUPxsXYhz3+CJEvHh5cBnt3BLR1NOQBh8PrJ1bhSVxxxtfy8Jw
         k3vbKLe8WInWEoFUC6pU6HNJxlFCLW7lgKPLyViC+txTToTKTVLJ36iryC7fXuYsIAIk
         pzqPk4vLvWYQwuIMKD0cjCdVWTH4hlRhn5Xuc=
Received: by 10.223.64.84 with SMTP id d20mr9572259fai.97.1317000864306; Sun,
 25 Sep 2011 18:34:24 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Sun, 25 Sep 2011 18:34:04 -0700 (PDT)
In-Reply-To: <1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182087>

On 26 September 2011 10:56, tactical <a5158017@nepwk.com> wrote:
> Konstantin Khomoutov wrote:
>
>>>>> From what I read, detached heads are subject to garbage collectio=
n.
>>>>
>>>> No, HEAD is protected against garbage collecting. =C2=A0To be sure=
 you
>>>> should name a branch when switching branches, though reflog would
>>>> protect you for 30 days (by default) even if you don't do that.
>>>
>>> So Git doesn't really support anonymous branching as part of a norm=
al
>>> workflow.
>>
>> I perceive a certain logical fallacy here: you cannot switch between
>> anything anonymous because to switch, you should somehow identify
>> something to switch to--a name in whatever sense we put into this wo=
rd.
>
> In Mercurial, you can just update to a particular changeset (and you
> identify that changeset by repository-local revision number or global=
ly
> unique ID) and then commit again. =C2=A0The point is that there's no =
need to
> give a label to a head in Mercurial (although you can if you want to,=
 using
> Mercurial bookmarks, which are basically the same as what Git uses).
>
> Here's an example of anonymous branching:
>
> =C2=A0 =C2=A0c:\test>hg init
>
> =C2=A0 =C2=A0c:\test>echo test>foo
>
> =C2=A0 =C2=A0c:\test>hg commit --addremove -m initial
> =C2=A0 =C2=A0adding foo
>
> =C2=A0 =C2=A0c:\test>echo first>>foo
>
> =C2=A0 =C2=A0c:\test>hg commit -m first
>
> =C2=A0 =C2=A0c:\test>hg log
> =C2=A0 =C2=A0changeset: =C2=A0 1:3e895ec28d6c
> =C2=A0 =C2=A0tag: =C2=A0 =C2=A0 =C2=A0 =C2=A0 tip
> =C2=A0 =C2=A0user: =C2=A0 =C2=A0 =C2=A0 =C2=A0tactical
> =C2=A0 =C2=A0date: =C2=A0 =C2=A0 =C2=A0 =C2=A0Mon Sep 26 01:39:46 201=
1 +0100
> =C2=A0 =C2=A0summary: =C2=A0 =C2=A0 first
>
> =C2=A0 =C2=A0changeset: =C2=A0 0:b51644bb3450
> =C2=A0 =C2=A0user: =C2=A0 =C2=A0 =C2=A0 =C2=A0tactical
> =C2=A0 =C2=A0date: =C2=A0 =C2=A0 =C2=A0 =C2=A0Mon Sep 26 01:39:40 201=
1 +0100
> =C2=A0 =C2=A0summary: =C2=A0 =C2=A0 initial
>
> =C2=A0 =C2=A0c:\test>hg update 0
> =C2=A0 =C2=A01 files updated, 0 files merged, 0 files removed, 0 file=
s unresolved
>
> =C2=A0 =C2=A0c:\test>echo second>>foo
>
> =C2=A0 =C2=A0c:\test>hg commit -m second
> =C2=A0 =C2=A0created new head
>
> =C2=A0 =C2=A0c:\test>hg glog
> =C2=A0 =C2=A0@ =C2=A0changeset: =C2=A0 2:35c82a7e7de1
> =C2=A0 =C2=A0| =C2=A0tag: =C2=A0 =C2=A0 =C2=A0 =C2=A0 tip
> =C2=A0 =C2=A0| =C2=A0parent: =C2=A0 =C2=A0 =C2=A00:b51644bb3450
> =C2=A0 =C2=A0| =C2=A0user: =C2=A0 =C2=A0 =C2=A0 =C2=A0tactical
> =C2=A0 =C2=A0| =C2=A0date: =C2=A0 =C2=A0 =C2=A0 =C2=A0Mon Sep 26 01:4=
0:10 2011 +0100
> =C2=A0 =C2=A0| =C2=A0summary: =C2=A0 =C2=A0 second
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0| o =C2=A0changeset: =C2=A0 1:3e895ec28d6c
> =C2=A0 =C2=A0|/ =C2=A0 user: =C2=A0 =C2=A0 =C2=A0 =C2=A0tactical
> =C2=A0 =C2=A0| =C2=A0 =C2=A0date: =C2=A0 =C2=A0 =C2=A0 =C2=A0Mon Sep =
26 01:39:46 2011 +0100
> =C2=A0 =C2=A0| =C2=A0 =C2=A0summary: =C2=A0 =C2=A0 first
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0o =C2=A0changeset: =C2=A0 0:b51644bb3450
> =C2=A0 =C2=A0 =C2=A0 user: =C2=A0 =C2=A0 =C2=A0 =C2=A0tactical
> =C2=A0 =C2=A0 =C2=A0 date: =C2=A0 =C2=A0 =C2=A0 =C2=A0Mon Sep 26 01:3=
9:40 2011 +0100
> =C2=A0 =C2=A0 =C2=A0 summary: =C2=A0 =C2=A0 initial
>
> I now have two anonymous branches, and these will never be garbage
> collected. =C2=A0I can easily update to either branch with "hg update=
 1" or "hg
> update 2" (or "hg update 0" again, if i want to create yet another
> anonymous branch).
>
>> As I understand, by switching between branches in Mercurial you mean
>> switching between directories with clones;
>
> No. =C2=A0Clones are a different topic.
>
>> As to branches, they do have names in Git but they are very loosely
>> coupled with their names: tag a tip of some branch (to still have a
>> handle on that tip commit) then delete that branch--there will be no
>> traces of that branch's name left, the branch's name is not encoded =
in
>> its history in any way.
>
> Git branch names are basically the same as Mercurial bookmarks. =C2=A0=
The
> difference is that in Mercurial you don't *have* to use bookmarks.
>
>> The branch names is just a way to not mess with
>> SHA-1 names of commits (and to have references to those commits to k=
eep
>> them out of consideration for garbage collection).
>> Hence the idea to demand support for anonymous branches in Git's mod=
el
>> is just unfounded.
>
> I think it's simply a weakness of Git. =C2=A0There are zero problems =
with
> anonymous branching in Mercurial, and it's a very powerful and simple
> system.
>

I am no expert on this, however git can (of course) do 'anonymous
branching' just as simply as mercurial, with one caveat; for most
intents and purposes (as far as I have seen/heard discussed) git and
mercurial are homomorphic, and in the situations they are not git is
the more general system.

The flow that you are using for anonymous branching in mercurial is
easily reproducible in git, using detached heads. Checkout a revision
(note: not a ref)
  git checkout HEAD@{1}
hack + commit. Repeat as often as you like. Your concern is that these
will (eventually) be garbage collected. Again, I am not an expert in
this so please correct me if I have this incorrect, but the man page
for gc says:

       git-gc tries very hard to be safe about the garbage it collects.=
 In
       particular, it will keep not only objects referenced by your cur=
rent
       set of branches and tags, but also objects referenced by the ind=
ex,
       remote tracking branches, refs saved by git-filter-branch in
       refs/original/, or reflogs (which may references commits in bran=
ches
       that were later amended or rewound).

As any commits you make in a detached state are in the reflog until
they expire (by default 30 days I think?) you have more than enough
time to decide if you want to keep the work - which you can do very
easily by assigning it a name. If the default time is not long enough,
simply extend it in your config
  git config gc.reflogExpire =3D 10000 years <- syntax might not be cor=
rect
The reason this is not true by default is that _most_ people don't
work exclusively in anonymous branches, and it is far nicer
performance wise to have git clean up for you.

So you don't *have* to use branches in git - they just make it much
easier to get around. They cost practically nothing to use, so I don't
really understand why you wouldn't want to for anything other than
just a quick throwaway test or scratch idea.

I hope that clears it up a little.

Andrew
