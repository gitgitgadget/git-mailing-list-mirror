From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 12 Jun 2011 09:30:13 -0400
Message-ID: <BANLkTin_NYZ39s7gXbVrbAZU=+fzRCHdcA@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DF08D30.7070603@alum.mit.edu>
	<20110609161832.GB25885@sigill.intra.peff.net>
	<4DF10ADA.5070206@alum.mit.edu>
	<7v8vtayhnm.fsf@alter.siamese.dyndns.org>
	<20110609200403.GA3955@sigill.intra.peff.net>
	<7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 15:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVkkA-0007Yg-Sb
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 15:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1FLNaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 09:30:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52720 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab1FLNaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 09:30:15 -0400
Received: by bwz15 with SMTP id 15so3148586bwz.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mDY66+LQ8QfpKIRGpUee70h8SHt/swv9WgPJZ58rb/M=;
        b=CSASQe9TZZxpzxhXKAcEq7b+5Lr5QiAG0T6Lw4iOcJ0SgnEe1/Jc5uFqMw2Kf/ndmb
         8/PT9UiTtXViwR/fuKe62UMaZGGSRMdvVS/FP0PqxZ5/HdAGE/YGErnFFN5nqa4HQriD
         CIZT7DPLqEv1PiAnEXu1x6gCBUdiXUx4HvoDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=dJALhGqPCcJuA2/q1G7Wn62ihFSx9Iypqoj8EHWCy8XtaYOKIQ1Ma7B3PfhW4HsEFk
         rP1NubCjOp+bgaO9MtbX/18K+iOOY4CexttK2X14Ru3g1zc1fVU6lvqK6Ax2aO0hHlAb
         oGb5AewH52CHiMyxy7LvN+uJv8qrLDOKbilko=
Received: by 10.204.14.144 with SMTP id g16mr2007215bka.34.1307885414142; Sun,
 12 Jun 2011 06:30:14 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Sun, 12 Jun 2011 06:30:13 -0700 (PDT)
In-Reply-To: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175660>

I'm going to accept Junio's reply at a sign to withdraw.

It is clear that implementing NEXT/WTREE will worsen the performance
of some commands ("git diff" under merge conflict).  I can accept that
the community does not want to give up performance to include an
incomplete idea that offers no quantifiable improvement.


I agree with Haggerty that the value of NEXT and WTREE to the user
will be seen when they are used in multiple commands.  That is, when
they are part of a collection of porcelain-level concepts that the
user can work with.

I'm going to start a discussion on those porcelain-level concepts.  I
don't think this mailing list is the right forum for it.  If you wish
to be a part of the discussion, please email me.

If the discussion produces something of value, I look forward to
returning and presenting it to the mailing list.

Mike


On Fri, Jun 10, 2011 at 5:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> I think there are actually two questions here:
>>
>> =A0 1. Will it be easier for people to understand "git diff" if we u=
se
>> =A0 =A0 =A0tokens to describe non-treeish sources and destinations?
>>
>> =A0 2. Are there better tokens to use to break down parts of the ind=
ex?
>>
>> I don't have a big problem with (1). Allowing things like:
>>
>> =A0 git diff INDEX WTREE
>>
>> allows one to explain what is going on with the diff syntax in a ver=
y
>> clear and verbose manner. I wouldn't want to type that every day, bu=
t
>> that's OK; "git diff" will always mean the same thing as it always h=
as,
>> but can now be explained to people who have trouble seeing it in ter=
ms
>> of "git diff INDEX WTREE".
>>
>> There's still a bit of magic in that INDEX is _not_ a tree, but I th=
ink
>> that's a good thing. When there are no merge conflicts, it will beha=
ve
>> identically to the proposed NEXT tree. And when there are conflicts,=
 it
>> will show you something even more useful.
>
> Thanks. This is exactly why I love to have people like you on the lis=
t,
> who can say what I wanted to say in a matter that is a lot easier to
> understand.
>
> In short, the proposed "NEXT" does not help in a situation with confl=
icts,
> and makes the user experience worse. In order to get the current powe=
r of
> "git diff" with various options that are specifically designed to hel=
p
> users to make progress (either working on their own changes, rebasing=
 them
> on top of others, or merging other's work in), people _COULD_ introdu=
ce
> BASE/OURS/THEIRS in addition to "NEXT", throw the existing HEAD and
> MERGE_HEAD to the mix, derive the same information by spending mental
> effort to choose between which pairs of two entities among these six
> possibilities and take pairwise diffs among those pairs, and combine =
the
> results of these diffs (the message I responded to with "is that a us=
eful
> question" was an example of that---"Could we pile more kludge on top =
of
> NEXT to have expressiveness equivalent to what the current index-base=
d
> system offers?"). Yes, that may be possible, but is there a point in
> making users go through that kind of mental contortion by introducing
> these new tokens? I find it highly doubtful that it would help new pe=
ople
> understand the situation during conflicted merges.
>
>> =A0 git show INDEX:OURS:Makefile
>>
>> which is identical to what I wrote above, but is perhaps easier to
>> explain.
>
> Why does anybody even want to say :2:Makefile to begin with?
>
> Presumably, you are dealing with a merge conflict at that path and tr=
ying
> to see how pre-merge version of Makefile looked like, and then the ne=
xt
> thing you may want to do is how pre-merge version of their Makefile l=
ooked
> like.
>
> Wouldn't it be far more natural to ask for these instead?
>
> =A0 =A0git show HEAD:Makefile
> =A0 =A0git show MERGE_HEAD:Makefile
>
> I do not think whoever brought that "you can look at individual stage=
s
> with :$n:$path" to this discussion was thinking straight. Yes, it is
> something you _could_ do, I've never found that particularly _useful_
> unless I was debugging git itself.
>
