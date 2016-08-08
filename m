Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F502018E
	for <e@80x24.org>; Mon,  8 Aug 2016 23:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbcHHXUV (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 19:20:21 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51726 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752661AbcHHXUU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2016 19:20:20 -0400
X-AuditID: 12074411-a07ff70000000932-7c-57a913a95f62
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.6E.02354.9A319A75; Mon,  8 Aug 2016 19:20:11 -0400 (EDT)
Received: from [192.168.69.130] (p5B104332.dip0.t-ipconnect.de [91.16.67.50])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u78NK5XN020275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Aug 2016 19:20:06 -0400
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Junio C Hamano <gitster@pobox.com>
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
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
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
Message-ID: <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
Date:	Tue, 9 Aug 2016 01:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsUixO6iqLtaeGW4wbQ2NosZy/6xWHRd6Way
	aOi9wmzxZO5dZosVV+cwW/Qv72Kz+L8g3+LxwyWsFt1T3jJa/GjpYbbonCpr8emEm8Xmze0s
	FmfeNDI68Hns+HyB1ePZy8lMHjtn3WX3+PAxzmPBplKP5UvXMXrcem3r8fBVF7vHs949jB4X
	Lyl7LH7g5fF5k1wATxSXTUpqTmZZapG+XQJXRtuK5SwFndIVE+Y/ZG9g/CLaxcjJISFgInH2
	6GXmLkYuDiGBrYwSbeu+MUE4Z5gkjm2+x9jFyMEhLJArcf1NKkiDiICaxMS2QywQNa9ZJfra
	rrGBOMwCx1kknmxfwwRSxSagK7GopxnM5hWwl1j/dAkziM0ioCJxv7UZzBYVCJHYdrOBDaJG
	UOLkzCcsIDangLXEycWbweLMAnoSO67/YoWw5SW2v53DPIGRfxaSlllIymYhKVvAyLyKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyS+BHcwzjgpd4hRgINRiYf3wvIV4UKs
	iWXFlbmHGCU5mJREeeWnAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8NpzrgwX4k1JrKxKLcqH
	SUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CyWpwcAhcOXhkNqMUS15+XqqSBO8XQaAhgkWp6akV
	aZk5JQilTBycIIt4gBaVCoEsKi5IzC3OTIfIn2LU5Vi26PpaJiGwQVLivMogRQIgRRmleXBz
	YOnyFaM40IvCvCtBqniAqRZu0iugJUxAS5JUV4AsKUlESEk1MMZpiNe91XkqPWHfJeG6n4br
	s18K7+Mq/tl+s05sS/ze6SG2O9X/ndY6fsDuhuPeR28yC3qT0lvUWV783y8x783GuT0fzj1d
	vLHeLnjG/wcdWhl9Kl2pvfNy/wVv42GvuJxxi+Xx6shZlhkcFcen7Hji162e08scu2pt47xL
	J3sOLtS70lfmP1OJpTgj0VCLuag4EQCHeBfWcgMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/09/2016 12:36 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Is it *really* so insane to consider moving collaboration on the Git
>> project to GitHub or some other similar platform?
> 
> I only know how "pull requests" and "issues" discussion in GitHub
> Web interface _currently_ looks like, so if you have even more
> wonderful thing in the works, I _might_ be swayed otherwise,

If I did I couldn't say anyway, so let's assume that current GitHub is
what's on the table [1].

There are a couple of recent code-review improvements that you might
have missed:

* You can now get email updates about your own activity [2]. (Previously
you would only get emails about the activity of other people, which
would leave holes in the email record of the conversation.)

* There is also now better visibility of code review comments regarding
lines that are no longer part of a PR [3].

> but I
> do not think it is sane to expect that the same quality and quantity
> of reviews as we do here can be maintained with that thing.

Could you elaborate why you would expect quality and/or quantity of
reviews to suffer? I'm really curious, and I'd be happy to pass your
feedback along to my colleagues.

Here are some factors that I think will *improve* reviews:

* While you are reviewing patches, you can "zoom out" to see code beyond
the usual diff context. Currently a reviewer who wants more context has
to transition from reading the diff in email to applying the patch and
viewing it in another tool. Then the reviewer has to go back to email to
leave the comment.

* If you want to compile/run/edit/profile the code, you just need to
"git fetch" rather than messing around with "git am". For more involved
suggestions, it is possible to propose a PR against the original PR.

* It is easy to summon somebody else into the review conversation by
@-mentioning them. That person immediately can see the whole history of
the PR. (This is an improvement on the status quo, where a new entrant
to a conversation might have to dig through the email trash or an email
archive to see emails that they overlooked before they were added to the
CC list.)

* It is easy to subscribe/unsubscribe from particular discussions [4].
This makes it easier to follow the discussions you are interested in
without getting swamped with emails about other discussions. You can
unsubscribe from a discussion permanently, or in such a way that a new
@-mention brings you back in.

* It is easy to mention other PRs/commits/issues in a discussion, and
those mentions become clickable links (no jumping back and forth between
email client and web browser). Of course you can also link to arbitrary
URLs (e.g., mailing list archives).

* It is possible to search old issues and PRs for additional context.
(Granted, the history of the project from its ML era would have to be
searched separately.)

Given that I work for GitHub, I'm uncomfortable doing any more advocacy
here. If people have concrete questions, I'd be happy to answer them, on
the list or in private.

Michael

[1] In general, GitHub *does* get better over time, and we would benefit
from any future improvements.
[2] https://github.com/blog/2203-email-updates-about-your-own-activity
[3] https://github.com/blog/2123-more-code-review-tools
[4] https://github.com/blog/2183-improvements-to-notification-emails

