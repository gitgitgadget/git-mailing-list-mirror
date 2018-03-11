Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594391F404
	for <e@80x24.org>; Sun, 11 Mar 2018 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeCKQdc (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 12:33:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38304 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932154AbeCKQdb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 12:33:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id n7so13332663wrn.5
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEd2VnhFcbYMQEdh8Xu0h9FKXOaL/F/54aAJ4XHEVEY=;
        b=ltAsxsjTNOOInEXBdDMpAKQkarRrulP4TpYLLh6vciqvjWi7sgZghdbzflefiURvjl
         Fr69HnrXOJL5VrysKiqmiNq6WkotfqKZXFqNUEPX4uU+EDDB5soOKZigNfSSVsknUJcU
         vXffC4jT1ShSWrarz7MgoXdY9+hTnSIBcJH/Ll8uz4tVuVzSunTgFnaztbMoQvN3Q0y0
         Mo1beu4bkl4BSjkoA7Y1c7R1A3DEjA5eW6OU7P0/rN0qbFy+s1psDT52AZF+dXNPOwsy
         KSUWQW0cjsIhfHnE/Ahg/UmJjxozYmVdi5GwT+X3aAd0grMqKEUJvovAliRAIpniZ8Xh
         wnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEd2VnhFcbYMQEdh8Xu0h9FKXOaL/F/54aAJ4XHEVEY=;
        b=bVAVcQ7SZU2NlHH+6jee8/Vkg2OcvV6YRbae7jFHV9dA4zszMZCm5N07BuWLLMbvYR
         Crz9a3mvqPG/zcXq7ysY7NqnYs310+fgK3IE0s1rtcCQwegKd9MkpJWi4lWD73GWc2ZD
         lko2AR243g2taPBR9TnhF/ysLStxiKMtJ7JAtqAPdnJ4FNzyniGzTcVuT0ZW6jzy/aJ7
         ytJMo+qN71aVCbDLpUxOnrQ18/1UgXWl8o1dPxpU5BOw8dMaeoSU/RJLT3hL4a3f5c52
         89L+p3REjZbHZS9MFUK249hxM+BCJQNUqSsqvwV/4vKENFFhFUlaXcbxNkXUONJz7mYI
         x67w==
X-Gm-Message-State: AElRT7GHy8t/g6NLMGaXPuyJgUEzxZnHW24I+tuySkkA2h2OItOqoEl5
        wB+n979/i3t1Qfz1OQFsN/I=
X-Google-Smtp-Source: AG47ELsHiLwBoXHnTyizUZZUc7im1DSsaVVp3oaWRHOz/Lm/cPhQ8rKWBsmy7yLWmq4tzfZq5K1QJw==
X-Received: by 10.223.196.132 with SMTP id m4mr1345975wrf.9.1520786009723;
        Sun, 11 Mar 2018 09:33:29 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p29sm3738739wmf.3.2018.03.11.09.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 09:33:29 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
 <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
 <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
Date:   Sun, 11 Mar 2018 17:33:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 11/03/2018 13:00, Johannes Schindelin wrote:
> 
> > I actually like `pick` for _rebasing_ merge commits, as `pick` is 
> > already used for rebasing non-merge commits, too, so it feels natural.
> 
> Phillip is right, though: this would repeat the design mistake of
> --preserve-merges.
> 
> We must not forget that the interactive mode is the target here, and that
> the syntax (as well as the generated todo list) must allow for easy
> modification. The `pick <merge>` approach does not allow that, so we
> cannot use it.
> 
> The `merge -R -C <original-commit> <merge-head>` approach is a lot better:
> it offers the flexibility, without sacrificing the ease when not modifying
> the todo list.

Eh, I`m afraid the quote you took is missing the rest of its 
(important) context, where I mentioned already proposed format for 
`pick` in that other subthread[1], including other parameters beside 
merge commit to pick, as that parent mapping.

I agree with both of you that `pick <merge-commit>` is inflexible 
(not to say just plain wrong), but I never thought about it like that.

If we are to extract further mentioned explicit old:new merge 
parameter mapping to a separate discussion point, what we`re 
eventually left with is just replacing this:

	merge -R -C <original--merge-commit> <merge-head>

... with this:

	pick <original--merge-commit> <merge-head>


That is what I had in mind, seeming possibly more straightforward and 
beautifully aligned with previously existing (and well known) 
`rebase` terminology.

Not to say this would make it possible to use other `rebase -i` todo 
list commands, too, like if you want to amend/edit merge commit after 
it was rebased, you would write:

	edit <original--merge-commit> <merge-head>

..., where in case you would simply like to reword its commit 
message, it would be just:

	reword <original--merge-commit> <merge-head>


Even `squash` and `fixup` could have their place in combination with 
a (to be rebased) merge commit, albeit in a pretty exotic rebases, 
thus these could probably be just disallowed - for the time being, at 
least.

The real power would be buried in implementation, learning to rebase 
merge commits, so user is left with a very familiar interface, slightly 
adapted do accommodate a bit different nature of merge commit in 
comparison to an ordinary one, also to allow a bit more of interactive 
rebase functionality, but it would pretty much stay the same, without 
even a need to learn about new `merge`, `-R`, `-C`, and so on.

Yes, those would have its purpose, but for real merging then 
(creating new merges, or recreating old ones), not necessarily for 
merge rebasing.

With state of `merge -R -C ...` (that `-R` being the culprit), it 
kind of feels like we`re now trying to bolt "rebase merges" 
functionality onto a totally different one (recreate merges, serving 
a different purpose), making them both needlessly dependent on each 
other, further complicating user interface, making it more confusing 
and less tunable as per each separate functionality needs (rebase vs. 
recreate).

I guess I`m the one to pretty much blame here, too, as I really 
wanted `--recreate-merges` to handle "rebase merges" better, only to 
later realize it might not be the best tool for the job, and that a 
more separate approach would be better (at least not through the same 
`merge` todo list command)...

Regards, Buga

[1] https://public-inbox.org/git/f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com/
