From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 11:19:23 -0800
Message-ID: <CAGZ79kbKCRKyugTnnx34AkeqN0NDBL_J2yGky06E+263oQ_6hg@mail.gmail.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com>
	<20141209202738.GC12001@peff.net>
	<20141209222337.GA16345@google.com>
	<20141210084351.GA29776@peff.net>
	<20141210091815.GA18372@google.com>
	<20141212091625.GA9049@peff.net>
	<20141212183114.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:19:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVkP-0007hx-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbaLLTTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:19:25 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:60246 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbaLLTTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:19:24 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so2041299igd.7
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uOuUWT3ZzQPPVYQJRf99W+1ZEpbNv9U4nA8GkhYLoPQ=;
        b=XoQBjExs5m9LROGVJvAEZ5nyRkSL+8aIxEK9ezPLwWbJsfqS+gvPYqZ5WQ6RK9dPy/
         vf2lXFAEfadbYLfydszOzSaNmoXDj/v7Y6WjHS8uGfzqrsfWaRPb+bmRn6vIVuhdSRP0
         hGOfKB6qDuKSLlulssO3esBIHkdY2o0PbvXXtsVkQx8KTD/FDJ1rNF7uHg5WqL+BZOBw
         ODx7nyemRf4wB/h7UR6k0pawtORO9MbVwuSgA3xtJf4yR0u9CttoZPCq7nJ1b/JBwhLC
         K2XhdngMbxqsokHr9JaIo1jN8sSrZjKn13S2QJjzQVwsbwJNoHgpEjayDv1PYBGrVrnS
         yRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uOuUWT3ZzQPPVYQJRf99W+1ZEpbNv9U4nA8GkhYLoPQ=;
        b=P6QflBUURYENhVv5eCK4LN4hLW3b7G7iAToShnmngegRio/4B6ul8wfj25YdXFjK3o
         X0+PUhKg7mANCA5BWA64B1JXKVFxwkP4+lZdj72lSah9oXWBualoGIDn4eaZw1rmFkwB
         VvAheehTAr3xeb+LjlRrLL+clzdopIgmx9ySWGXfFa0SeKnjiGlLWiud36BPJWr8dqdh
         2c7G3/OiL3XuhrzGoGeJGEV38B0Yt0Q1frdmaZwoLb40nIYL8Aa2tpFUaX0Qw2haJ9qf
         LgQHfLJG4cp8sSAVxP7V2pe0JRj6Sa++KulRdPjB6hzGUKRpvr0kSoWYHfYsVx6zWn5n
         2yDA==
X-Gm-Message-State: ALoCoQmY8694Vy61meajDrfCyct/xJD27YS9I4qYKw31VOo6Zc3b2IusdhO+ksxfxfwR4cVbZ4hK
X-Received: by 10.43.154.196 with SMTP id lf4mr2618108icc.95.1418411964059;
 Fri, 12 Dec 2014 11:19:24 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 11:19:23 -0800 (PST)
In-Reply-To: <20141212183114.GA29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261361>

On Fri, Dec 12, 2014 at 10:31 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>
>> I'm not sure any such thought as "intended to be out of date" went into
>> it.
>
> Junio started the documentation in v1.5.4-rc1~49 (2007-11-24).  I'm
> not sure if there was a discussion preceding that commit.  My
> understanding was always that putting the documentation out-of-line
> was an intentional decision and that it was understood that the
> documentation would have cycles of falling out of date and needing to
> be updated, but I may be misunderstanding the history.
>
> Separate from the question of history, I honestly prefer this way of
> doing API documentation relative to 90% of the API documentation in
> headers I've seen in other projects.  I suspect you don't.  That's
> okay --- it's possible for rational people to disagree about things.
>
> It's moot given that we don't seem to disagree about what should be
> done about it.  Why keep arguing?
>

So you proposed an order of desirability w.r.t. the way we want to go
documenting things.

> Some possibilities, in order of my preference (earlier items are better):
>
>  1. Move documentation to header and provide a program to generate a nice
>     standalone document.

Junio agrees with that order. Michael said

> My vote is for putting the API docs in the header files:

which seems to be an agreement with your most desired way to do it.

Jeff said earlier when reviewing your patch:

> I somewhat feel this goes in the opposite direction of where we want to
> be *(all data in one place, but that place is the header)*.

which sounds to me as if he prefers also the header as the one place of truth.

I do agree on your proposed order of desirability as well. So nobody
showed up yet,
who dislikes the headers as the one place of truth.

So the open question is:
* The historic reasoning to introduce technical/api-$header at all. As
Junio mainly
  put persons to ask into the stubs in 530e741c726 (2007-11-24, Start
preparing the API documents.),
  it was probably improving the status quo back then. Maybe it was
easier to have all names in place
  than using git blame/git pickaxe at the time?
  Answering this question makes sure we don't oversee some reasons.

* Assuming we put everything into headers now, we'd need to discuss
  -> Do we want to extract it to technical/api-$somedoc later at all?
(There seems to be some disagreement?)
  -> How do we extract (plain sed for lines starting with "*", or
doxygen, or a self cooked script)
  -> How do we ensure the generated documentation doesn't get stale over time?

As I personally just look up things in the header anyway, I'd rather
get started on polishing the comments in the
headers as on arguing how to extract it. Though that's a required step
to know which format we want in the headers.

Thanks,
Stefan
