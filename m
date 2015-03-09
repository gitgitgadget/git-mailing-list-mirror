From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Promoting Git developers (was: Bashing freelancers)
Date: Mon, 09 Mar 2015 14:57:09 +0100
Message-ID: <54FDA6B5.8050505@drmicha.warpmail.net>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Christian Couder <christian.couder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 14:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUyBI-0005cW-V7
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 14:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbbCIN5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 09:57:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57093 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbbCIN5L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 09:57:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 945842164B
	for <git@vger.kernel.org>; Mon,  9 Mar 2015 09:57:09 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 09 Mar 2015 09:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cbCeD0CwvFFN334kyNQjc5
	EE1o0=; b=Uw9HYPj4V7O1GmNyHqBqYeOfXvIrVyAoehGsFW4hz71qk5McpPqg/L
	ohtRn6LfY/mr2MHxaHzmts51NHuxx5AaxScvFhxeLnqtb/PJrytHu90cmQFpTKN/
	k0aCpfh/okBehTOU7AHnoUM7KzUZdKffXZoy92YXOglYQtY1/Lr00=
X-Sasl-enc: T1S0k3vE19tI1nrVfYIh5aoYkRtwDMkysUEI3a/TUXYo 1425909430
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5226CC00297;
	Mon,  9 Mar 2015 09:57:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265165>

Christian Couder venit, vidit, dixit 07.03.2015 08:18:
> Hi,
> 
> On Fri, Mar 6, 2015 at 6:41 PM, David Kastrup <dak@gnu.org> wrote:
> 
>> At some point of time I think it may be worth reevaluating the toxic
>> atmosphere against freelancers doing Git development.
> 
> My opinion on this is that the Git community has not been good
> especially lately at promoting its own developers.
> 

I guess we have at least 3 kinds of people here:

A) Paid to do Git development, at least as part of their job.
B) Freelancers who don't get paid directly for "doing git" but hope to
profit from their git efforts directly or indirectly.
C) Doing it in their freetime (or as minor, inofficial part of their
non-programming job).

I'm in camp C and honestly wasn't aware of camp B until now.

I consider camp A to be beneficial for all of us, and I don't think
specific employer interests have pushed the project in specific
directions, or specific features (OK, maybe one, but not as a rule).

I do see that remuneration is an issue for camp B.

> Some facts:
> 
> * There used to be an AUTHORS section in each of the git man page.
> They have been removed. The rational was that they were hard to
> maintain and the information about authors was easily available
> elsewhere.

I'd say it's difficult to do this in a fair manner, since most pages are
a community effort now in the best sense.

> * There used to be a nice page on git-scm.com, the main Git web site,
> listing the authors and how many commits they had contributed. It has
> been removed.

It was out of date again and again, and pull-requests took forever. The
problem here still seems to be the old dis-connectedness between that
website and the developers' community. But it's the only one "we" have.

Since we're talking business: git-scm.com still looks a bit like a
ProGit/Github promotion site. I don't have anything against either, and
git-scm.com provides a lot of the information that users are looking
for, and that are hard to find anywhere else; it's a landing page. It
just does not look like a "project home".

> * In the "A note from the maintainer" emails that Junio regularly
> sends, the last section about "Other people's trees, trusted
> lieutenants and credits." seems to have been truncated for some time
> and doesn't show anymore the nice "credits" words it used to show.
> Maybe this is a bug.

Being in camp C, that entry in "credits" was my remuneration, so-to-say,
and I missed it when it was gone. OTOH, I do understand how tedious it
is to keep that up to date and fair. (And if, I should probably have
been removed at some point...)

There still is "git rev-list --count --author=Mickey origin/master" :)

> * https://www.openhub.net/p/git/contributors/summary seems to give me a
> "504 Gateway Time-out" right now :-(

I thought there is ohloh, but that one is the new ohloh... Anyways,
Junio's repo on github is "official" in a sense and has this:

https://github.com/git/git/graphs/contributors

> * On the Git Merge web site, we can see that none of the speakers
> seems to have been a very active contributor to git.git

Yeah, that's more an "outside business window into git". In fact, while
that doesn't quite intrigue me, I would think it's a great chance for
freelancers to get in touch with people doing business with git.

And maybe they'll be talking about what they're using git for, and which
technical and non-technical challenges they meet in doing so? Edward was
fun to listen to in Berlin :)

Git merge itself is organized and sponsored by businesses with business
interests. But there's also the contributors summit. Git merge Berlin
was great and generous in that respect.

> None of these facts is a big issue in itself for me, but I think the
> trend is very sad, and I would be happy if we could discuss here or at
> the Git Merge (or both) about ways to improve in this area.

There should be a good occasion, after we see how it went, and hopefully
also to sort out any apparent misunderstandings from the past that have
resurfaced in this thread.

Maybe, all we need is badges? [1]

Michael

[1] https://badges.fedoraproject.org/
