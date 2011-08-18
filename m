From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Branches & directories
Date: Thu, 18 Aug 2011 17:49:35 +0000
Message-ID: <CAMOZ1Btmk86vmp1gRuCfG7yRuc6fD3_oYBvtq2VKK9Ywu8ay0A@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
 <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com> <4E4CEFDA.9000703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 19:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu6jZ-0007oy-77
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 19:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab1HRRuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 13:50:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59221 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab1HRRuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 13:50:06 -0400
Received: by yxj19 with SMTP id 19so1658766yxj.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gM7sg8vu+bD8mOyaHYOwKLvxn2bUjt+h2r6fUwJzjKw=;
        b=Mt/j1igUweeeG8beG2RxA0R2lnkuBiwKTzcVBjtqwcYuV5A60TetvkHWde8nicLuYC
         F3xKPZg84hRuF4pnCstiohVuig9iIrfPy0pvoo+x83qLSsyaso/Ep6MPthRBLo37QBGU
         AurMrFOfwxY6VovvlPBecGenBx1qy6Ih8ZzO0=
Received: by 10.43.44.195 with SMTP id uh3mr1061574icb.196.1313689805063; Thu,
 18 Aug 2011 10:50:05 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Thu, 18 Aug 2011 10:49:35 -0700 (PDT)
In-Reply-To: <4E4CEFDA.9000703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179609>

On Thu, Aug 18, 2011 at 10:56, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Michael Witten venit, vidit, dixit 18.08.2011 07:52:
>> On Wed, Aug 17, 2011 at 21:23, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>>> It would be really nice, though, if Git could somehow
>>> "stash" such files when checking out a different branch. In general, I
>>> would prefer if uncommitted changes and untracked and/or ignored files
>>> stuck to the branch where they were created.
>>
>> As an aside, the problem here is likely a manifestation of the fact
>> that nobody understands what a branch is; the word 'branch' is
>
> I would reject "nobody"...

Is it really necessary to attack something that is obviously
hyperbolic rhetoric? The point is that a lot of people struggle with
git's concepts, and I think that the reason is largely two fold:

  * Terminology that is inaccurate by virtue of terminological baggage.
  * Terminology that is imprecisely used across the documentation.

>> TERRIBLE, as everyone has a different idea for what that should mean.
>
> ... and insist that this statement is true either trivially true for all
> words, or for none, depending on your understanding of "everyone has a
> different".

So, precision is impossible?

The word 'branch' is clearly a sticking point, and you know it. You
can't deny that people have a hard time with what a branch really is
in git.

>> In my opinion, `git branch' should become `git ref' or the like.
>
> "branch" and "tag" are boths refs. Their only essential difference is
> that one "moves" and the other doesn't.

Indeed, and it seems like there's room for abstraction; a tool like
`git ref' or `git pointer' or `git ptr' could probably handle both
quite well.

Terminology for references is a problem that was solved by the
Ancients, so it's a wonder we didn't use their work (pointers,
constant pointers, dereferencing, etc.).

>> One of git's worst faults is that a complicated and imprecise
>> interface has been draped over a very simple and precise underlying
>> structure.
>
> A name is a name and just that. The use of any existing word may clash
> with someone's expectations.

Yeah? So why wasn't the term 'foobar' used instead of 'branch'? Most
terms are chosen for their associations (and only really novel
concepts receive an entirely new label), and I proffer that 'branch'
has too many associations to be considered accurate enough.

The idea was that one line of development can 'branch' off from
another, so it was called a 'branch'. But what is a line of
development? (merges certainly make the concept fuzzy; tree branches
usually don't join with the tree trunk again). The thing is, though,
when you're working with what git calls a 'branch', you're really just
working with a pointer to a commit object; the term 'pointer' would
have been much more accurate.

Now, I'm not saying we should be using 'pointer', but what I am saying
is that it's necessary to choose words carefully, preferably in a way
that carries just enough associations to aid the user in remembering
what a term describes.

> I find the concepts "file created on a branch", "commit created on a
> branch" silly, it's part of what drove me from hg to git early on.

There's no shortage of that kind of thinking in the git community,
which is my point. The reason is a failure of both accurate
terminology and precise usage.

> git's branches do exactly what I (and many others) expect branches
> to do and what I need daily, even coming from a svn and hg background.

Yes, well, many figure it out EVENTUALLY; it just requires them to
ignore most of the associations of 'branch', thereby tacitly
translating the word 'branch' into 'pointer'.
