Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984122018E
	for <e@80x24.org>; Mon,  8 Aug 2016 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbcHHWUn (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 18:20:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49660 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbcHHWUm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2016 18:20:42 -0400
X-AuditID: 1207440c-22bff700000008d5-48-57a905ac840d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8D.E2.02261.CA509A75; Mon,  8 Aug 2016 18:20:28 -0400 (EDT)
Received: from [192.168.69.130] (p5B104332.dip0.t-ipconnect.de [91.16.67.50])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u78MKNH7017574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Aug 2016 18:20:24 -0400
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de>
 <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
Date:	Tue, 9 Aug 2016 00:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608041730130.5786@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsUixO6iqLuGdWW4QfM/XYsZy/6xWHRd6Way
	aOi9wmzxZO5dZosVV+cwW/Qv72Kz+L8g3+LxwyWsFt1T3jJa/GjpYbbonCpr8emEm8Xmze0s
	FmfeNDI68Hns+HyB1ePZy8lMHjtn3WX3+PAxzmPBplKP5UvXMXrcem3r8fBVF7vHs949jB4X
	Lyl7LH7g5fF5k1wATxSXTUpqTmZZapG+XQJXxvHXK5kLLipVbL83jaWBsUmmi5GTQ0LARGJD
	23n2LkYuDiGBrYwSc3d/ZIFwzjBJtP5/ytbFyMEhLJArcf1NKkiDiECixL8jf6AaWlgltl1+
	xAbiMAtMYJFY93QeE0gVm4CuxKKeZjCbV8BeYu2xA+wgNouAisS3GyvB4qICIRLbbjawQdQI
	Spyc+YQFxOYUsJFYvWkNWJxZQE9ix/VfrBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihMQXzw7Gb+tkDjEKcDAq8fBeWL4iXIg1
	say4MvcQoyQHk5Ior/xUoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3ov/gXK8KYmVValF+TAp
	aQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZDQ4OgSsHj8xmlGLJy89LVZLgvcO8MlxIsCg1PbUi
	LTOnBKGUiYMTZBEP0CItFqAa3uKCxNzizHSI/ClGRSlx3kcgzQIgiYzSPLheWFp8xSgO9JYw
	by9IOw8wpcJ1vwIazAQ0OEkV5IPikkSElFQDo/Fh+dKrfeGrvk3l6DtwVcH2o+f2oEXMb6Q+
	/+Pe+913vsXSXf7JEmqtsROtLrSt0Z9UonRenudOnOKMkF2PJ/bFZb5pOhT0PnWvQbXv7xTH
	exr7njXtcmgx+SsWbzdharvrm8KAwFtG10KeXp3iMKVq9U0DuwtLLq1SYbq8Lp85+GPSHpZX
	q5VYijMSDbWYi4oTASPjRuhmAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
> [...]
> Even requiring every contributor to register with GitHub would be too much
> of a limitation, I would wager.
> [...]

Is it *really* so insane to consider moving collaboration on the Git
project to GitHub or some other similar platform?

* Many, MANY of the most prominent open-source projects are already
using GitHub. Many potential contributors already know how to use it and
already have accounts. Casual observers (e.g., people who only want to
clone the repo and/or read issues and PRs) don't even need an account.

* Even if you don't already have a GitHub account, it is vastly easier
to create one than to set up our current contribution workflow: figure
out the correct SMTP settings for your email provider, configure
git-send-email, test it and work out the kinks, figure out how to use
git-am (and even then, actually using git-am is a tedious chore for
people who don't use an email client that can run it automatically) [1].
We've seen how difficult our current workflow is by observing GSoC
candidates attempting to send their first patch. What we haven't seen is
the invisible GSoC candidates and other potential contributors who never
even get as far as attempting to send a patch.

* Interactions that involve code are done using Git commands directly,
via exchanging bona fide Git commits. Which means that...

* Commits have unambiguous SHA-1s, which we can use when discussing
them, linking to them, merging them, etc. It will no longer be a matter
of detective work to find out whether a discussion is about v1 or v3 of
a patch series, let alone v3 with some cleanups that were silently added
by Junio.

* Discussion of pull requests can be done either
  * via the website (super easy for beginners but powerful for
experienced users),
  * by setting up email notifications for your account and replying to
those emails, or
  * via an API.
  Such discussion is all in markdown, which supports light formatting,
hyperlinks, and @-mentions.

* GitHub creates permalink URLs for all of the important artifacts:
commits, pull requests, pull request comments, etc. These all can be
referenced easily from any discussion. This web of cross-links
accumulates over time and adds a lot of context to discussions.

* GitHub keeps spam under control.

I admit that if we move to GitHub we would be vulnerable if the company
turns evil or goes bankrupt. But is that really a bigger risk than we
accepted by relying on Gmane (a one-person hobbyist operation) for many
of our historical permalinks, which are now broken? In any case, each of
us has a mirror of the code, and there are utilities for backing up
other GitHub metadata. *If* GitHub becomes evil, there will be a lot of
other open-source projects in the same boat, so I am confident that the
tooling for salvaging such information will quickly become excellent.

Currently we force potential Git contributors to learn an email-based
workflow that is almost unique to this project, rather than steering
them towards a workflow (Git plus, potentially, GitHub) that they
probably already know, or if not is worth learning because the knowledge
will carry across to most other open-source projects, not to mention
their professional careers.

We would want to set down guidelines for how we use GitHub. For example,
we might insist that each version of a patch series (v1, v2, etc.) be
submitted as a fresh pull request with references to the previous
version(s) (which also automatically creates forwards links from the
previous versions to the new version). We might want to set up some
robots to help with repetitive activities, like style review, pinging
the right people, etc.

Junio, I'm very sensitive to the need not to decrease your efficiency.
But isn't there a chance that this could *increase* your efficiency? Is
it worth an experiment?

Is the Git project really such a unique snowflake that we need to use a
workflow (and force it on our contributors) that is different than the
workflows used by most other open-source projects?

Disclaimer: I work for GitHub, but in this email I'm speaking for myself.

Michael

[1] I concede that people who refuse on ideological grounds to use
proprietary software will find this step insurmountable. Perhaps we
could come up with a workaround for such people.

