Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EB620401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbdFZJhR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:37:17 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38350 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdFZJhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:37:15 -0400
Received: by mail-wm0-f45.google.com with SMTP id b184so2570603wme.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nwyCooBI6mLb3x33DtDaziQuy4QqpA7n/tR8Mnd3Ruo=;
        b=mmCR9fB+R5GfyIWH+cok5Y7Fn6sAFgAiuNmcjyWimOQcyr3gr6bURPknuP3jzn3ZlT
         RTi9+LF2wGFemrKkOxBmthrN27LQ43TBFbGJ/eNUuwS8ZNaaGQCcZAc4eV2ADBFl8ih5
         UCBX3Eh2ZxGMCfJpFZLS0iKNgLTKo9jqVVhDF8vkvlZySBVbW1mmHAfe9mY0CCo5oIJq
         K+mCr/yKjKt3UrOclzAk+w0q1CE8I0mjz/9QD9jdLi7yF7Wwey+PmCAzjAXRyXoFhBHd
         l1ZWVXMBbAk9ilq8GVpZDoXKEuFQShomP8yd+MOf9P1D4XS7/ZvpEFnOQasck3RQuB89
         jYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nwyCooBI6mLb3x33DtDaziQuy4QqpA7n/tR8Mnd3Ruo=;
        b=dz8f9AkT1avTv687VrHQUVmWo2IVcT1UJ/UkL4mqM8+yUP/tAlaVJL/6m3vT/Kb8Mm
         xCTDi1iHNS8ZKqsTsWvQhKgXKGyoxbqwkJmzXk4C75CHpPHRppY9g+gcJRS8wikAmfhc
         p1CXIDqp5Zptul9vHs7GK9FXQIIPX5NJD35WWfcGrx+CM/G8h2DrP3U0MvJzOS8cSLVx
         EJ7he305gFr+xDNhBrw4CN2WhvN4WzfpKIVlaXz5Qi/ddBz2aNDxLv51L2MFY0eKBBEp
         pm08EBX6/xE6LcFUMgV9A5rBZYgFbE8Wf+IFLnU9cBxTHz/rBlGP795OdcyMcWqpj5gX
         ojQw==
X-Gm-Message-State: AKS2vOxiTicJFkACmuRDW/EJxQOMTgkfKRZOdv0K7ZE5Viar353TLKCP
        0uOBMO4e7w/7SZsY8/lO+pVAF+P5kQ==
X-Received: by 10.80.172.197 with SMTP id x63mr2734570edc.4.1498469834226;
 Mon, 26 Jun 2017 02:37:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.179.145 with HTTP; Mon, 26 Jun 2017 02:37:13 -0700 (PDT)
In-Reply-To: <xmqqy3sf7mxo.fsf@gitster.mtv.corp.google.com>
References: <CAGHpTBLP9MiYr2ZoUOaGjGMC+aO_EKYO6SwNLfAu6QFSRnPatQ@mail.gmail.com>
 <xmqqy3sf7mxo.fsf@gitster.mtv.corp.google.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 26 Jun 2017 12:37:13 +0300
Message-ID: <CAGHpTB+xL1h=1mEssgkTeJbKjQu_iiHrTABWJFgsGfUXitLUnQ@mail.gmail.com>
Subject: Re: Getting first tag per branch for a commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2017 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Orgad Shaneh <orgads@gmail.com> writes:
>
>> What I'd like to have is a way to tell the first tag per branch (or
>> per merge) that the commit appeared on.
>
>> I think that this can be done by filtering out tags that are connected
>> to already listed tags by first-parent link.
>
> Yes.  When one tag can be reached by another tag, then the former is
> definitely an earlier tag than the latter.
>
> A trivial way to compute it would require O(n^2) invocations of "git
> merge-base --is-ancestor".  Alternatively, I think you can perhaps
> use "git merge-base --independent".

I think this feature needs to be implemented in Git (by a flag to git describe).
O(n^2) is way too much when you have 20,000 tags.

Unfortunately, I don't feel qualified for implementing it myself. Does anyone
else volunteer? :)

> Having said that, one thing to keep in mind is that a single "first
> tag" may not exist at all.
>
> Consider this topology:
>
>           o---X-------.                topic
>          /     \       \
>  ---o---o---o-------o---N---S---o---   maint
>      \           \   \           \
>       o---o---o---M---o---o---T---o--- master
>
> where a topic branch was forked from the maintenance track, which is
> periodically merged to the master branch.  That topic branch has the
> commit of interest, X, which first gets merged to the master branch
> at merge M, which eventually gets tagged as T (i.e. a new feature
> release).  But (wall-clock-wise) after merge M is made and the
> change is tested in the context of the master branch, but before the
> release T happens, the topic may be merged down to the maintenance
> track at merge N.  Then eventually the tip of the maintenance track
> is tagged as S (i.e. a maintenance release).
>
> Topologically, T and S cannot be compared and they both contain X,
> so the question "what is the first tag on 'master' that has commit
> X?" does not have a single unique answer.  Both S and T are eligible.
>
> You could define various heuristics to tiebreak among these tags.
> You may be tempted to compare timestamps of S and T.  If they were
> equal, then you might want to compare timestamps of M and N.
>
> But you'd need to accept that fundamentally there may not be a
> single "first tag".

I accept that. Anyway, this looks to me like a corner case, and I don't mind
having several tags from the same branch for this case.

- Orgad
