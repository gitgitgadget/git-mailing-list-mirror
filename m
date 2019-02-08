Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5881F453
	for <e@80x24.org>; Fri,  8 Feb 2019 01:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBHBZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 20:25:18 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:32886 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfBHBZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 20:25:18 -0500
Received: by mail-vs1-f46.google.com with SMTP id p74so1216141vsc.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 17:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iijXsAbVjVdETg+iQYTld8KzkbDoyEyMzc0ToEVEH9Y=;
        b=Eap4GjLplTeJRKvaHesfP58kKCSoMlfxhSRhZJXpJPKNPWEV49VPd9LxLs2btXJMX2
         TUroefNCcBN9sLAVngXndM9eJrNHddyFJj1J4kgqva4NZtU1D+IOnqxbl7AJqwf7qj5A
         HB4S4o0+kgGguv9+aVcS/IuU2bIU5I/mQiJErdbUQ78pL6WcBdX+XPOBn5Ql577uuJnM
         /JSADTC6EOEzX67KYLtBGgWR6kRntHunU40O1Iel1L51qjvfMgzLLR31IxITMUenuoJN
         nS/oHCm+80mgJSY6uFBD0TDgNF/F8aNN5rYX5Xgnff5x7A9Rp0npBu1IL5qyVZwWpkAC
         OPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iijXsAbVjVdETg+iQYTld8KzkbDoyEyMzc0ToEVEH9Y=;
        b=VHPAZMVBO1tjZVBlUuD+AexKjkQUNMA7SXsOK1c7JTcUuVemF9sGNDS82eyp9j5Q8y
         mBZYTB/pJmOB/mWOOQLNX1HgpCLRgdkg10TZ+jgHP8ewGUnKVDsjdM6W/MRGyG+389mu
         r+7taUDCB8TX77YuhLd5cYatkPNxUKQY2JxWGl8C7MJzIF8HU+F0dqxsLe5Icc9GmCp/
         O1q5vICoushpiKA5kwA7uuxOCvlv43fiUvlpkCpma+D2rP67kFuGYJe/hUfHMVzSSWVu
         M6ILfOLJMCucLD6f+2+junXa4wwAU6DK8Y2U0aKBpwkzQAGat93dJbmncJCCQkot8LB9
         3Gsg==
X-Gm-Message-State: AHQUAuZ5MIKMzUU3RAgZE7B4yuHuUkbExzdRH4tU1Ucm7Ta+RHgFeANR
        MXBfezlSqKg/nTV5ifm0nIoYECUq9l2dbCPplN+IVZbS
X-Google-Smtp-Source: AHgI3IbcqHM7VABWjR8Ejbr0qYSkhll6KMHfE5Gizsv+67Dxj2maCTSXFT34AcTo48YZWEDD3OC+srtTUeNwKk9VFqQ=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr7742351vsi.136.1549589113952;
 Thu, 07 Feb 2019 17:25:13 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
In-Reply-To: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 17:25:01 -0800
Message-ID: <CABPp-BGOz8nks0+Tdw5GyGqxeYR-3FF6FT5JcgVqZDYVRQ6qog@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 31, 2019 at 12:57 AM Elijah Newren <newren@gmail.com> wrote:
> git-filter-repo[1], a filter-branch-like tool for rewriting repository
> history, is ready for more widespread testing and feedback.  The rough


Someone at the Contributor Summit (Michael Haggerty perhaps?) asked me
about performance numbers on known repositories for filter-repo and
how it compared to other tools; I gave extremely rough estimates, but
here I belatedly provide some more detailed figures.  In each case, I
report both filtering time, and cleanup (gc or clone) time[0]:


Testcase 1: Remove a single file (configure.ac) from each commit in git.git:

  * filter-branch[1a]:  2413.978s + 34.812s
  * BFG (8-core)[1b]:     38.743s + 30.333s
  * BFG (40-core)[1b]:    24.680s + 35.165s
  * filter-repo[1c]:      35.582s + 15.690s

  Caveats: filter-repo failed and needed workarounds; see [1d]

Testcase 2: Keep two directories (guides/ and tools/) from rails.git:

  * filter-branch[2a]: 14586.655s + 22.726s
  * BFG (8-core)[2b]:     27.675s + 15.786s
  * BFG (40-core)[2b]:    24.883s + 20.463s
  * filter-repo[2c]:      10.951s + 12.500s

  Caveats: filter-branch failed at the end of this operation; see [2d].
           AFAICT, BFG can't do this operation; used approximations instead[2e].

Testcase 3: Replacing one string with another throughout all files in linux.git:

  * filter-branch[3a]: Estimated at about 3.5 months (~8.9e6 seconds)
  * BFG (8-core)[3b]:   2144.904s + 693.79s
  * BFG (40-core)[3b]:  1178.577s + 636.887s
  * filter-repo[3c]:    1203.147s + 159.620s

  Caveats: filter-branch failed at ~12 hours; see [3d].


Other details about measurements at [4].  Take-aways and biased
opinions at [5].


Hope this was interesting,
Elijah



*************** Footnotes (Minutiae for the curious) ***************

[0] git-filter-branch's manpage suggests re-cloning to get rid of old objects,
    BFG as its last step provides the user commands to execute in order to
    clean out old objects, and filter-repo automatically runs such commands.
    As such, time of post-run gc seems like a relevant thing to report.
    Commands used and timed:

  * filter-branch: time git clone file://$(pwd) ../nuke-me-clone
  * BFG:           git reflog expire --expire=now --all && time git gc
--prune=now
  * filter-repo:   N/A (internally runs same commands as I manually ran for BFG)


[1a] time git filter-branch --index-filter 'git rm --quiet --cached
--ignore-unmatch configure.ac' --tag-name-filter cat --prune-empty --
--all

[1b] time java -jar ~/Downloads/bfg-1.13.0.jar --delete-files configure.ac

[1c] git tag | grep v1.0rc | xargs git tag -d
     git tag -d junio-gpg-pub
     time git filter-repo --path configure.ac --invert-paths

[1d] git fast-export when run with certain flags will abort in repos
     with tags of blobs or tags of tags.  I had to first delete 7 tags
     to get this testcase to run, as shown in the commands above in
     [1c].  I'll probably patch fast-export to fix this.


[2a] time git filter-branch --index-filter 'git ls-files -z | tr "\0"
"\n" | grep -v -e ^guides/ -e ^tools/ | tr "\n" "\0" | xargs -0 git rm
--quiet --cached --ignore-unmatch' --tag-name-filter cat --prune-empty
-- --all

[2b] git log --format=%n --name-only | sort | uniq | grep -v ^$ > all-files.txt
     time java -jar ~/Downloads/bfg-1.13.0.jar --delete-folders
"{$(grep / all-files.txt | sed -e 's/"//' -e s%/.*%% | uniq | grep -v
-e guides -e tools | tr '\n' ,)}" --delete-files "{$(comm -23 <(grep
-v / all-files.txt) <(grep -e guides/ -e tools/ all-files.txt | sed -e
s%.*/%% | sort) | tr '\n' ,)}"

[2c] time git filter-repo --path guides --path tools

[2d] filter-branch fails at the very end when noting which refs were
     deleted/rewritten with:
         error: cannot lock ref 'refs/tags/v0.10.0': is at
b68b47672e613e94a7859c9549e9cd4b401f7b79 but expected
e2724aa1856253f4fc48ddc251583042c5f06029
         Could not delete refs/tags/v0.10.0
     Turns out b68b47672e613e94a7859c9549e9cd4b401f7b79 is an
     annotated tag in the original repo pointing to the commit
     e2724aa1856253f4fc48ddc251583042c5f06029.  I do not know the
     cause of this bug, but since it was almost at the very end, I
     just reported the time used before it hit this error.

[2e] Unless I am misunderstanding, BFG is not capable of this
     filtering operation because it uses basenames for --delete-files
     and --delete-folders, and some names appear in several
     directories (e.g. .gitignore, Rakefile, tasks).  As such, with
     the BFG you either have to delete files/directories that
     shouldn't be, or leave files and folders around that you wanted
     to have deleted.  The command in [2b] has some of both, but
     should still give a good estimate of how long it would take BFG
     to do this kind of operation if file and directory basenames in
     the rails repository happened to be named uniquely.

[3a] time git filter-branch -d /dev/shm/tmp --tree-filter 'git
ls-files | xargs sed -i s/secretly/covertly/' --tag-name-filter cat --
--all

[3b] time java -jar ~/Downloads/bfg-1.13.0.jar --replace-text <(echo
'secretly==>covertly')

[3c] time git filter-repo --replace-text <(echo 'secretly==>covertly')

[3d] filter-branch failed after 45704 seconds, predicting another
     8836429 seconds (~102 days) remaining at the time.  As commits
     earlier in history tend to be smaller, filter-branch nearly
     always underestimates the time required, sometimes considerably.
     filter-branch failed on commit
     af25e94d4dcfb9608846242fabdd4e6014e5c9f0 due to an empty ident.
     I possibly could have worked around it with --env-filter, but
     it's not like I'm going to wait for it to finish anyway.

[4] Other notes about timings:
  * All tests were run on an 8 cpu system, except for the "BFG
    40-core" tests which were run on a 40 core system.  (filter-branch
    and filter-repo are not multi-threaded and gain nothing from more
    cores.)
  * More precisely, I ran on AWS with an m4.2xlarge with two 50-GB GP2
    volumes (150 Iops) for tests.  The 40-core system was an
    m4.10xlarge.
  * Before each command, to try to avoid warm disk caches helping or
    hurting depending on the order I ran commands in, I first ran:
    * rsync -az --delete ../$REPO-orig/ ./
    * git status
    * $TOOL -h
  * Testing was imperfect; I just ran once and recorded the time.  It took
    long enough to gather the data as it was.
  * when additional commands were needed for the filtering
    (e.g. getting the all-files.txt list to generate the BFG command,
    or deleting tags that fast-export couldn't handle for
    filter-repo), I did not include the times of those commands in the
    overall execution time.  It would have added a few hundredths of a
    second to filter-repo's git.git time, and about 5-6 seconds to BFG's
    rails.git time.
  * filter-repo self-reports time until filtering finishes and time
    until entirely done.  I took difference between its self-report of
    overall time and the "time" command's report of overall time (which
    was typically order ~ 0.1s), and added that to filter-repo's
    filtering time, assuming that most the discrepancy would be due to
    python startup.

[5] Performance is only one measurement.  Features, capabilities,
usability, etc. matter too.  filter-branch is a general purpose
filtering tool, but in my opinion, not a good one -- and not just
because of performance.  BFG Repo Cleaner is a good tool, but it is
special purpose; it is designed for a few particular usecases
(limiting the kinds of things I could try in my comparison above).  My
hope is that filter-repo serves as a good general purpose filtering
tool so that people can stop suffering from filter-branch.
