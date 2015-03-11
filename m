From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Tue, 10 Mar 2015 19:36:34 -0700
Message-ID: <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Mar 11 03:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVWVu-0002MT-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 03:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbbCKCgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 22:36:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750785AbbCKCgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 22:36:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57CC63F640;
	Tue, 10 Mar 2015 22:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CqAiDAsibJdoO/eMN6UYjjvzN98=; b=RbcyRT
	chZbXvIcxbNrkObJHj6yNNUu88e9cPxN3vEqsDqUkOtjFViWIrpnLKMbWqUsNHLR
	dl1g5JPB0mjvVUNyAxSeREWgEhxU+ZS9IEnwwsZ2cRDgH6j+nirn0ioAbjd6hyMI
	DNPIRDT/AoqEUmk1nVJkinaczps2SfnNUd2hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gV5K4/hmmiCeQDFQmpoBqHRh9IfVIiSy
	xlK8s7dCuYyqsMURTr60UxYq6bxLISuN0GQdfkHD3vkZWxFEWTr4g2dM/cUyT7uV
	2HO7ByKf7cFlMaTniMOyF8ldymuqAFx0U1bD4bimlzCiT5q+1qkCuj41nGqdyl0u
	N1fLGpe2vPI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5044F3F63E;
	Tue, 10 Mar 2015 22:36:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9C873F63D;
	Tue, 10 Mar 2015 22:36:35 -0400 (EDT)
In-Reply-To: <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	(Jason St. John's message of "Tue, 10 Mar 2015 21:04:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6FCEEDD4-C797-11E4-B36C-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265290>

"Jason St. John" <jstjohn@purdue.edu> writes:

> In the Git release notes for something like "git foo
> learned a new option --bar", a simple "(Thanks|Kudos) to John Smith"
> at the end of each bullet point may be a good way to recognize
> developers in a concise manner without needing to dig through the
> output of "git log" or "git shortlog".

I doubt cluttering the list of features and fixes with peoples'
names is such a good idea. Earlier we did not have any detailed
release notes and instead said "you can go read 'git log'", which
did not help the end users who need to know what changed before or
after updating their Git, and I started doing the release notes in
the current format to help them. We must not forget that the primary
audience of this list of features and fixes is the end user. They
need a brief birds-eye summary, and the briefer and the cleaner we
keep it, the better.

Besides, it will be a lot of work to dig "log" for topics and then
go back to list archives to see who originally raised the issue
before even the first edition of the patch was written and who
contributed the ideas to help the author during the review
cycles. Doing that for a topic that needed to get rerolled multiple
times will take a lot of work, as the backlinks to previous round of
discussions are often available only in human-readable form.  And
the list of people who helped will have to be updated when a
follow-up bugfix topics are merged [*1*].

All of the above would add too much busywork on my plate [*2*].

Do people want to see me doing busywork, or spending that time on
reviewing, suggesting improvements, rejecting crap and applying
patches [*3*]?

> Or if that would make the release notes too cumbersome to review, what
> about using systemd's method? systemd's release notes include a
> "contributions from" section at the very end that lists everyone with
> a patch included in the release.

I can add "shortlog --no-merges -s -n v2.3.0..v2.4.0" at the end of
the e-mail when the release notes is sent out. That might be a good
enough balance between the usefulness of the release notes to its
customers and giving credits to individuals in a way a bit more
visible than "if you are interested, run shortlog yourself" [*4*].

Thanks.


[Footnote]

*1* Anybody remember "Git traffic" [*5*]? There was this great guy
who have been summarizing the kernel traffic and soon after Git
project started he did one edition of "Git traffic", summarizing a
few weeks' worth of Git mailing list discussions, who came up with
what idea, how that idea was discarded, what decisions were made, in
readble form. Unfortunately, there was only a single edition of "Git
traffic" ever published---and I can understand why. During that
"inflation" age of Git, we discussed so many topics and so much was
achieved in a very short period of time. It would have been
impossible for any single person to follow and report on all that
was happening in the Git land, unless that person wasn't Linus or me
or a handful of other people---but all of us were too busy with the
discussion and programming to do a summary. I really wished the
publication continued, but that was wishing for an impossible.

If you want the point-by-point kudos, you do need somebody who can
invest time to do a good job at this, and that person cannot be me
or anybody who commits text to the release notes but an attentive
and devoted reporter. An algorithm would not cut it. I suspect that
a workflow "improvement" to help a dumb tool to automatically
produce it would be too constricting and will slow me down.

*2* What we need is a group of people who are interested in this
enough to volunteer themselves to keep helping whatever kudo-giving
that is needed in an ongoing basis. We do not need people who pile
more on _my_ plate telling _me_ how to make the world better for
them and then go away without doing anything themselves. We can find
them dozen a dime and they won't help this project run any smoother.

*3* Rhetorical question. I have long learned that the key to make
sure the project runs smoothly is to push as much work off of my
plate to make sure I won't become the bottleneck.

*4* Note that it does not capture anything but "these people did the
final versions of the patches". We would not be giving credit to
others who may have offered crucial insights to help these people.
But that would give the same amount of rough estimate as the old
contributors' list Christian misses from git-scm.com, and it might
be good enough for somebody to see his name on it and feel good
about it.

*5* The site is gone, but wayback machine has a copy.

https://web.archive.org/web/20050514083018/http://www.kerneltraffic.org/git/gt20050502_1.html
