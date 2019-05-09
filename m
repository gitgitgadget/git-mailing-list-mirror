Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC00D1F45F
	for <e@80x24.org>; Thu,  9 May 2019 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEINpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 09:45:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37330 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfEINpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 09:45:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so136382qkk.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GtrrVpsTimATgOIROobHGO4DhWQ7tpKVAKy5eSlOYpA=;
        b=PbQAu3ih3Shn85HY5Y4Fl3RKfiMzyyG1pJhvyubjuDA9fEGp6khXQLLOaP1ZUGcSIl
         utWvhx7k+yU+3JFgh+Hiy95GkZso4Wm8f1qFqOlrkNcEg1yV66KTDyZRJzgESmrBcaa1
         MMfsimsArsh6McLwiWRAI8cvaZ7+X3Cujk/3lMIyowQPJVeDDKVZOqEqar5Hx1Q5b5lt
         56aeg06CIDLa78zm1H8xRQa64emEXuODwmp9Lt6tUwLKqeqX+xLjc7S+nkJerKS5ObXP
         gPP56UkLEoruXjLcF4m6fFVIABgBzZGpnzU+LkO25UG8bJNhS/uqlrGCff46bSt5G4Z2
         lb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GtrrVpsTimATgOIROobHGO4DhWQ7tpKVAKy5eSlOYpA=;
        b=a4ATCBaVJJD9i9Uo9BWpIag08Z2MWJ4vj1mDlyBIig2PGx16gpXO6VPHRu/Mjoabsa
         mg2Y17svhFZWCUJmqo8om9eZLD4wHtPHyH+ttOunMr9dkTj5OIfIpa2ocbavzgmrthIn
         agR5C3svnVPNCPuUXQJ5dZADMQNceTlx0yYFJHZ1FNBpCVtDY9gqauTi+5fGb18nE/NW
         eI011ZbfjeIupbYvfygx4hA7q900oeOWzZ/1Bb+i8EQX6q44xbg1pK2xCG/ZyvHFLLpy
         0H52AgFfAYuqi58gzZg+LnIeQnEVn6qFYXBWJMVU0XTGfOhvO38LnDfUeBiO2Otoky7L
         HrGg==
X-Gm-Message-State: APjAAAWg9xQ1qO0V6X31KvalaK3rIVswaQhRh709XRmHWbEqaQhd64gG
        kFLpd2sPbOT0ODfAG3bzrcA=
X-Google-Smtp-Source: APXvYqxLvHCw28NpuTqx4UXvIctnnNnmS4iLahtx7UaX9Qwbnh6D4J1Bc9GuN29vp6zOjow7Ho/lng==
X-Received: by 2002:a37:6117:: with SMTP id v23mr3335710qkb.309.1557409508263;
        Thu, 09 May 2019 06:45:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:0:ba82:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id g206sm992883qkb.75.2019.05.09.06.45.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 06:45:07 -0700 (PDT)
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
 <20190508172029.GP14763@szeder.dev>
 <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
 <87pnoshfkq.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f27db281-abad-5043-6d71-cbb083b1c877@gmail.com>
Date:   Thu, 9 May 2019 09:45:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87pnoshfkq.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 4:11 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, May 08 2019, Derrick Stolee wrote:
>
>> I'll ignore the improbability of this turn of events (two writes happening
>> during the span of trying to read two files) and focus on the fact that
>> we can prevent issues here using the 4th TODO item in my cover letter:
> 
> FWIW the sort of scenario SZEDER is describing is something I deal with
> in production a lot. It doesn't require an unfair scheduler, just that
> you have differently nice(1)'d processes accessing the same repo.
> 
> So if you have batch "cron" processes their IO scheduling follows their
> nice(1) scheduling. It's not atypical to e.g. have some background
> thingy sit for seconds or even minutes on an I/O syscall while the
> kernel decides everyone else has right of way, since you nice'd that not
> caring if it finishes in 10 seconds or 10 hours.

Thanks. I learned something today.

I still don't think this is a problem, with the idea below.

>>  4. It would be helpful to add a new optional chunk that contains the
>>     trailing hash for the lower level of the commit-graph stack. This chunk
>>     would only be for the commit-graph-N files, and would provide a simple
>>     way to check that the stack is valid on read, in case we are still
>>     worried about other processes reading/writing in the wrong order.
>>
>> If we have this chunk -- you have convinced me that we need it -- then we
>> could ignore the "new" commit-graph-2 because its base graph hash does not
>> match. We can continue without dying because we can always parse the "missing"
>> commits from the packs.

So, let's set that idea aside. You have other concerns.

> Instead of looping through files N at a time we'd have a discovery step
> where we'd need to open() all the files, see which ones say "my parent
> hash hash X", and then create a list of those hashes in order to read a
> bunch of commit-graph-<HASH> files.
> 
> Is that a bit painful? Sure, but way less painful than dealing with the
> caveats I'd mentioned in [1] and SZEDER details here.

I don't see how this step is less painful than the one I am describing.
You'll need to be a bit more specific to convince me.

I'll try to be specific with a few ideas that have been thrown around,
so we can compare and contrast (and point out where I am misunderstanding
what you are trying to say).

Option 0 (this series): commit-graph-N
--------------------------------------

On read, we look for the 'info/commit-graph' file and acquire a read handle.
We set that commit_graph struct as our tip commit-graph. Then, for each
increasing N (until we fail) we acquire a read handle on
'info/commit-graphs/commit-graph-N' and check that its base hash matches
our current tip commit-graph. If the file doesn't exist, or the base
hash doesn't match, then we stop and continue with our current tip graph.

On write, use a 'mv' to swap our .lock file with whatever level we are
merging, THEN can unlink() the higher layers in decreasing order. (This
"mv-then-unlink" order is different than what is implemented by this
series, but is enabled by the chunk containing the base graph hash.)

Option 1 (needs format v2): commit-graph -> graph-{hash}.graph
--------------------------------------------------------------

On read, we load the 'info/commit-graph' file and inspect the byte saying
how many base files we have. We load their hashes from the base file chunk
and read 'info/graph-{hash}.graph' for each. If _any_ fail, then we need
to ignore anything "above" the failure in the chain (and specifically this
includes the 'commit-graph' file), or consider reloading the commit-graph
file altogether and hope it works this time. [Note: if an older version
of Git doesn't understand the incremental file format, it will fail to
properly understand the graph positions and either fail with an
"invalid parent position" error, or worse give garbage results.]

On write, if we are creating a new layer to our chain, we need to _copy_
the existing commit-graph file to a graph-{hash}.graph file before renaming
the .lock file. If we are merging layers, then we either (a) clean up the
dangling chains after moving our commit-graph file, or (b) have something
like 'gc' clean up the files later. I think using 'gc' for this is not
a good idea, since I would expect these files to be written and merged
much more frequently (say, after a 'fetch') than a 'gc' is run. Cleaning
up the dangling chains leads to our concurrency issues. Further, this
'copy the base' no longer keeps our large base file at rest.

Option 2: grovel commit-graphs directory for graph-{hash}.graph
---------------------------------------------------------------

On read, we load the 'info/commit-graph' file and assume it is never
an incremental file. Then, scan the 'info/commit-graphs' directory
for 'graph-{hash}.graph' files and open them _all_ up to construct
a "graph forest" (each graph has a single parent, given by a chunk
specifying its base graph hash). If we don't have an instance of a
graph with a given hash, then ignore any graphs pointing to that hash.
We now have a decision to make: which leaf of this forest should we
use as our tip commit-graph? That could be given by the
commit-graphs/info file. But what happens when we have timing issues
around scanning the directory and the commit-graphs/info file? Do
we fall back to modified time?

On write, if we are not merging, then we just create a new
graph-{hash}.graph file. If we are merging, but still have a base graph,
then create a new graph-{hash}.graph file. Finally, if we are merging
all layers, then we rename our .lock file to 'info/commit-graph'.
To clean up, we need to grovel the directory to look for graph-{hash}.graph
files whose base chains no longer match the new, "best" chain and unlink()
them. This clean-up step can happen at any time.

--[end description of options]--

Did I accurately describe the options we are considering?

Option 1 was the design I was planning, and I think it matches how the
split-index feature works. Please correct me if I am missing something.
It _requires_ updating the file format version. But it also has a flaw
that the other options do not have: the copy of the base file. One
thing I want to enable is for whatever machinery is handling these
file writes to run a 'verify' immediately after, and have that be fast
most of the time. With a model that changes only the "tip" file, we
can verify only the new files and have confidence that the base file
did not change. I think options 0 and 2 both improve in this direction.
 
> With commit-graph-<HASH> all these unlink() race conditions go away,
> partial reads due to concurrent graph writing becomes a non-issue (we'd
> just leave the old files, "gc" deals with them later..), no need to
> carefully fsync() files/dirs etc as we need to carefully juggle N and
> N+1 files.

Calling this a non-issue is an exaggeration, especially if you are
claiming we need to be robust to multi-hour gaps between reading files.

> It also becomes easy to "chain" graphs across repos e.g. via
> alternates. Say in the scenario github/gitlab have where they have a
> "main" repo and other objects on another delta island.
> 
> In that case the repo would have a local "tip" file with the last link
> in its chain, some of which would then refer back to <HASHes> in other
> "parent" alternates.
> 
> As long as such a setup has a "gc" process that's not overly eager about
> pruning old stuff and considers that constellation of repos as a whole
> that should just work. You can freely optimize and rewrite graphs across
> repos, just be careful about unlinking old stuff.
> 
> I don't see how it would work with commit-graph-N without a *lot* of
> painful orchestration (where e.g. you *must* guarantee that the parent
> repo ends in N, all child repos start at N+1).

You're right that Option 0 does not work in this model where some graph
information is stored in an alternate _and_ more information is stored
outside the alternate. My perspective is biased, because I consider the
alternate to be "almost everything" and the local object store to be
small. But in a fork network, this is not always the case. I appreciate
your feedback for this environment, and I've always hoped that someone
with server experience would come and say "this feature is great, but
we need X, Y, and Z to make best use of it in our environment. Here's
a patch that moves us in that direction!" At least you are doing the
next-best thing: stopping me from making mistakes that would block
adoption.

So let's consider how Option 2 would work in this "multi-tip" case.
Each object directory would have some number of graph files, and one
'commit-graphs/info' file pointing to some hash. When we read, we
try to pick the info file that is "closest" to us.

This does create some complications that I don't think you gave enough
attention to. These may be solvable, but they are non-trivial:

* When we 'gc' the "core" repo, we need to enumerate all of the
  "leaf" repos to check their tip commit-graph files and make a
  decision if we should keep their bases around or delete those tips.
  Perhaps I'm over-stating the difficulty here, since we need to do
  something similar to find still-reachable objects, anyway. But if
  we are doing that reachability calculation, then why are we not
  just putting all of the commit-graph data in the core repo? Note
  that we don't get the same value as delta islands because this data
  isn't being shared across the protocol. The issue with storing all
  graph data in the core repo is that the core repo doesn't actually
  have all of the commits, which makes 'verify' on the graph a bit
  annoying.

* If we choose a local tip instead of the "core" tip, then that chain
  of commit-graphs can be far behind the core repo. In the world where
  a fork moves only at the speed of a single developer, but the core
  project moves quickly, then computing a merge base with the core's
  master branch becomes slow as our local chain doesn't contain most
  of the commits.

* We can't take all of the "core" chain _and_ the local chain, because
  the concept of "graph position" no longer makes sense. The only way
  I see out of this is to make the graph position two-dimensional:
  commit -> (index of tip chain, position in that chain). Perhaps this
  is a valuable thing to do in the future? Or perhaps, we shouldn't
  have incremental chains spanning object directories and instead
  introduce "parents-by-ref" where we mark some parents as included
  by object id instead of by graph position. This would allow the
  core repo to gc without caring about the external repos. It also
  wouldn't care about how the graph files are stored (Option 0 would
  work, as graph chains would not cross object store boundaries) and
  more closely resembles the independence of the pack-files in each
  object store. The "parents-by-ref" would require updating the
  file format version.

--[end discussion of incremental files]--

I'll move forward applying your existing feedback on patches 1-11 and
submit as a full series to replace ds/commit-graph-format-v2. We can
work on reviewing that code while we continue to think critically on
the topic of incremental files.

Thanks,
-Stolee


