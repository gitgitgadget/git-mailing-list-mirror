From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Mon, 25 Aug 2014 10:43:30 -0700
Message-ID: <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
	<047d7b624d36142d46050131f336@google.com>
	<20140822154151.GK20185@google.com>
	<xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
	<20140822184515.GL20185@google.com>
	<20140823054646.GA18256@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:43:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyIr-0003ie-79
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbaHYRnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:43:33 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:54579 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932888AbaHYRnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:43:32 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so15492913vcb.38
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8qC7qX2PsUzTjlMsIOrZiuT+OKuW9mCJTO7Dr4rrhjU=;
        b=Pq+9rnNizFhNhWPMgZvEXFi0ZAo/FoOHlD8ZV2JI2iD9mRcM6Fb1MzS8CnTEEBIS8s
         madIqQNxj6PcoR9OTGjn19fAZTS9Po/cyy9DBGO4uThELxhCJFlZm+xFipFOapwcm8cU
         1enNXGPjmLQqLDlnmqg+EVAqEIJA0dXjoQuax6ddP4Du+MKdS3IHc64H2YCTjd/P5x0M
         +zHKgqZi095ZBKb7cJ2qlqJhpEwk41N8cljvk8tvH6UzxKyRFSvvh2Nm5sdB2qe5wvIb
         KXNQDpVCSfVmbkCL7UZ+hk+c4eeKyTtwtx60KqyVz4cWIYnghnl6Z5erm5+NfEqpYw0h
         Qy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8qC7qX2PsUzTjlMsIOrZiuT+OKuW9mCJTO7Dr4rrhjU=;
        b=ALUJcZvlUjDMOWJC/63Vq9Fdg1Fz/hIBHAyVFamZlrvZnCqawf1TW9SJNbIKRWj5/H
         8BWh8c2LDwjyRNGm6fXGhy3SEPn4StzQxM4Xou12k7bxTFSIj9aqSxX4yTRdhcFQX1C3
         qp44OriiP4qkf2QtBOGfU4wFlmYTAxkS7TF/fTskx/6mLLKs7RWpetOMgPRqf6LdG3Ss
         tFUnaxlPq5wluk3JbaYG1347RCOQpq09nA0m70chpSnbblHwLbtnK4OXJFScJZ+elsNb
         QA+JYvvtJwTzmcSUKk748cnHbjUx7sVQZAvdxh5TwBEoafwr2ONI/NQU7Oof1J0sB6HV
         dZHA==
X-Gm-Message-State: ALoCoQkAVvMSJHm/qd51ShkiwOgFQP4HmtXRtn3c1WV9xAGTq14mZZa2eBScnVBxJ6696tUqR5qv
X-Received: by 10.52.137.2 with SMTP id qe2mr14338285vdb.11.1408988610787;
 Mon, 25 Aug 2014 10:43:30 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 25 Aug 2014 10:43:30 -0700 (PDT)
In-Reply-To: <20140823054646.GA18256@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255843>

On Fri, Aug 22, 2014 at 10:46 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 22, 2014 at 11:45:15AM -0700, Jonathan Nieder wrote:
>
>> Junio C Hamano wrote:
>>
>> >                implication of which is that the 'at least one slash'
>> > rule was to expect things are 'refs/<anything>' so there will be at
>> > least one.  Even back then, that <anything> alone had at least one
>> > slash (e.g. heads/master), but the intention was *never* that we
>> > would forbid <anything> that does not have a slash by feeding
>> > <anything> part alone to check-ref-format, i.e. things like
>> > "refs/stash" were designed to be allowed.
>>
>> Now I'm more confused.  Until 5f7b202a (2008-01-01), there was a
>> comment
>>
>>               if (level < 2)
>>                       return -2; /* at least of form "heads/blah" */
>>
>> and that behavior has been preserved since the beginning.
>>
>> Why do most old callers pass a string that doesn't start with refs/
>> (e.g., see the callers in 03feddd6, 2005-10-13)?  Has the intent been
>> to relax the requirement since then?
>
> Yeah, this weird "do not allow refs/foo" behavior has continually
> confused me. Coincidentally I just noticed a case today where
> "pack-refs" treats "refs/foo" specially for no good reason:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/255729
>
> After much head scratching over the years, I am of the opinion that
> nobody every really _meant_ to prevent "refs/foo", and that code
> comments like the one you quote above were an attempt to document
> existing buggy behavior that was really trying to differentiate "HEAD"
> from "refs/*". That's just my opinion, though. :) I'd be happy if all of
> the special-treatment of "refs/foo" went away and check_refname_format
> always got the full ref.
>

There are also a lot of places where we assume that a refs will start
with "refs/heads/" and not just "refs/"
for_each_branch_ref(), log_ref_setup() (so no reflogs) is_branch() to
name a few.

This makes the api a bit confusing and hard to predict. Which
functions allow refs/foo and which will ignore it?
Are there any compelling reasons why refs/foo should be allowed?
