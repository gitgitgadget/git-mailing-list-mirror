From: Stefan Beller <sbeller@google.com>
Subject: Re: Git GSoC 2015
Date: Tue, 17 Feb 2015 16:05:24 -0800
Message-ID: <CAGZ79kbFntyRSgNraz_UG6GstSDCvNZeg5_e1daFYnUGjDpFJg@mail.gmail.com>
References: <20150212093435.GA20118@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 01:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNs8w-0003z3-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 01:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbbBRAF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 19:05:26 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33476 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbBRAF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 19:05:26 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so33298662igj.4
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kqQqP5yHR0rs+kT3ddE8qaqbKm3oTXC494qLHPwJ/bM=;
        b=OlDmTQsSmOZNQ9a2mwC0+rETjso8cIOBbVrNAYr4n5o5iZ0OCCsTG3SQjG9IcFoEWY
         hLbAQZSjAMeNDDYGbiFAk7T3eYTLWzD50ujqFO6G9/bY6C1ngP8nmy8adHHisUZlc0Wb
         Vf5F6RQuYvB/Ks/xKn/qp/Ibp3Jj5aEi8DMqt9qRcYsptYDYrvEAftDZdeFMpkw4Jjph
         2s8fcg/c2QbBF44ZjRdaLBOpy8IZfyBR68fLAGN6RpQPBLmnvz22oQCATTXDmIRDkPID
         nMHrioeb9ALuNTmMk8PlVz7T0bhlDGhCrTvCkzNxRgZkZUASYnUqRMZMNbXtEgiwbjKC
         JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kqQqP5yHR0rs+kT3ddE8qaqbKm3oTXC494qLHPwJ/bM=;
        b=Po7YElRfWbQ0FCpsfAQx6pKbkAoUUpTqr5DeoTiLLcmUj3QXmCdb/liofrRzeX6cwq
         stOJKisXjucnY9I7SbJrm0c45thtipwf3L4pcbWVIloqq4ZkK7trzJDbP8SDN9VJzEkb
         0Bklc+Sj0iXQKdZoyKvG06Ao4ewBfGGlCre1BVYVyvPcrHoSw/WB1HEvB1p2cU2CQEhP
         5NIp5242X1xq6Y7GtxVDgIjIT6MJjTbBV5ZozMfdbiINdz4RezTKmejBE5VRKNO4mMMg
         WjxG6smZV8jJ6+vA6sKwYKTGwB9lOeOJMNhnKQ3+R74KKlebXRW2LHtMCmrRAGNHWihr
         Is/w==
X-Gm-Message-State: ALoCoQnPaWQDsfwX7Y+34e3TQOVc7yDBhn6MWLby8iR/U8sSIHsnp5QcN5JRRopR71gdc+fIqnMC
X-Received: by 10.50.108.108 with SMTP id hj12mr30918500igb.47.1424217925007;
 Tue, 17 Feb 2015 16:05:25 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 17 Feb 2015 16:05:24 -0800 (PST)
In-Reply-To: <20150212093435.GA20118@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264002>

On Thu, Feb 12, 2015 at 1:34 AM, Jeff King <peff@peff.net> wrote:
> The beginnings of the Google Summer of Code deadlines are upon us again.
> Organization applications are due February 20th (next Friday).
>
>  - Do we want to do it?
>
>  - Who would like to volunteer to be the org admin?
>
>    I would like for it not to be me again, but I can help walk anyone
>    through the application process (which largely just pulls from the
>    prior year's application).
>
>  - Any thoughts on procedures or lessons learned from last year?
>
>    Personally, I really liked the "micro-project" system from last year.
>    It made it easy to drop spammy candidates (because they didn't bother
>    to do a micro-project at all), and it gave us some interaction with
>    the candidates before we had to make a decision.
>
> -Peff


I have observed the GSoC last year and the micro projects seem to be
have helped a lot. Although I don't have a strong proficiency yet, I'd
may be a mentor this year?

Why do you not like to be the org admin again this year?

Thanks,
Stefan
