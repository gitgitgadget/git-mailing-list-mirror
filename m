From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 7 Sep 2013 21:09:28 -0500
Message-ID: <CAMP44s1pcHHpU6bGfReMtdfOv3cUbFaw2fpCFZR_oyogqYFZPA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<CAMP44s3ABKMAhp_P+QZBWOfjp_wPkqB0A63v6n2mKZv_Ln+qKg@mail.gmail.com>
	<CAM9Z-nnjb1wUDH9e=E38QnWvPK44xZqvza77yNLrDpjpj47BKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIURg-0004tq-ET
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab3IHCJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:09:32 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:56017 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab3IHCJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:09:30 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so3930828lab.16
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hpYDQvIeTk9/BPRq/j6FIGv6QRZMGZLvS9u/bLv1tLE=;
        b=TbT6pd/8IgcQxWjSo+AHpDYfE5F6Y5D4Dqoz/Io3CpWFHwUYfDzAd9iN4MULUT1w8R
         HXnfIJmDB2MaTwe4Ck1lrYIiIsG+mTkhckvwQXFRF7pfZiYsq9uR+ZONiCAlwFHE+twg
         1/LJNUDCgR/p5EZdmj46e4cvx5alHct6hInfnFTfUAjh4+piU7BnLSpiLVUktxJQTFtf
         eY/06sbcUIKR/iNkNN00dlLPQjev+WEcslIYxK+hD9i3iSDWcCcY29fi89giAJAUnTdU
         jujQzkBCsGA7pT2ShjJnDQcDNokI4dKsMt1E+4juUaZS07ZLLZvThfbqNNhLRLa6fniT
         SQxw==
X-Received: by 10.152.116.7 with SMTP id js7mr9505851lab.11.1378606168924;
 Sat, 07 Sep 2013 19:09:28 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 19:09:28 -0700 (PDT)
In-Reply-To: <CAM9Z-nnjb1wUDH9e=E38QnWvPK44xZqvza77yNLrDpjpj47BKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234160>

On Tue, Sep 3, 2013 at 11:45 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 6:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, Aug 29, 2013 at 4:55 PM, Drew Northup <n1xim.email@gmail.com> wrote:
>>> On Thu, Aug 29, 2013 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> It has been discussed many times in the past that 'index' is not an
>>>>> appropriate description for what the high-level user does with it, and
>>>>> it has been agreed that 'staging area' is the best term.
>>>>
>>>> "add" is the verb, not "index" (which is a noun that refers
>>>> to the thing that keeps track of what will be written as a tree to
>>>> be committed next).
>>>>
>>>> And it will stay that way.
>
>>> I agree with Junio.
>>
>> All right, you are the only person (presumably other than Junio) that
>> thinks "index" is the right name for what high-level users should be
>> familiar with.
>
> If that were true it would never have gotten that name.

This is fallacious on so many levels. First, there's the concept of
legacy; what the developers of today think, is different than what the
developers of the past did, there might be more, there might be less,
there might be different people, or they might have changed their
mind, so what old developers thought doesn't reflect what the
developers today think. Second, there's this thing called "idea", and
nobody is born with all the ideas in the world and history; ideas
present themselves, and if nobody chose the new term, it might have
been because they simply didn't think about it. Third, they might have
not thought enough about the name in the first place, they thought
"index" was good enough, and could be fixed later if need be. Fourth,
only the developers were involved in picking the name, not users, so
what the vast majority of users thought didn't factor into the name.

So yeah, you are totally wrong.

> "Add" is the verb, as we are adding a snapshot.

Add a snapshot to where? To the repository? To a temporary stash? To
an online location.

The concept of "adding a snapshot" is meaningless.

> New users don't care how that works
> for the most part. Just telling them "it keeps track of it itself" is
> usually good enough.

Everything in a computer "keeps track of it itself", that's what a Von
Neumann computer does, because it has memory. When you type a
character it's kept in track, when you save a file it's kept in track.

Knowing that something "is kept in track" is not useful at all.

> If the user is asking for more detail at that
> point it is probably because he isn't as much interested in how to use
> it as he is in how it works.

Wrong. The user might be interested in knowing what the hell you are
talking about.

Adding what to what, and for what purpose.

> At that point we're better off just
> giving him the actual explanation instead of getting caught up in the
> staging area vs index fight (which seems odd to me as the index
> contains the entries which act as a "staging area"--a superset /
> subset relation).

Wrong. An index has absolutely nothing to do with a staging area. I
already explained multiple times the difference; an index is
information used to quickly find things, a staging area is used to put
things in preparation of something.

Even we are to use the index, the user needs to know what is being
indexed to what, for example, in a book index, words are being indexed
to their page numbers. It turns out we can't do that, because
technically Git does not have an index, but rather a manifest, or a
registry, or more generally, working tree metadata.

But that is not relevant, because we don't need to explain what each
every field in .git/index is, and it's binary format is, all we need
to do is explain what it's used for; it's used to prepare the contents
of the next commit, in other words; it's used as a staging area.

So when you "add to the staging area" you know what you add, to what,
and for what purpose.

>>> We add content snapshots to the index of content (creating
>>> "temporary"--they will be garbage collected eventually if they become
>>> orphans--objects into the store at the same time). We build commits
>>> from those snapshots (in whole or in part, typically only using the
>>> most recent snapshots of new things added to the index) and save those
>>> in the object store with the content and tree objects. Sometimes we
>>> create tag objects to record something special about commits, trees,
>>> and content blobs.
>>>
>>> That's the real model (with some rough edges). Explaining what that
>>> has to do with distributed version control is the hard part.
>>
>> The user doesn't need to know the format of the index, or the packs,
>> in fact, they don't even need to know the index or packs even exist.
>
> I never implied that the end user does need to know these things.
> (Note the use of "We"--as in "we who are having this conversation.")

We who are having this conversation are irrelevant. Stop with the red herrings.

We are talking about the vast majority of users and what's best for *them*.

>> All the user needs to know about this is that there's an area where
>> contents of the next commit are being prepared, and "staging area" is
>> the best name for that mental area. How that area is actually
>> implemented (the index) is not relevant to the user.
>
> Part of what I am arguing is that the mental area doesn't need to
> exist at all. The "staging area" is a part of the index.

Again, the term "index" and the term "staging area" in the English
language have absolutely nothing to do one with the other.

>> Everyone agrees on that, except you, and possibly Junio.
>
> We don't have enough information to say that. Seriously, this is
> nowhere near as certain as climate change.

Show me a single person except you and Junio that doesn't like the
term "staging area". Until you do, the claim remains; virtually
everyone agrees.

-- 
Felipe Contreras
