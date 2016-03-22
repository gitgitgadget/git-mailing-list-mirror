From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Tue, 22 Mar 2016 11:00:39 +0100
Message-ID: <56F117C7.2030900@drmicha.warpmail.net>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
 <56E6D8C4.2010205@drmicha.warpmail.net>
 <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
 <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
 <56E96096.4020108@drmicha.warpmail.net>
 <CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
 <CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
 <xmqqr3f3lhvw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:00:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiJ7H-0001HU-0M
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 11:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357AbcCVKAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 06:00:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37972 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758463AbcCVKAl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 06:00:41 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BB5BD20BA8
	for <git@vger.kernel.org>; Tue, 22 Mar 2016 06:00:40 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 22 Mar 2016 06:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=L/0x0L9rAbJoxdgnxtcxH1gWP6M=; b=njqBwS
	zbHodSknIzqPFEp1vOdXZYqkqMKLp5Yhj97//EO6RR0zgjAjNqORZ9uo5KO/Vh+B
	NKg6yeRfpu6+ZGuscHaNvfDb7Z6IozzWVHDRNeEpk4ZfRf5JnApoZ22kAksnM+q7
	EjhP/7XPaVNKg9oemGowbxxLw6ZUm95VyDR9U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=L/0x0L9rAbJoxdg
	nxtcxH1gWP6M=; b=DhRHPM8qnkDTXPmKmVoK+r9OdZHEUlp+LSVhJNmvVZGNUGs
	+3xmYvh8e0YD6Zv6uhuMehB3XXULcTPqhU2o28trmQtiDgolcHeq8NVxvOR2hOcM
	TkmJ7fad+pZ9W/qIEVgc2ykgX4QQK6kW8T1JozUKdbFGKIhIJP1Xkaypk4Do=
X-Sasl-enc: 60Kf8+8T7bXWLDFdvJZeZQnx3DGqsSpv/7qzHi5qyBwl 1458640840
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1B094C0001C;
	Tue, 22 Mar 2016 06:00:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqr3f3lhvw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289501>

Junio C Hamano venit, vidit, dixit 21.03.2016 21:01:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I think this is a general question about how to track build
>> products.  The proper place may be in a tree that is referenced
>> from a note or so.
> 
>> Maybe I shouldn't consider git.pot a build product - I don't know,
>> as I honestly don't know why we treat it the way we do.
> 
> I think your LaTeX output analogy is interesting.  When working with
> other people editing a single document, each person may update the
> build product (.dvi or .pdf or whatever) in his branch and when you
> merge other people's work, this would create an unresolvable mess
> but that is perfectly fine, because you wouldn't even attempt to
> merge the build product.  Instead, you would merge the source
> material, run the formatter, and pretend as if its output is the
> result of the merging of .dvi or .pdf or whatever.

I have to confess that that is actually my main use of git outside of
git.git, and that my "solution" is tracking .pdf etc. and using a
pre-commit (and pre-merge) hook that prevents me from commiting a state
where "make -q" is not successful. Still not perfect, partly due to the
fact that make is timestamp based, not checksum based. ("Use scons", I
know...)

> But then we need to step back and consider the reason why we keep
> the build product in the first place.  Presumably that is to help
> those who want to consume the build product without having the
> toolchain to build from the source. 

That is certainly a good use case - see, e.g., our documentation. On the
other hand, "make pot" has very light toolchain requirements compared to
"make doc".

Another use case is a "poor man's release accountability" - a build
result depends on the actual toolchain version also, not just the
source, and tracking a build stores a copy of a build result that you
handed out in class, deployed somewhere, ...

> If that is the case, perhaps it
> is also a valid workflow for these collaborating authors of a single
> document not to update the build product, if they know that nobody
> cares about how the final output looks like on their individual
> fork, until their work is merged to some "mainline".

Wouldn't that reasoning imply that there's no point in tracking at all?
That is, in tracking in the main tree.

> The primary consumers of git.pot build product are the l10n teams,
> and I do not think that they want to (or it is practical to ask them
> to) work on translating new messages on individual topics code-side
> people work on.  So perhaps it is a valid workflow to leave git.pot
> behind until i18n coordinator declares "it is time to catch up" and
> regenerates it at some "snapshot" time in the development cycle.

Yes, I just think that "git.pot" in the main tree sends a wrong signal
because it is out of sync in the sense that it is not "make pot"-clean.
The main tree is the place for snapshots (especially not non-rolling
ones). Possible alternatives:

- Do not track git.pot at all.
It can be recreated easily, and (unless I'm horribly mistaken) only l10n
people need it ; everyone else needs the .po files, or rather .mo.

- Make po/ a submodule.
Submodules are exactly our way of stating "this depends on a tree with a
separate history and/or different release cycle; commit bar in the super
project is 'based' on commit foo in the submodule (but not the other way
round!)

- Do it like the extra prebuild doc-branches.

- Snapshot with tags (similar to github releases).

With current master at 047057b, the contained git.pot is actually not
(guaranteed to be) the one containing the translatable strings from that
tree. If you want to find out which one, you'd have to "git log -1
po/git.pot" and rely on the fact that Jiang's tree actually does keep
git.pot in-sync.

Somehow, submodules seem to best represent that one-way dependency. (I'm
not a submodule user at all.)

Michael

P.S.: git.pot is both a build product as well as a build/install
requirement, so my tex/pdf analogy does not apply fully.
