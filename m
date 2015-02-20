From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 18:06:29 -0500
Message-ID: <CAPig+cR_OaJGAR--04YWW1KHm+1UA7q7O9e4TTcZksGo9s4+8w@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
	<vpqzj8ary29.fsf@anie.imag.fr>
	<20150220020022.GC16124@peff.net>
	<vpqwq3cdhhe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOweZ-0004s1-9P
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 00:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbbBTXGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 18:06:31 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:51764 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbBTXGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 18:06:30 -0500
Received: by mail-yk0-f181.google.com with SMTP id 200so8583312ykr.12
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 15:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tDb3d7A8z5m93nNLt1LFmsGRyK0yWXu7/xDkkMfebEg=;
        b=Oeo6KxNsjrMnuWOadWC8CmrPcq3QTjg0uAkY5QAGdnYS/n4EYwq1QTpbsBEvPbVdto
         WvWS6R3Sn9QiGWamOu575tpDv8QKeNjqH3OucR2JhXlJMQB7Sjh0LifPgXJC3wXqqPJD
         2GPrCDn2GEJ3ziKC3rQwnrwpIP+ToWZIZBB2rXe8EM1Sx+YHPsdDrlp2q7GBlQb//7Ws
         9IfZis0PHdwd8Htuagdyp34kBHMFxPi8YuqHDQPwgxvGSROr9DhhKB20vRfUvqOwfO4w
         Fic72E9XPcmaq4Z6Jf/0GfA0a/dGHrcDAbsLBVbeXjq6aSGuTlYlzD49mwB8mUUjujF4
         yryQ==
X-Received: by 10.236.45.106 with SMTP id o70mr26192yhb.180.1424473589692;
 Fri, 20 Feb 2015 15:06:29 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 20 Feb 2015 15:06:29 -0800 (PST)
In-Reply-To: <vpqwq3cdhhe.fsf@anie.imag.fr>
X-Google-Sender-Auth: nC4SIFUYoBZWn87LEimryhF-xsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264194>

On Fri, Feb 20, 2015 at 5:06 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jeff King <peff@peff.net> writes:
>> I think these might be getting a little larger than "micro".
>
> The ~/.git-credential-cache may be a bit harder, but the case of
> ~/.git-credentials should follow the same pattern as files for which
> this is already done. So, doing it by mimicking existing code shouldn't
> be too hard.
>
> But maybe that's me being optimistic ;-).

As a person who did a significant number of GSoC 2014 micro-project
reviews (as well as many actual GSoC reviews), I probably ought to
weigh in and say that this may be too optimistic. In fact, most of the
GSoC 2015 micro-project suggestions[1] seem far too large and
involved.

For 2014, most of the GSoC micro-projects were extremely simple, of
the form "replace starts_with() with skip_prefix()", yet most
applicants still required three or four (or more) attempts to get it
right (and some never did), even with extremely detailed hand-holding
reviews at each step. (And, such reviews are quite time-consuming. I
was allocating six to eight hours each day to those reviews, yet I
couldn't keep up with all the submissions.)

Although quite simple, many of the 2014 micro-projects[2]
(particularly from Michael Haggerty) had a bit of a twist (or trick
question) thrown in, requiring a tad more thought and effort than mere
mechanical search-and-replace. That was useful because it helped
identify potentially acceptable candidates more easily, however, that
added twist was probably a good upper limit on difficulty for
micro-projects.

Another important aspect of 2014's micro-projects was that they could
be accomplished with only very localized knowledge: that is, a student
could read the logic of the one function being touched and learn
enough to be successful. The micro-projects did not require global
knowledge of Git internals or hours of research.

The attitude in 2014 was that it was important for students to get a
taste of what it is like working on the Git project and what would be
expected of them as submitters, and for GSoC administrators and
mentors to get a feel for the applicants by how they interacted with
reviewers. By going through the review process on a project with high
engineering standards, it also was hope that students would learn and
benefit from the experience even if not selected. Extremely simple
micro-projects (possibly with a twist) in the style of 2014's were
more than sufficient to satisfy these goals, and were more than enough
to consume significant reviewer time. The suggested 2015's
micro-projects seem far in excess.

[1]: http://git.github.io/SoC-2015-Microprojects.html
[2]: http://git.github.io/SoC-2014-Microprojects.html
