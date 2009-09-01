From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Tue, 01 Sep 2009 12:09:48 -0700
Message-ID: <7vmy5eiirn.fsf@alter.siamese.dyndns.org>
References: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
 <7v8wgzla02.fsf@alter.siamese.dyndns.org>
 <ac3d41850909010958l890bf2fyda6e61e3cb082c2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiYk6-0001uV-Ly
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 21:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZIATJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZIATJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 15:09:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZIATJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 15:09:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 161A421DA0;
	Tue,  1 Sep 2009 15:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=z/s8qVrvsoGn
	dz/AZIzbB1k8hX8=; b=GXrb7mCQxWRM7S84ewHXv6nIto3LGkQStgvScUAyBJiF
	AFpt73Z1BHC5zozeoUrC3rM7PbL+/PIoGDVcbExgNhxJ+Az3BVZ7DeQLTX+VOUw3
	Cz38zFeLGPt0Z/u1WsgzMVs/23UsXm0uHvvTpeTbb0DAxYF2F8Jt5/ssNdv/GpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UbwtKC
	8AG6yZFFl+F4lpPUb6OPmgCd0xm3jHX+vcMTjF+Eg7aFGz8r+ijpLqokJwXj5Gl5
	G+n9H8SU/X0LZnWrLE1mDm4jftlCnXOAqgzw9fREFxhuDasgSJe2TkrX9AD/jdUQ
	g+nd8Ar3cpk4gNZRIl6WKdymTTj9zaBhoHqrc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBB2121D9C;
	Tue,  1 Sep 2009 15:09:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F89421D9B; Tue,  1 Sep
 2009 15:09:50 -0400 (EDT)
In-Reply-To: <ac3d41850909010958l890bf2fyda6e61e3cb082c2a@mail.gmail.com>
 (David Chanters's message of "Tue\, 1 Sep 2009 17\:58\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 087B6CA4-972B-11DE-802C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127549>

David Chanters <david.chanters@googlemail.com> writes:

> 2009/9/1 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0 =C2=A0$ git log --oneline --first-parent origin/master..origi=
n/pu
>>
>> would be a handy way to view where the tip of each branch is.
>
> Yes it is - thanks for that!  I presume that (in other workflows --
> not necessarily git,git's) that using git-resurrect.sh would be
> preferable to the git-log suggestion above if the topic branch wantin=
g
> to be "resurrected" had several merge points?

AFAIK the script is an (attempt of) automating the inspecting of the ab=
ove
output and manually choosing which one to use.  As automation, it may b=
e
handy, and as automation, it may have bugs ;-).

> Makes sense - and on that note - in our current workflow of using Git=
,
> we have a feature branch, call it "featureA" which is forked from
> "master" (where our stable code lives) -- but obviously over time, if
> bugfixes happen and get released, what do we do about then ensuring
> that featureA also benefits from these bug-fixes?  Since invariably
> people will want to develop using the bug-fixes, but "featureA" long
> since branched from "master" at a point in the past, before the
> bug-fixes?

That is one of the most common misconception people new to the topic
branch workflow have [*1*].

In general, you do not want to merge fixes or other changes from
integration branches back into a topic branch such as featureA.  The
purpose of a topic branch is to brew the topic and the topic alone in
isolation to perfection.  Once you start merging 'maint' or 'master' in=
to
'featureA', the output from "git log featureA" ceases to be "the work I
did to polish the feature A".  The branch becomes "this contains the wo=
rk
related to feature A, but overwhelmingly consists of other unrelated
random stuff".  It would be useless as a topic branch, because you cann=
ot
tell which ones are the changes to achieve the goal of the topic anymor=
e.

When you test featureA, you would test the topic branch itself, and whi=
le
doing so, you will of course see bugs that have been fixed since you
forked from the mainline.  Do not get distracted by them; you did not f=
ork
the featureA topic in order to fix them in the first place!

Of course, when you test the whole system including the addition of
featureA, you would want to make sure that fixes and enhancements that
happened on the mainline since you forked the topic branch work well wi=
th
what you did on the topic.

=46or that kind of integration testing, either use a temporary branch t=
o
test trial integration:


    $ git checkout -b test master ;# start with everything else they di=
d
    $ git merge featureA ;# ... and try my topic with that
    $ test..test..test

and once you are done, you can get rid of the test branch

    $ git checkout master
    $ git branch -D test

You can alternatively have a dedicated branch for early integration
testing.  That is what 'next' branch is used for in git.git project.

    $ git checkout next
    $ git merge featureA ;# ... merge the update
    $ test..test..test
    ... yeek, my changes were buggy ...
    $ git reset --hard HEAD^ ;# get rid of the change
    $ git checkout featureA
    $ fix..fix..fix
    $ git checkout next
    $ git merge featureA ;# ... try again
    $ test..test..test
    ... this time it is good and I am happy ...


[Footnote]

*1* I think I have had a chance to answer this question in a lot more
detail at least twice in the past couple of weeks on this list, and bot=
h
times it was very frustrating for me, not because I did not want to ans=
wer
them, but because I've written it in length in my upcoming book but
pointing to it would not help people who asked the question because it =
is
in Japanese.  I've been writing on a handful of topics I thought were
worthy of general consumption on my blog while writing the book, but th=
is
is one of the topics that I haven't "backported" there yet X-<.
