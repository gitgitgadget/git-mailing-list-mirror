Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FEB2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdBOBzv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:55:51 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35550 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdBOBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 20:55:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so5527283pfx.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BF0iAU8Rywsij+zPaa4qxdzm9UFLPdiA/dP6AHVM6lo=;
        b=N4/az5UVQMuEhML3NFZeI5bEXmDfQQoz0f0SdmJqWw+hHiNG51Z+NW+IXN5tktWdfg
         QKrGh87eYmjP8G+1Ilubhf1RccXGYR+4g/T7ICwvRe2/x19xOISCOblM6/LPFJc1YzYk
         knI9biemxY9agsZkg+uo1IHfnRgA0TeZqQVxJMwneuvaKIlAsQxnh9cX3dP6JoWH6NPt
         ltEFniD1xNTvP1XtsYKPITc18Liam6x7HkAO2nroK6Qt/gB74HAqz/B2+14QX41q+oLf
         9SrRbyd8qVfG2EYqFznq1YnUlU4zfoowvLIdb3jIHezDA2JqXxGLT1LAvoaV83UMZiwY
         BGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BF0iAU8Rywsij+zPaa4qxdzm9UFLPdiA/dP6AHVM6lo=;
        b=PYyNqUhnHqGcW8OHLiClDhYhp8GSKm0WtGNrrKWRIe/JPu1yLsGE374oVDHv0WG4lK
         nAFb3Y45fE/ZUppEtBCz2EYXFGZu+pF1bkoHAh9SLLhY/tdnKNbPQ9NDop7eGHUYGrek
         zbxb/b+iDZMEQiltCglFzvB4Hn9OiKslNyPf+hbuTfkv/cyMOklLEdcbaCPMJJN+ZK7m
         SvATtI24+cXCTVAi2E0+BRNoUJQv9nE4JlW/BxJXTYp0Vt7wODSYdPkiTbM80WLMvlX2
         LlMFMkx3uF5dDakoYX2CueL9drqKIBjI6l3xuRWCLR+fGPAyheN690NFDe4M9desG+ip
         WAwA==
X-Gm-Message-State: AMke39k/FXLsyirpMD/BXpVhWjWilBQa87fgGZfBse9kf4jQ1uGg68dite9qdEhavQB8Fw==
X-Received: by 10.98.5.2 with SMTP id 2mr35156459pff.77.1487123749996;
        Tue, 14 Feb 2017 17:55:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id v8sm3524853pgo.14.2017.02.14.17.55.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 17:55:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Herbert\, Marc" <marc.herbert@intel.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
Subject: Re: Feature request: flagging =?utf-8?B?4oCcdm9sYXRpbGXigJ0=?=
 branches for integration/development
References: <70ccb8fc-30f2-5b23-a832-9e470787a945@intel.com>
        <CACsJy8A5AXs5jQUQAdb=tuBzWYKNbu5DPnQ88DXott8ht61egA@mail.gmail.com>
        <6c7cb3da-714b-87ed-5885-220a433c646f@intel.com>
Date:   Tue, 14 Feb 2017 17:55:48 -0800
In-Reply-To: <6c7cb3da-714b-87ed-5885-220a433c646f@intel.com> (Marc Herbert's
        message of "Tue, 14 Feb 2017 16:13:32 -0800")
Message-ID: <xmqq60kc5iaj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Herbert, Marc" <marc.herbert@intel.com> writes:

>> The hard part may be policy (e.g. what if the user does not want a branch
>> to be treated volatile by various commands even if it receives such
>> flag from a git server).
>
> There would be instant, human-readable value in such a new "volatile"
> flag. Machine use and policies can be discussed later. These will be
> easier to prototype, experiment and refine once the flag exists.

We tend to avoid adding random cruft to the system whose semantics
is not well defined, so that we can avoid having to support an ill
defined feature forever.

> ... Now I bet this on the other hand must have been
> discussed (and rejected?) before, any pointer?

I suspect that people may have expressed vague wish from time to
time, but I do not think we saw a proposal that outlines the design
at a concrete enough level to let us rejecting in the past ;-)

Let me list some things that needs to be designed that comes to my
mind offhand:

 * How would a user mark a ref as "volatile"?  I am assuming that
   anybody do so in her own local repository, but how does one mark
   a ref as "volatile" at a hosting site, and who is allowed to do
   so (one possibile design is "new option to 'git push' will do so,
   and anybody who can push to the ref is allowed to", and I am fine
   with that design, but you have to spell that out in a proposal)?

 * How would a user learn if a ref is "volatile"?  Does "ls-remote"
   show that information?

 * Does volatile-ness of a ref at the remote site propagate to your
   remote-tracking ref that corresponds to it?  What does it mean
   that refs/remotes/origin/pu is marked as volatile in your local
   repository?  You cannot "checkout -b" based on it?  Does "branch"
   based on it need to be forbidden as well?

 * Can a local ref be "volatile"?  What does it mean (the same
   subquestions as above)?

 * If your local branch myA is set to build on a remote-tracking
   branch A and push back to branch A at the remote, i.e.

    $ git checkout -t -b myA refs/remotes/origin/A
    $ ... work work work ...
    $ git push

   is set to result in their branch A updated with what you built in
   myA, and if the branch A at the remote is marked as "volatile",
   does it make your "myA" also "volatile"?  How is the volatile-ness 
   inherited?  From their A to your remotes/origin/A and then to
   your myA?  Any other useful rule that defines the propagation?

 * Do we only care about "volatile"?  If we are extending the system
   to allow setting and propagating this new bit per ref (I am
   blindly assuming that you do not have a strong reason to limit
   this to branches), we may as well just design this extension to
   allow the projects to assign arbitrary set of bits to refs.  Some
   projects may want to have different degree of volatile-ness and
   have "volatile" refs, "unstable" refs and "iffy" refs, for
   example.

   Side note: even if we were to go with "any random label can be
   assigned and the meaning for the labels can be defined by the
   project convention" approach, it does not necessarily mean we are
   adding a random cruft whose semantics is ill-defined.  "Git does
   not do anything special to a ref based on what labels it has--it
   just remembers what labels the user told it to attach to the ref,
   and shows what labels the ref has when asked" can be very well
   defined semantics.

