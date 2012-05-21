From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Mon, 21 May 2012 03:12:01 +0200
Message-ID: <CAMP44s1Bghc6zXRQ7fJxJORiHqAgs5dg-8_cp_FoChnBG7oD4w@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
	<CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
	<CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
	<7v1umv7ub0.fsf@alter.siamese.dyndns.org>
	<CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
	<20120519060031.GB23799@burratino>
	<7vzk92a76z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 03:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWHAr-0003KM-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 03:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab2EUBMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 21:12:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38208 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab2EUBME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 21:12:04 -0400
Received: by lbbgm6 with SMTP id gm6so3096108lbb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Yt+3lO+YMCw3aVliB1Vjwo3T2htPehnaQD3gJRW3M7Q=;
        b=TiaXmokFw8WF6FHIo5i0h5wBXkTukzuN1SeWNrG58aXvfAGVWRMCHl9p89i8UeKCL6
         /lFbXM7fw9qJ2EgGeGPJvyf7BieYc/A/l5GJIaeNrv82tDdIHqYbS89HKPHgR76n/pT+
         Ki0QhFGvXswS5Ijz1gS6CC0+Pgi5kXNM7d9zasBNYoBV9g/krsFZWV50e9O1N57k+rF5
         8EnqG579xUNbKLkvalWunpTlAt6+m53GFoWBkRj4BARvxo10NjI/NK9GAgosYcJLvkqO
         QsPtMl0VGqiL+9HQ4+8HgS2r0gHcMtZC/he8vxjAeZBMXjxkODuir8bvFHRBV/s+zEv7
         rz4A==
Received: by 10.152.123.244 with SMTP id md20mr18257195lab.0.1337562721899;
 Sun, 20 May 2012 18:12:01 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 20 May 2012 18:12:01 -0700 (PDT)
In-Reply-To: <7vzk92a76z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198073>

On Sun, May 20, 2012 at 11:11 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:

> I personally think it is a wrong way of thinking to focus too much on=
 the
> "name", though.

Names are important. Name it 'jaberwocky' and people would have a
harder time trying to understand what you are talking about. Maybe
just by hearing the name they would give up, thinking it's too
advanced, or too obscure, or what not.

There have been countless people that say "me too! when I realized it
was X", which suggests the current name does not help.

> The goal should be increased clarity and ease of learning.

And using a common/well understood name is a step in the right directio=
n.

But also, once we accept that "that thing" is not an index, then it
becomes much more easy to distinguish between the abstract concept,
and the actual index, and then we can begin to remove the index from
the high-level documentation and squash it to a corner where the user
does not _have_ to go unless she really does want to know the
implementation details.

Right now it's almost impossible to split the "index", and then index.

If the name is not important, why do you think people avoid the officia=
l name?

> For example, the first sentence in your example reads equally well if=
 it
> said "the content _prepared_ for the next commit" without losing clar=
ity
> and tells the most important thing it must tell the user: that "add" =
is
> about updating "that thing" that is different from the working tree a=
nd
> the latest commit, even if "stage" (verb) does not translate well to =
other
> language.

Indeed, but you are missing the important part; everything else in
that sentence.

I will put my end-user hat and read while thinking aloud the current te=
xt:

"This command updates the index"

OK, you lost me there. I don't know what is that "index", do I need to
learn what is that in order to understand the command? Maybe I
shouldn't be reading this documentation at all.

But, OK, let's give it a try... Right, an index, well, an index of
what to what? No idea. Maybe if I keep reading.

"using the current content found in the working tree, to prepare the
content staged for the next commit.

OK, maybe I'm beginning to understand... But I'm still not sure if I
should be touching this index thing, I don't understand what is being
indexed.

> About the "git stage --add/rm" commands in your follow-up message, I =
have
> mixed feelings. =C2=A0Once users get that making progress and growing=
 history
> with Git is all about interacting with "that thing", writing out a ne=
w
> tree out of it and recording it in a new commit with appropriate pare=
nts,
> saying "stage" becomes redundant. =C2=A0You "add", "remove", "patch",=
 etc. to
> affect that is recorded in "that thing" (e.g. you do not "add" to com=
mit).

While I would not like to touch the 'git stage' at this point--nor do
I think it's needed--, I don't agree with what you said. In certain
commands it might be redundant, but I specially disagree on these:

The 'add' command has a long tradition in SCM; it adds a file for
content tracking--nothing more.

Using 'add' to *update* the staging area seems completely and totally
counter-intuitive to me. Adding something means that something was not
there; if it was there, you couldn't add it.

Of course, that's if you think about files, but it makes sense if you
think about changes instead, but 'git add file' and 'git add file' do
very different things conceptually depending on weather 'file' was
tracked or not; one would "add a file" (to git), and the other would
"add the changes of the file" (to the staging area). Splitting the
command in two would make this difference in concepts clearer.

And then we have all sorts of confusion. --patch; I thought we were
adding patches to the staging area, this is redundant, --selectively
might make more sense. --update; I thought we were updating! --updated
might make more sense. And what happens when you do 'git add --patch
untracked-file' (or --update)? That's very strange.

If we have a 'stage' command things become much simpler:

git add untracked-file # maybe as the current 'git add --intent-to-add'
git add tracked-file # no-op (error?)
git add --patch file # doesn't make sense; option not present
git add --update file # doesn't make sense; option not present

git stage untracked-file # add, and stage it, why not?
git stage tracked-file
git stage --hunks file
git stage --updates file

At this point 'git add' would not be doing much, and might even go
away, but I guess it's nice for people coming from other SCMs.

'rm' is similar, could be solved by 'unstage'.

Either way, I have proposed to use stage/unstage before I think,
without much success, so I think the only realist option to move
forward is to add --stage(d) and --stage-only.

Cheers.

--=20
=46elipe Contreras
