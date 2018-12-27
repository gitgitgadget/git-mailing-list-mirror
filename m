Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E517B211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 23:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbeL0Xoo (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 18:44:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40601 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbeL0Xoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 18:44:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so16352241edr.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 15:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1hxZoZei5eAnxkT+E3cqukOzbIX7AoYeNQ2yteKNWzA=;
        b=Ks3yLM+Vlgz/9nbZ9Ro73peFE17n/6B6WnMG9VKUDNjLA4NDhTVVOkfk7du+zNm+YT
         40dRIi6ZCpi+jsX374T8m1xo4eFKbDpPO1nx+RdI0v1BRjyxiIayHvMVlr9pgCUNjKQt
         zgdzpEZmuFy5YDilDq2B0uF/+fJEMXPjOWwabrUbaSNTXHY9ZKnDcNKWsExHcnwsyiW5
         vxm58+CHURNSKBfgfCVdpD9NLFFULRfB+H409n+BOgG5x6NTkmVAEfYofSvKdZGAVMCC
         O6HEYSFEZtqbdJ1ZzZteG2PL0BWkFLLolsUPb4Ba2v/3zVX5llfpW8l8pcNVaahHpJwS
         r6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1hxZoZei5eAnxkT+E3cqukOzbIX7AoYeNQ2yteKNWzA=;
        b=UnoEGOFcngA0LUcl9hECrbLBuUwWrXfjJ6bBNUhJQUHA7ge1l+Qzo6H9/p3CFEL8UV
         9la4HH/3tk08SmgdF7Hzo2OzCvpiKGGTqWRtk8vVlNS0SWobvxuNxOFuneyS4moniBo4
         cu5eG1rkJIp/DqBWUD5Gl5mu+jlqmS9mPYD1slMP5JIKyR9pDZd3IrAbWzzS3ybs1J3O
         fR8cckz5qx+ez+evB5W+sQnLJZL3pmGFxxUMW8yKOV/lNpEtwmcGAeRsYvgtIoGy+1UF
         R/q48zUUQ1MuFHlBttV99e6Vp17szgUuB2Htgsqv6q3Hk4ROZNl/INr9P2B00jgNIRqO
         fqNQ==
X-Gm-Message-State: AA+aEWY3zHWh0DDjr9Z20potswiP15il+aF2V/AS626msEsnNQyErR5l
        1cR61j0eg/3PgPyQd17bM9gFfXlrleA=
X-Google-Smtp-Source: AFSGD/Vu/VdeAyWLbKvb0L+f/Ub82/Jic/QhLGGsxKzxK7NrYzxsG9rf/Hx6gotAR6jm2Q5zVHMxPg==
X-Received: by 2002:a50:c252:: with SMTP id t18mr19929408edf.57.1545954282371;
        Thu, 27 Dec 2018 15:44:42 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id 49sm12224749edz.59.2018.12.27.15.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:44:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Stefan Beller' <sbeller@google.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>
Subject: Re: Missed Commit in 2.20.1
References: <002401d49d07$325c7900$97156b00$@nexbridge.com> <875zwm15k2.fsf@evledraar.gmail.com> <87pntmegq1.fsf@evledraar.gmail.com> <001501d49e38$931aa0a0$b94fe1e0$@nexbridge.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <001501d49e38$931aa0a0$b94fe1e0$@nexbridge.com>
Date:   Fri, 28 Dec 2018 00:44:38 +0100
Message-ID: <87o996edqx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 27 2018, Randall S. Becker wrote:

> On December 27, 2018 17:40, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Dec 26 2018, Randall S. Becker wrote:
>>
>> > Please stay tuned for patches. We are very much looking forward to
>> > having the two (or three) different NonStop hardware personalities
>> > supported without mods in the very near future. Our goal, assuming
>> > those patches are acceptable, is to move our build/test/distro into a
>> > Jenkins config that runs with minimal human involvement (a.k.a. me).
>>
>> Portability patches like that are definitely wanted.
>>
>> In case you haven't seen my recent work on getting GitLab CI up & running
>> check out https://public-
>> inbox.org/git/875zwm15k2.fsf@evledraar.gmail.com/
>>
>> It differs from existing CI implementations for git.git in being focused on
>> doing the actual run on remote hosts that can be ssh'd to.
>>
>> So perhaps you'd be interested in some of:
>>
>> a) Contributing a NonStop box to the GCC Compile Farm
>>    (https://cfarm.tetaneutral.net/machines/list/). Then I can add it to
>>    my tests, but also other people porting free software will fix bugs
>>    pro-actively before you spot them.
>
> If I win the lottery, sure. Right now, a contribution like that is a bit beyond my budget. I'm not sure that anything "GCC" will fly with management since GCC does not port to the platform at all at this point in time. Many have tried. Many have failed. We're limited to c89 and c99.
>
>> b) I now have a gitlab-runner I maintain powering this git-ci.git stuff
>>    & presenting it on gitlab.com, if you give me SSH access I can add it
>>    to my own runs...
>
> Sorry, no can do on this one.
>
>> c) ...or you can just run your own gitlab-runner on
>>    https://gitlab.com/git-vcs/git-ci/ (although this amounts to giving
>>    me ssh access, since you'll be running my code)....
>
> This may be more possible. I've been considering putting up a GitLab instance but it's a matter of not having enough time. I have more than enough LXC ubuntu instances still available for something like that.

FWIW it's gitlab-runner, not gitlab, you can run gitlab-runner (and I
do) without installing any of the rest of gitlab. It's basically a
daemon that sits in a loop polling to see if there's new jobs for it,

So the extent of the setup is that I have a Debian box that has:

    vm ~ (master=) $ sudo grep -v token /etc/gitlab-runner/config.toml
    concurrent = 10
    check_interval = 30

    [[runners]]
      name = "gcc-farm"
      url = "https://gitlab.com/"
      executor = "shell"
      [runners.cache]

(Secret token pruned out), that's what sets it up as "gcc-farm" (see
https://gitlab.com/git-vcs/git-ci/blob/master/.gitlab-ci.yml), which
just runs this shellscript:
https://gitlab.com/git-vcs/git-ci/blob/master/ci/gitlab/run-on-gcc-farm.sh

I.e. for a given job name (it extracts the hostname from that) it ssh's
to that machine after scp-ing a given git.git revision to it, compiles &
tests, and all the output is then visible at :
https://gitlab.com/git-vcs/git-ci/-/jobs?scope=finished

I still need to write the rather trivial bit that'll run this as a
cronjob and push as new git.git revs become available, but so far I've
been wanting to get it passing 100% as a baseline, which hasn't happend
due to wanting to handle transitory failures (e.g. ssh to some boxes
timing out) and smoking out the various intermittent failures on some of
the odd platforms/distro versions.

>> d) ... or reuse the CI code I wrote to setup your own runner/pusher
>>    against NonStop, only you'd have access to this....
>
> More likely. Private chat worth it perhaps.

Sure, any time.

>> e) Or do whatever you're planning with Jenkins.
>
> We are currently using Jenkins to build/test git. I was thinking about contributing a Jenkinsfile that would build on a Controller (what happens today for our git port), or setting up a parameterized form for SSH for an Agent that might be better in a farm setting. I am close to the point where human interaction is limited to 'git branch -f production vn.mm.l' and git is tested and built for distribution without further touching. At least once my platform patches are applied it will be.

Makes sense, I thought you were just working on this as a new thing to
do CI testing.

>> If you want to just go with e) that's fine, just saying that you could re-use
>> some existing stuff with a-d) if you wanted.
>
> I am interested. Let's see how my $DAYJOB goes in the next few months. I really do like the idea of setting up a community instance of GitLab to do this and include a CI runner. Hmmm.

As noted above it's just a runner that's needed. I'm using gitlab.com's
instance to present the results, I *could* also setup my own, but no
reason to if they're willing to host it for free.

B.t.w. I'm sure the same can be done with GitHub/Travis or Azure CI
etc., I was just familiar with GitLab's, and wanted something where to
begin with I could have my own overlay of custom CI on top of git.git
without integrating patches upstream yet while I see if that even makes
sense.
