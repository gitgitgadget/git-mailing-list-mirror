Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050E51FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 19:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754165AbdBITLh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:11:37 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33583 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBITLg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:11:36 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so772868pfg.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BIarb88tGHw908CqoaPvoImzQv0NwHmfBm+YucKC5ts=;
        b=Hn2xmXYwgbQXLD3NepwHzYovw9whizz2vGN+uv5K98/X0LX5YtXu5lCtloazZ7ShBV
         K2TVjMOpzPRMGKtOPEB0aDDPftFGPyDpZ+S/wkbYs+/d5Ai0KcOwRr/JF0hMgd9lcdQn
         bJXYLrYEBoC2OtzuBHqtGx6ddwEYBO5txbfuPbg01iccfXh3U87PKmj1dzlk9eCW7ZJL
         Bojg83Ha/s3WIS9z51E02lMrL9UpQ7xLNDNJzgOYgeQZ3Jw/ZpPc/oDBd/qYq8UZkvbm
         D5vs9hZqP1cmYZi5BZMqYhScVbzC5vGAMhc5r4Vm/FqSL8JbM4o0f/n37GO/Ut7vRvDb
         8kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BIarb88tGHw908CqoaPvoImzQv0NwHmfBm+YucKC5ts=;
        b=EkhK3kngoZO+B9Mjo5H1pGSM332EZ7htkBUu9z6tToaGcYFGvaW3DTaN61+WK0CksF
         updaQtrA8tqkcGxNznvFggW8E42A0dOkPvnKEeATDkxHKbN25jPSjzhov6LPa0/3gvPq
         i/qHvHdkNnmmC7usPkHAUHwVv8Xk5W4Y9hNNGcMO1s9GAhcgq5I6GoFcoSsjb4mtY2nG
         1P6vsAbrVt6gvfLkLOgy+P8ceV4rugm2K5csUX1lvK7cV1yoVkorywOEMVPrM8jJEAij
         SNUZ3ax+junrzyiXCzg6OVhP/P2tshKyDQo98h6oM5ulNs3IX1m/E0QC3Ris/9Jn+dwD
         IolQ==
X-Gm-Message-State: AMke39nH7E0ofOc/ImOyWlZovidorJLH535jZVn3dWtsMLplo4KDvmKzmJ8eavHhUCNwQQ==
X-Received: by 10.98.223.195 with SMTP id d64mr5408969pfl.80.1486667398363;
        Thu, 09 Feb 2017 11:09:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id d68sm30763007pfj.92.2017.02.09.11.09.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:09:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Doc about the Contributors' Summit
References: <alpine.DEB.2.20.1702021007460.3496@virtualbox>
Date:   Thu, 09 Feb 2017 11:09:56 -0800
In-Reply-To: <alpine.DEB.2.20.1702021007460.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 2 Feb 2017 10:08:47 +0100 (CET)")
Message-ID: <xmqq7f4zqiyj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I just started typing stuff up in a Google Doc, and made it editable to
> everyone, feel free to help and add things:
>
> https://docs.google.com/document/d/1KDoSn4btbK5VJCVld32he29U0pUeFGhpFxyx9ZJDDB0/edit?usp=sharing

Thanks for a write-up, Dscho.

List of bullet points just make non-attendees envious, imagining
that attendees had all the fun discussing what is behind these
bullet points, without being able to know what was discussed, if
they reached consensus and what the consensus was, but it is OK ;-)

A few items caught my attention, not because I found them more
important than other items on the page, but because they seem to
want my input without directly asking me ;-)

* If Junio would accept patches by replying to the sender with an
  ID and/or a patch name. He picks this (branch) name when he gets
  your patch.

I am not sure what exactly I am asked to "accept" here.  I sometimes
forget to respond with "Thanks, will queue." to the patch message
and whoever said this wants me to consistently do so?  I never say
"... will queue as js/difftool-builtin topic." mainly because I do
not know what the name of the topic branch should be at the point of
reading the patch.  All I know is that decided that it may be worth
queuing, so it is a bit harder to arrange.  But I can certainly try
if it makes the lives of contributors easier.


* Junio has a script for the todo branch which we can use to
  generate the what's cooking branch. Perhaps we could continuously
  generate this onto a webpage.

I have no objection, but I doubt that people find such an auto
generated version all that useful, as "git log --first-parent
origin/master..origin/pu" would tell exactly the same story.  It
will lack the "topic summary" comment I have yet to write, if the
final 'pu' of the day that was pushed out was before my local update
to the draft of the next issue of "What's cooking" report [*1*], and
would not have any update on the next action (e.g. "Will merge to
...") relative to the latest issue of "What's cooking" report.  IOW,
such an auto-generated report lacks all the added value over "git log"
output.


* Making the actual workflow more publicly known, e.g. document how
  to generate the cooking email, to learn about the state of a
  generation.

The exact mechanics of "how to generate" may be of less importance
than "how the information contained therein relates to their own
work" to the contributors, and I think MaintNotes that is sent out
at key milestones more or less covers the mechanics, but here is how
the sausage is made these days:

- I find a patch series on the list that is in good enough shape to
  be in 'pu'.  Perhaps it was already discussed and redone a few
  times without hitting my tree.  Or it may be the first attempt of
  a new topic.  I come up with a topic name, decide where the topic
  should fork at [*2*], create the topic branch and queue the
  patches.  I may or may not test the topic in isolation at this
  point.

- I may find an updated patch series of what has been queued.  I go
  to the existing topic branch and replace it (I try to keep it
  forked at the same commit) after inspecting what got updated.
  "git tbdiff" is a useful program to help this step.  I may or may
  not test the topic in isolation at this point.

- I repeat the above two for various topics during the day, and at
  some point between 14:00-15:00 my time, stop taking new patches.
  The day's integration cycle starts.

- If there are topics that have cooked long enough in 'next' and
  planned to graduate to 'master', merge [*3*] them to 'master',
  update the draft Release notes.  Otherwise skip this step.

- If there are topics that have cooked long enough in 'pu' and
  planned to graduate to 'next', merge them to 'next'.  Otherwise
  skip this step.

- If I updated 'master', merge its tip to 'next' (this should update
  the draft release notes and nothing else, unless I took something
  directly to 'master').

- Then I recreate 'jch', which is a point between 'master' and 'pu'.
  This is the version I use for my own work, contains all topics in
  'next' but a bit more.  "git checkout -B jch master" begins it,
  and then the topics that were in 'jch' are merged on top.  The
  latest version of updated topics that were already in 'jch' are
  incorporated at this point, and "git diff jch@{20.hours}" would
  show the effect of their interdiff (plus RelNotes update, if
  'master' was updated during this integration cycle).

- I ran "git branch --no-merged pu --sort=-committerdate" to see the
  topics that are new; the top of this list shows new topics and
  updated topics (note that I just updated 'jch' but not 'pu' yet at
  this point).  Among them, I pick the ones that I am willing to be
  a guinea-pig for before they hit 'next' and merge them to 'jch'.
  Other topics that used to be in 'pu' may also be merged at this
  point, when they turn out to be "interesting" enough.

- 'pu' is recreated on top of 'jch' [*4*].  "git checkout -B pu jch"
  begins it, the topics that were already in 'pu' are merged on top
  (some of them may have been merged to updated 'jch' in the above
  step), together with the new topics we acquired.

- All integration branches are then tested (and installed for my own
  use) at this point.

- While the tests are running, the draft "What's cooking" report is
  updated.  Here is where I write topic summary for new topics and
  update topic summary for updated topics.  The next action
  (e.g. "Will merge to ...") may also be updated at this point.

- If the test notices problems, I go back to redo the day's merges
  [*5*].  The first thing to do is to rewind the integration
  branches back to the state before the day's integration started.
  Trivial breakages are fixed-up in place with "rebase -i" or
  queuing "SQUASH???" fix on top of the offending topic before
  merging them back to 'master', 'next', 'jch' or 'pu'.  A more
  involved ones may force me to punt and eject the topic from the
  integration branches.  Or I may leave it in 'pu' so that others
  who are more clueful in the area the offending topic touches can
  notice the breakage and send in fix-up patches [*6*].

- If I have time, I redo 'jch' and 'pu' at this point once again,
  because the merge commit for new topics we just tested do not have
  their merge log message in sync with the topic summary in the
  draft "What's cooking" report at this point [*6*].  I run the
  tests for integration branches again, but the tree objects at the
  tips of the integration branches are expected to be the same as
  what was tested earlier, so it becomes a no-op.

- I push out the integration branches to the usual places [*7*].

- Then I go back to the very beginning.  I start taking patches for
  the next day's integration cycle.

Interested people are welcome to condense the above to update
MaintNotes in my 'todo' branch.


[Footnote]

*1* Merges that appear early in the "--first-parent master..pu"
    carry the topic summary I have in the draft of "What's cooking"
    report as its merge message.

*2* Sometimes a maint-worthy patch series is done in such a way that
    it only applies to 'next'.  I try to tweak such a patch series
    to apply 'maint' and either use the result of my tweak, or ask
    the submitter to base it on 'maint', depending on how confident
    I am with the tweaked result.

*3* When I do this and any other "merge" of a topic branch into an
    integration branch, the topic description in the draft "What's
    cooking" report is used as the merge log message, if one already
    exists.

*4* Readers would notice that 'jch' and 'pu' are not decendants of
    'next'; this is very much deliberate, and it has helped me to
    spot mismerges of tricky topics when they graduate to 'master' a
    few times.

*5* IOW, I go back to the step "around 14:00-15:00".

*6* This is why the tip of 'pu' sometimes may not even build.  IOW,
    a broken 'pu' is an invitation for help, not complaint.

*7* Remember *3* above and also the fact that "What's cooking" draft
    is updated only after everything is merged to 'pu'; there is a
    small chicken and egg problem here and redoing 'jch/pu' will fix
    it.

*8* Broken-out individual topics are sent to github.com/gitster/git
