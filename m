Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554FE1F406
	for <e@80x24.org>; Tue, 15 May 2018 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeEOTHG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 15:07:06 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39975 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeEOTHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 15:07:04 -0400
Received: by mail-yb0-f196.google.com with SMTP id o80-v6so427415ybc.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fPBkQfJw41We8Y0YGLWt8enrMYIvqR1W2MgwDSEwVuA=;
        b=bFJO+InPvugZcVybOf+QhC9VL+vqVDuhHVNzmD/zZvXU0ZmvzGlDNcYf7gBpr4LLZi
         w+dbGfzZ3q9xw+BK/HdFzPEq49n47oteP1hQYi9eUcmYKOKx2EZerncXTvIVHpm8KTZP
         fUssFfQ6Kzil9isyEjE3bgSkZkkrDe9CN6p2VLVptd4AEyc1rjMRX82tbYupwsQXHCfJ
         20MGYumfkXx7nQWV3nBFniqtzrglaN9SW/sBRnaVgn1rrVR3sBoLZ3hs3f2IWt64TSsz
         IJrmNchG64gU2BCPETrI3Sg8KHOGGaA4D8ADZZ7e7SyU/Pn+c1bY+NeV3Fm8MqRccEpI
         lZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fPBkQfJw41We8Y0YGLWt8enrMYIvqR1W2MgwDSEwVuA=;
        b=lc/anucM0ZKpq65lm9K4pHlOYuGXq9YkryMEG4HzokxIO3kJPMwvXtfQTKG7XPWxp1
         X7Wh21Z94q+TfeHSh2y1jE7RxP+C0M1Yo2GUV6H5RafiMKxRXpQISZAL9n6EGXfEBgux
         8EFKlh4AmVMBmhkIs8nDuMG9kYeeIkxV3csJyb/s/dS98G22RdtXP/i/ELzomA3z45FN
         Cl0byOeQ1XM8PfHckFvRWFT+DlsoFkOhaxloKnDmtbQNQM8OyOiYjkBPqFVQgiC+mVhq
         l94+3B0Fx93i0RqZ/6aR8wfsNy+xA+FozCxUgl4NRn0tR175nkwnxvSUPa6gHQ9P/I8t
         g4Vw==
X-Gm-Message-State: ALKqPweJL+DnP/VnlhSyXkZ0QUJ0NdtLD+vE/nN2Ofy9rW/Z4+9Ay6RA
        XSVkQF476PzYh6qXEJRyON0w8KVoEk4oyEuDfNkh8Q==
X-Google-Smtp-Source: AB8JxZqYetdeOmZtRfN1skPkuxomfXRqAaKJET2BL4ffPCK02O3HANTajtAXNrUjhzMNl011aSazDZCCM+TKMr5AByE=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr9638491yba.352.1526411223304;
 Tue, 15 May 2018 12:07:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 12:07:02
 -0700 (PDT)
In-Reply-To: <xmqqmux5g2pa.fsf@gitster-ct.c.googlers.com>
References: <20180511231751.162855-1-sbeller@google.com> <20180511232840.GB41222@aiede.svl.corp.google.com>
 <xmqqmux5g2pa.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 12:07:02 -0700
Message-ID: <CAGZ79ka_8GmL9j9mTNLkbqN3xNkfCfedzs2st-tH8jMjQ2A4DQ@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: try harder to fetch a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 5:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> A more typical example would be if the ref simply doesn't exist (i.e.,
>> is a branch yet to be born).
>
> Indeed this is interesting.  At first glance I thought this was
> about underlying "git clone" failing to grab things from a
> repository with unborn HEAD, but that part works perfectly OK.

ok.

> So it probably should be more like
>
>         guard1 || action1 || warn
>         guard2 || action2 || die
>
> so that no matter what the outcome of the action1 is, the second set
> gets executed.
>

I'll resend it with a warning (using say()).

I think we have 2 bugs and this is merely fixing the second bug.

The first bug:
We had a call chain as
  git clone --recurse-submodules=<path spec>
    -> git submodule update --init --recursive $(pathspec)
      -> git submodule--helper update-clone # will clone
        -> git submodule helper clone
          -> git clone --no-checkout --separate-git-dir ...

The call to the "git clone" produces an interesting
submodule state:

  $ git init confused-head
  $ (cd confused-head && git branch test \
        $(git commit-tree $(git write-tree) -m test))
  $ git clone --no-checkout  --depth=1 \
        --separate-git-dir=test.git confused-head/.git test
Cloning into 'test'...
warning: --depth is ignored in local clones; use file:// instead.
done.

  $ git -C test.git config remote.origin.fetch
  $ echo $?
1

(A) Despite the warning of --depth having no impact, the
  omission thereof changes the repository state.
(B) There is no remote.origin.fetch configuration, which
  is weird. See builtin/clone.c:830, that states for this case:

    /*
     * otherwise, the next "git fetch" will
     * simply fetch from HEAD without updating
     * any remote-tracking branch, which is what
     * we want.
     */

I disagree as the next fetch will be confused
(HEAD is not advertised on the next ls-remote)

The patch that is under discussion here is merely
papering over the effect of having no fetch spec,
by allowing the second fetch (fetching the sha1 directly)
to run, which ignores the configuration as a refspec is
given.

However it is still a bug, as such repositories are out there,
which is why I said there are 2 bugs initially. It's just that
the first bug enables the second bug.

Thanks,
Stefan
