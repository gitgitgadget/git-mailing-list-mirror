From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 18:27:11 -0400
Message-ID: <BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com>
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
	<4DF13D00.2060000@alum.mit.edu>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:27:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnhP-0006A6-IO
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab1FIW1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 18:27:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37130 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab1FIW1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 18:27:12 -0400
Received: by bwz15 with SMTP id 15so1727407bwz.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=El5BaNjeWKo2MztfbI3qmjnucEaFpbnzS0GaNPwrcBw=;
        b=WeNYLlmRLTqks1lewZO7salGuHuRHlCQnOX4fu4CUX9z9sVg5pzOwCwwwTaPzT1uut
         2k46XEyEfIqcPHYXl34PnF41vqICYkO14FxTievxGn3Flv6plUBrywsn2g6K2CE95Vmg
         vTyCX83FC/ujJTPqzA3IjuTPKguuCMNN2P9/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=rCPovn2z/KgdK1r1CUj5N1AZP6GfK7+qL4ttLn5dfA+L+HbIrOBEbIOSa38awiWyF2
         eQV0lB2JYQlU4SzqJmpLThk3JvBCWyZwhgDWgT+Lpm1qU8PbSEptBEM9ySTeBSqGwkbi
         qCDPlXadGmZtmwSVc4ecK+ri4+SFB5ok/Jm+I=
Received: by 10.204.82.149 with SMTP id b21mr1184783bkl.196.1307658431234;
 Thu, 09 Jun 2011 15:27:11 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Thu, 9 Jun 2011 15:27:11 -0700 (PDT)
In-Reply-To: <4DF13D00.2060000@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175581>

I dunno Michael, your idea sounds dangerous.

You're saying that the user interface should be defined with concepts
that have nothing to do with the plumbing.  That's crazy talk!  Next
you'll be arguing that users don't need to know that the Index file
has 4 stages!

;)


Jakub: "it is unnecessary power"
Yeah, like that an argument that anyone here will listen to.  "I can't
let you have diff3.  It's too much power for you.  You might trash the
repository with ... uh... diff3."

Peff: "... use tokens to describe non-treeish sources and destinations"
What defines "tree-ish"ness?
What is non-treeish about NEXT/WTREE/etc.?
Do you know of anything in the INDEX file that would not be visible
from NEXT/WTREE/OURS/THEIRS?

Mike


On Thu, Jun 9, 2011 at 5:37 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
> On 06/09/2011 10:04 PM, Jeff King wrote:
>> I'm less sure about these new tokens, for a few reasons:
>>
>> =A0 1. You get less useful answers in some situations by treating ea=
ch
>> =A0 =A0 =A0stage as a separate tree (e.g., lack of combined diff). S=
o why
>> =A0 =A0 =A0would I want to use them?
>
> Wouldn't it be nice to be able to do a combined diff between *any* tw=
o
> trees? =A0Then the nonuniform merge behavior of "git diff" would be a
> special case of a general concept:
>
> =A0 =A0git diff3 OURS NEXT THEIRS
>
>> =A0 4. They're supposed to be simpler to understand than index stage=
s. But
>> =A0 =A0 =A0are they? The latest definitions seem to be:
>>
>> =A0 =A0 =A0 =A0OURS is a tree of each path in the index, either from=
 stage 2 if
>> =A0 =A0 =A0 =A0it exists, or from NEXT otherwise.
>>
>> =A0 =A0 =A0 =A0NEXT is a tree of each path in the index, either from=
 stage 0 if
>> =A0 =A0 =A0 =A0it exists, or from HEAD otherwise.
>>
>> =A0 =A0 =A0But that doesn't seem any simpler to me than just saying =
"the index
>> =A0 =A0 =A0has numbered stages, and they correspond to resolved, bas=
e, ours,
>> =A0 =A0 =A0and theirs".
>
> There is no need to explain the pseudotrees in terms of the index
> stages; the pseudotrees are easier to understand and should therefore
> become the primary way to describe the index. =A0Let me give it a try=
, at
> tutorial level. =A0Assume that the concepts HEAD and WTREE have alrea=
dy
> been introduced:
>
> =A0The "index" is a special area that can hold one or more temporary
> =A0snapshots of your version-controlled content. =A0Each snapshot is
> =A0called a "tree" because it is analogous to a filesystem tree such
> =A0as the working tree [1].
>
> =A0Usually the index holds a single tree called "NEXT". =A0NEXT is a
> =A0snapshot of the state of the working tree that is ready to be
> =A0committed. =A0This usually consists of the contents from the commi=
t
> =A0that was last checked out (HEAD), plus any changes that have been
> =A0staged for commit using "git stage".
>
> =A0It is possible to use "git diff" to view the difference between an=
y
> =A0two trees, whether they be trees in the index, trees in commits, o=
r
> =A0the working tree. =A0For example, to see the difference between th=
e
> =A0last commit and the working tree, use
>
> =A0 =A0 =A0git diff HEAD WTREE
>
> =A0If you would like to see the changes that are ready to be committe=
d,
> =A0type
>
> =A0 =A0 =A0git diff HEAD NEXT
>
> =A0To see the changes in your working tree that have not yet been sta=
ged
> =A0for commit, use
>
> =A0 =A0 =A0git diff NEXT WTREE
>
> =A0(The previous command can be abbreviated to "git diff".)
>
> =A0However, things become more complicated during a merge, when the
> =A0index is used to keep track of the merge's progress. =A0During a
> =A0merge, the index contains four trees: "NEXT", "OURS", "THEIRS", an=
d
> =A0"BASE". =A0These four trees are modified as merge conflicts are
> =A0resolved.
>
> =A0NEXT, as usual, contains the contents that are ready to be committ=
ed.
> =A0Specifically, NEXT contains:
>
> =A0 =A0* the original contents of the branch being merged into
> =A0 =A0* plus the merged versions of any files that merged cleanly
> =A0 =A0* plus any changes that have been staged for commit using
> =A0 =A0 =A0"git stage"; for example, files whose conflicts have been
> =A0 =A0 =A0resolved manually.
>
> =A0OURS contains all of the resolved merges from NEXT, with any
> =A0remaining conflicts resolved by using the version from the branch
> =A0being merged *into*.
>
> =A0THEIRS contains all of the resolved merges from NEXT, with any
> =A0remaining conflicts resolved by using the content from the branch
> =A0being merged *from*.
>
> =A0BASE contains all of the resolved merges from NEXT, with any
> =A0remaining conflicts resolved by using the content from the most
> =A0recent ancestor of the two branches being merged.
>
> =A0As before, "git diff" can be used to view the differences between
> =A0these various trees. =A0For example, the following command display=
s the
> =A0conflicts that still have to be resolved:
>
> =A0 =A0 =A0git diff NEXT WTREE
>
> =A0To see how the resolved version differs from the contents of each =
of
> =A0the original branches, use
>
> =A0 =A0 =A0git diff HEAD NEXT
> =A0 =A0 =A0git diff MERGE_HEAD NEXT
>
> =A0The "git diff3" command can be used to compare three trees at once=
:
>
> =A0 =A0 =A0git diff3 OURS NEXT THEIRS
>
> =A0The previous command can be abbreviated to "git diff3".
>
> =A0[1] The trees that are stored in the index are in an internal form=
at
> =A0 =A0 =A0that is optimized for efficiency. =A0They are not stored a=
s
> =A0 =A0 =A0individual files like in your working copy.
>
> Thoughts?
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
>
