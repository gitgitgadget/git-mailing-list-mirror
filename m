Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BFF1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCJAGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 19:06:24 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:44191 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCJAGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 19:06:21 -0500
Received: by mail-pf0-f180.google.com with SMTP id 17so1923084pfw.11
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 16:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=WyxDJtkYrYM5dZhuyAjCDlw5RYWhQqFWEBnGFHh15As=;
        b=cC1LLxKjVGXjorbiiI7/LuNZpWxzeazn9O5oHz4b/0/Yr4QzRUCZm0sgF8+jZdziqE
         uUEeHTF2xeKG7zZefSr4g3Elx5aKXVlEO8xG/0Vnji7yTabdiDpfmm1MIcp/eRI5ShWf
         6k6MSQw+R5vzKWrKC2tGs94RDg0tPRXJ1OZYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=WyxDJtkYrYM5dZhuyAjCDlw5RYWhQqFWEBnGFHh15As=;
        b=USL/TvDwLVP/VADXMmvAU01iBflVdvepCp5QjuVjGDrmVarGjtgi7Boto3IUsd5atu
         AvEPjCo2qBwFvyYcZHT+oUYqPFwgP0EVlYpwB5tP0BTuxo3MhsXXv4/VGqapZTW3012Y
         AFkEt2bOwviTJASU2c5cpuvTOJAk6k6TVSLvuEgCDStRdXCsUC/8nyqkRmFapAAHhxCK
         YlU02eP1EcxKKwB8S+Yaumo1B/RIflTMAav/8N1U9RkBmNYZK8GZsUlpPXNIcc2+LzU2
         rgUz7W/j1HFkIOZ1W4XUAriZlWYzomzA1+e8xrFUBqlPIgRQZ2bf/AJQFkL8dRoLbWMK
         89zA==
X-Gm-Message-State: AElRT7E6/hJYb5WCmPY1WIDPhBE/Hix8ud8tPq3Asu4TEVWaOnv+jU+P
        6DAL1aR1/9eEO64TtAfAAYmtBbgMqw8=
X-Google-Smtp-Source: AG47ELvgLuUg58FuzgHaRXAJbnf8fS/GZBnxiT7o7jFpkWj52Pau7X2RFvEJ9P4cQFhZFsu8j5N51g==
X-Received: by 10.98.16.23 with SMTP id y23mr292890pfi.84.1520640379853;
        Fri, 09 Mar 2018 16:06:19 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW.corp.dropbox.com. [205.189.0.165])
        by smtp.gmail.com with ESMTPSA id j19sm4556610pfh.26.2018.03.09.16.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 16:06:19 -0800 (PST)
Date:   Fri, 9 Mar 2018 16:06:18 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     git@vger.kernel.org
cc:     git@jeffhostetler.com, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, avarab@gmail.com,
        peff@peff.net, johannes.schindelin@gmx.de
Subject: Git Merge contributor summit notes
Message-ID: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-495330139-1520640378=:23109"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--8323329-495330139-1520640378=:23109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

It was great to meet some of you in person!  Some notes from the
Contributor Summit at Git Merge are below.  Taken in haste, so
my apologies if there are any mis-statements.

 - Alex

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  "Does anyone think there's a compelling reason for git to exist?"
    - peff


Partial clone (Jeff Hostetler / Jonathan Tan)
---------------------------------------------
 - Request that the server not send everything
 - Motivated by getting Windows into git
 - Also by not having to fetch large blobs that are in-tree
 - Allows client to request a clone that excludes some set of objects, with incomplete packfiles
 - Decoration on objects that include promise for later on-demand backfill
 - In `master`, have a way of:
   - omitting all blobs
   - omitting large blobs
   - sparse checkout specification stored on server
 - Hook in read_object to fetch objects in bulk

 - Future work:
   - A way to fetch blobsizes for virtual checkouts
   - Give me new blobs that this tree references relative to now
   - Omit some subset of trees
   - Modify other commits to exclude omitted blobs
   - Protocol v2 may have better verbs for sparse specification, etc

Questions:
 - Reference server implementation?
   - In git itself
   - VSTS does not support
 - What happens if a commit becomes unreachable?  Does promise still apply?
   - Probably yes?
   - If the promise is broken, probably crashes
   - Can differentiate between promise that was made, and one that wasn't
   => Demanding commitment from server to never GC seems like a strong promise
 - Interactions with external object db
   - promises include bulk fetches, as opposed to external db, which is one-at-a-time
   - dry-run semantics to determine which objects will be needed
   - very important for small objects, like commits/trees (which is not in `master`, only blobs)
   - perhaps for protocol V2
 - server has to promise more, requires some level of online operation
   - annotate that only some refs are forever?
   - requires enabling the "fetch any SHA" flags
   - rebasing might require now-missing objects?
     - No, to build on them you must have fetched them
     - Well, building on someone else's work may mean you don't have all of them
   - server is less aggressive about GC'ing by keeping "weak references" when there are promises?
   - hosting requires that you be able to forcibly remove information
 - being able to know where a reference came from?
   - as being able to know why an object was needed, for more advanced logic
 - Does `git grep` attempt to fetch blobs that are deferred?
   - will always attempt to fetch
   - one fetch per object, even!
   - might not be true for sparse checkouts
   - Maybe limit to skipping "binary files"?
   - Currently sparse checkout grep "works" because grep defaults to looking at the index, not the commit
   - Does the above behavior for grepping revisions
   - Don't yet have a flag to exclude grep on non-fetched objects
   - Should `git grep -L` die if it can't fetch the file?
   - Need a config option for "should we die, or try to move on"?
 - What's the endgame?  Only a few codepaths that are aware, or threaded through everywhere?
   - Fallback to fetch on demand means there's an almost-reasonable fallback
   - Better prediction with bulk fetching
   - Are most commands going to _need_ to be sensitive to it?
   - GVFS has a caching server in the building
   - A few git commands have been disabled (see recent mail from Stolee); those are likely candidates for code that needs to be aware of de-hydrated objects
 - Is there an API to know what objects are actually local?
   - No external API
   - GVFS has a REST API
 - Some way to later ask about files?
   - "virtualized filesystem"?
   - hook to say "focus on this world of files"
   - GVFS writes out your index currently
 - Will this always require turning off reachability checks?
   - Possibly
 - Shallow clones, instead of partial?
   - Don't download the history, just the objects
   - More of a protocol V2 property
   - Having all of the trees/commits make this reasonable
 - GVFS vs this?
   - GVFS was a first pass
   - Now trying to mainstream productize that
   - Goal is to remove features from GVFS and replace with this

Protocol V2 (Brandon)
--------------------
 - Main problem is that forward compatibility negotiation wasn't possible
 - Found a way to sneak in the V2 negotiation via side-channel in all transports
 - "environment variable" GIT_PROTOCOL which server can detect
 - Ability to transmit and ignore, or not transmit, means forward/backward compat
 - HTTP header / environment variable
 - ...soooo now what?
 - Keep as similar as possible, but more layout changes to remove bad characteristics
 - Like fixing flush semantics
 - Remove ref advertisement (250M of refs every fetch from Android!)
 - Capabilities are currently in first packet, 1K limit
 - First response is capabilities from the server, like commands or features
 - Or server-side grep/log, for sparse checkouts
 - Client then issues request for one of those commands
 - Server executes command, sends back result
 - HTTP vs everything else -- HTTP is very complicated, git -> CURL / CURL -> git
 - Clear flush semantics make the protocol stateless (?)
 - Add in ability to make protocol stateful
 - Already deployed for local repositories

Questions
 - How does fetch differ?
   - Similar to what HTTP does today
   - Still stateless
   - Because otherwise people forget about HTTP
   - Force everyone to think about stateless behavior
   - May want to tweak to explicitly allow stateful requests
   - Microsoft wanted SSH to be a proxy for HTTP
   - Most other verbs other than fetch, are easy to make stateless
   - Fetch is inherently multi-round; if one ignores HTTP, make it hard to implement

 - ls-remote vs ls-refs
   - no necessary consistency across datacenters; multi-round makes this complicated for consistency
   - might want requirements like push, for consistency
   - branch -> object-id gives possibility for race conditions
   - Jonathan Tan wrote patches to ask for refs, not oids; server says "in this packfile, master is 0xdeadbeef" after ref advertisement
   - (peff) But that's a hack; the only reason is because protocol is stateless
   - Difference between protocol v2, and fetch V2; build protocol V2 first, then think about negotiation for fetch V2
   - Seems like optimizing for one case -- fetch refs/heads/*, requires two rounds and still has race condition
   - Could optimize for that, too, but then why have ref advertisement?
   - (brandon) Do you have to rethink about how fetch works _before_ upgrading the protocol?

 - How often do you contact two different HTTP servers?  keepalive should solve that
   - google doesn't do that; keepalive is just to the frontend, which is just a proxy

 - jgit implementation in progress
   - start some portion of real traffic using it
   - turned on for internal traffic in the client
   - local operations use the new protocol

- concerns from the server folks?
   - (stolee) making it stateless is good
   - (stolee) microsoft will start working on it as soon as it's final
   - (jon) github has not started implementation, will once landed

 - (peff) Time to deprecate the git anonymous protocol?
   - Biggest pain to sneak information into
   - Shawn/Johannes added in additional parameters after a null byte
   - Bug; if there's anything other than host, then die
   - But it doesn't check anything after _two_ null bytes.
   - "Two null bytes, for protocol V2"
   - Only in use by github and individual users
   - Would not be too sad if daemon went away
   - Git for Windows has interest in daemon
   - Still interested in simple HTTP wrapper?
   - HTTP deployment could be made eaiser
   - Useful for unauthenticated internal push
   - Perhaps make the daemon use HTTPS?  Because it needs to be _simple_
   - Currently run out of inittab

 - Series as currently out
   - Only used for local operations
   - Not confident on remote CURL
   - Once jgit implementation is done, should be more confident
   - e.g. authentication may be messed up
   - only file:// is currently in production
   - test scripts to exercise HTTP, so only thing unknown is auth
   - May need interop tests? there is one, but not part as standard tests
   - Dscho can set up something in VSTS infra to allow these two versions to be tested
   - Tests should specify their versions; might be as simple as `cd ...; make` and maybe they should be in Travis


Serialized commit graph (stolee)
--------------------------------
 - current patch includes a way to write a file which is commit history
 - replaces object database lookups by separate file
 - stores object id, commit date, parent information
 - parent information includes reference id
 - `git log --graph` is 10% of the time it used to be
 - putting generation numbers in speeds things up further
 - queued up for the next series
 - generation is an integer, guarantees that everything that it can reach is lower
 - root is id 1, every child is max(parents)+1
 - can give nice guarantees if one knows there are no merges in a commit range

 - partial clones?
   - all commits are there
 - shallow clones
   - won't work
   - can define generation numbers based on current information
   - if deepened, would need to toss
   - server might be able to give this information
   - or maybe the commit graph
   - and the partial clone protocol could then be used to look up e.g. author information
 - VSTS can do sub-second graph requests
 - one caveat: topo order in revision walk
   - because computes in-degrees, /then/ topo sort; merging those two to be incremental is hard
 - (peff) custom contains traversals, can be changed to use generation numbers (+ reachability bitmaps?)
 - commit graph is easier to maintain than reachability bitmap
 - bitbucket has similar code that predates reachability bitmaps; generate reachability DAG in a text file; diminishing returns to improve further
 - generation numbers are useful for computing merge bases
 - status does a merge-case calculation (e.g. --no-ahead-behind)
 - derived data, can be extended further
 - VSTS adds bloom filters to know which paths have changed on the commit
 - tree-same check in the bloom filter is fast; speeds up file history checks
 - might be useful in the client as well, since limited-traversal is common
 - if the file history is _very_ sparse, then bloom filter is useful
 - but needs pre-compute, so useful to do once
 - first make the client do it, then think about how to serve it centrally

Questions:
 - How to make sure that graph stays in sync?
   - Not all commits need to be in the graph
   - Can still parse the commits to get the data
   - Assume infinite generation number if not in the graph
   - Can even include commits that are in odb
   - Graph need not be 100% synced to object data
   - Hook is in parse_commit; it doesn't find it, falls back to object database
 - What about rebase?
   - commits are not mutable; contains no refs
   - same caveats and fallbacks as bitmap index
 - What about when the commits are not immutable?  E.g. grafts
   - There is logic to check for grafts
   - Code is copy/pasted
   - If you build the graph file, and you then add grafts, it will break
   - Perhaps if you have grafts, then should disable
   - But shallow is kinda a graft
   - Needs hardening around shallow clones
 - Work with multiple packfiles?
   - Not tied to packfiles at all
   - Works on commits, not packfiles
 - Incremental updates?
   - Can be; has "additive", which is still O(n), not O(new)
   - Small enough that not really useful to do the split-index trick for later merge
   - 1/10 of .idx content
   - Nothing to update on commit, etc because it's optional
 - GVFS has daily prefetch; this also gets the new DAG cache
 - If one knows that the timestamps are perfect, then is there a need for generation numbers?
   - Two reasons: timestamps need to be 64bit in priority queue; also need a way to promise that there is no clockskew
   - Could add a config option to promise timestamps are right?
   - We already do that; 5 in a row that are wrong will give a wrong answer in `git log`
   - Even without generation numbers, still useful
   - All about being able to make promises, instead of worrying about that one bad commit
   - Suspect because they push everything down as far as possible; generation numbers are probably small, vs broad for timestamps?
 - Does it now have a gc/fsck?
   - Requires running it yourself now
   - GC to generate it, fsck needs strong guarantees about the file
   - Those files can happen at the same time as generation numbers
   - Probably `git-commit-graph.auto` that can be turned on
   - Eventually opt-out and not opt-in


Pitch of research on Git (Gabriel)
----------------------------------
 - PhD student researching version control amd how it has changed practices in software development
 - Understanding open source projects, working on large-scale codebases
 - Takes into account the tools that allow it to work
 - Working on it for 1y
 - Focused on the history of git first
 - Why was it invented when it was?
 - Historical flame wars about CVS, BitKeeper, etc
 - Combine graph analysis and time analysis looking for patterns where new features changed how development happens
 - Also now meeting git developers, and how brainstorming happens
 - Knowing why you contribute to git, how it relates to your work
 - Research is ongoing, no results yet

Questions:
 - Results that are of interest to sociologists -- also to the community?
   - Most will be obvious to you
   - But some data analysis may also prove some intuitions
   - e.g. how much does one section of code stay unchanged over time?
 - Statistics on the git project itself?  Program manager asked why google pays to work on git
   - One of the main reasons is to generate traces of work
   - Proof of what has happened
   - Tips about how best to extract data from the logs
 - Git community exclusively?
   - Focus on git itself
   - Input from other version control systems; CVS/Subversion/etc
 - Interested in seeing what made git popular


Repository OO (Stefan)
----------------------
 - submodules were hard to get into git
 - shell into the submodule, which is inefficient
 - want to run in the same process
 - but need to have abstractions for repositories
 - how to get help / reviews / refactoring
 - a lot of grunt work
 - refactoring is not just for submodules, but also for multi-threading; need structure to put mutex
 - advice for people who are adding globals, about where to put them
 - passing repository down to the methods, instead of a global
 - except not all methods have that parameter
 - like sha1 -> objectid; pick one part, and work on it
 - use coccinelle
 - unclear what the action item is here?
 - most of the work is in finding boundaries to split out
 - have a "the repository" pointer, work from the deepest levels of the stack up
   - that's what is currently done
 - libgit might be able to speak to some difficulties -- stashes / refs
 - not about inheritance, more about stack-global state
 - not buying into OO C pain, but being able to swap out the object backend
 - about reusable, ant not shelling out, not really "true OO"
 - grafts + replacement refs are loaded just once, then submodules are loaded, so submodules can be grafted in the main repo (!)
 - someplaces we merge object stores from the subrepo into the main object store
 - also need to change attributes, config, etc
 - also need to include the index
 - theindex can become macro for the therepository.theindex
 - endgame is to have all builtins give a repository, configset to work on (and then remove therepository)
 - have therepository be a pointer as you push onto as you enter the submodules codepath
 - implement it as dynamic scoping
 - but that doesn't help with threading
 - hacky, but might give some quick gains
 - exception handling within a submodule?
 - doing them in-process gives better error handling than exec and parse the error code
 - do it like refs code, which builds up error code in a strbuf
 - how to get it into next in a way that doesn't cause a lot of conflicts
 - could be merged directly into master?
 - any way to feed them in incrementally?
 - junio is currently treating as not a special series
 - conflict with objectid
 - trickling patches means needs reviewers
 => Please help review this patch series


Index format / API (Jeff H)
---------------------------
 - referenced everywhere via macros
 - needs above refactoring to fix thread safety
 - index is great big linear thing
 - about 40 places that just do a serial scan
 - list is ordered by pathname, difficult to search on
 - no way to "work on a directory" without a bunch of locking/coordination
 - invest in an index API which would allow higher-level operations than for loop
 - expose directories as the API
 - have API methods to work on directories
 - shallow clone recurses with a prefix to change, and does things deep in the recursion
 - directory iterators that know (once loaded) what a directory is, let sparse skip by directory
 - as iterating, need to insert; fine with single-threaded, horrible with multi-threaded
 => Do we want higher-level iterators on the index?
 - hierarchical information baked into the format, don't need to load entire thing to write out
 - don't need to read whole thing (e.g. 450M for Windows) to insert a single row

Questions:
 - Index serves dual index -- staging area for commit, also optimization for ext2
   Split into differential from HEAD, other part is acceleration (fsmonitor)
    - having a staging area that is less cache makes it easier to explain
 - Refs code has an iterator concept to build on?
    - iterators are composable, though somewhat painful in C
 - Packed refs is similar in the problems and size and hierarchy
    - almost every git command searches through refs/replace/
    - invalidation of tree objects as soon as their contents are changed (?)
 - split index just solves the write problem, not the read problem
 - filesystem mtime cache + difference from HEAD
 - but both need to mention filesystem paths
 - alter format to have hierarchy at the same time?
 - reftable might share an object model?
 - there was a GSOC series for partially-read index, but needs better index abstraction
 - abstracted iterator for the for loops, then look at the other places
 - probably 4-5 different iterators


Performance misc (Ævar)
-----------------------
 - Status update on what helps performance
 - traversal stuff, protocol v2
 - other small performance tweaks
 - strbuf %s took up 12% of CPU
 - abbreviation fix is in 2.16
 - gprof / visual studio build to profile
 - delayed checkout
   - 2.14 git batches these clean/smudge commands
   - possible to clean/smudge "not now, try later"
   - helps with downloads with LFS
 - central error reporting for git
   - `git status` logging
   - git config that collects data, pushes to known endpoint with `git push`
   - pre_command and post_command hooks, for logs
   - `gvfs diagnose` that looks at packfiles, etc
   - detect BSODs, etc
   - Dropbox writes out json with index properties and command-line information for status/fetch/push, fork/execs external tool to upload
   - windows trace facility; would be nice to have cross-platform
   - would hosting providers care?
   - zipfile of logs to give when debugging
   - sanitizing data is harder
   - more in a company setting
   - fileshare to upload zipfile
   - most of the errors are proxy when they shouldn't, wrong proxy, proxy specific to particular URL; so upload endpoint wouldn't work
   - GIT_TRACE is supposed to be that (for proxy)
   - but we need more trace variables
   - series to make tracing cheaper
   - except that curl selects the proxy
   - trace should have an API, so it can call an executable
   - dump to .git/traces/... and everything else happens externally
   - tools like visual studio can't set GIT_TRACE, so
   - sourcetree has seen user environments where commands just take forever
   - third-party tools like perf/strace - could we be better leveraging those?
   - distribute turn-key solution to handout to collect more data?

 - git-sizer measures various measures (trees, biggest checkout, etc)

 - fsmonitor code has home rough edges still, but has proven useful
   - alexmv to upstream the faster Go watchman client, rewrite in C for portability


Multipack index (stolee)
------------------------
 - can't repack the Windows repo, it's too big
 - 150-200 packfiles, because they don't have enough space to have 2 copies to repack
 - searches are no longer O(log N), but rather O(M * log N)
 - one multipack index that tells you which packfile and index into that
 - RFC now; queued up after the commit graph work
 - needs to have interactions with fsck and gc
 - at very least delete the .midx
 - larger file; sum of all idx; would be good to be incremental
 - do it like the split index
 - also for build machines that turn off auto gc, but don't ever gc
 - repo with big blogs that don't delta compress well, isolate into their own packfiles
 - VSTS splits into 4M index files by type
 - takes apart incoming packfiles; this does not re-delta
 - if you order them by traversal order...
 - use thin packs
 - does not delete idx files, supplements them
 - might envision dropping idx files, storing thin packs


Conservancy update (peff)
-------------------------
 - same business as usual
 - some money ($25k), more than we need, not enough to do anything
 - trademark stuff has settled down
 - clarified policies around trademark
 - project leadership committee of three; Shawn Pierce died, leaving a vacancy
 - charter says a simple majority vote of remaining members to choose new one
 - will take it to the mailing list
 - not a lot of resposibilities; authority over the resources that the project owns (bank account), website
 - explicitly no authority over the development; conservancy says that coding is the domain of the project itself
 - spend on travel to git merge, etc
 - from GSOC / Amazon royalties / donations
 - "enforce" the trademark; lawyer from conservancy informs committee 1/month
 - most don't get authority (commercial "git foo") some do (git logo keycaps)


Git website (peff)
------------------
 - less in danger of falling over than before


New hash (Stefan, etc)
----------------------
 - discussed on the mailing list
 - actual plan checked in to Documentation/technical/hash-function-transition.txt
 - lots of work renaming
 - any actual work with the transition plan?
 - local conversion first; fetch/push have translation table
 - like git-svn
 - also modified pack and index format to have lookup/translation efficiently
 - brian's series to eliminate SHA1 strings from the codebase
 - testsuite is not working well because hardcoded SHA1 values
 - flip a bit in the sha1 computation and see what breaks in the testsuite
 - will also need a way to do the conversion itself; traverse and write out new version
 - without that, can start new repos, but not work on old ones
 - on-disk formats will need to change -- something to keep in mind with new index work
 - documentation describes packfile and index formats
 - what time frame are we talking?
 - public perception question
 - signing commits doesn't help (just signs commit object) unless you "recursive sign"
 - switched to SHA1dc; we detect and reject known collision technique
 - do it now because it takes too long if we start when the collision drops
 - always call it "new hash" to reduce bikeshedding
 - is translation table a backdoor? has it been reviewed by crypto folks?
   - no, but everything gets translated
 - meant to avoid a flag day for entire repositories
 - linus can decide to upgrade to newhash; if pushes to server that is not newhash aware, that's fine
 - will need a wire protocol change
 - v2 might add a capability for newhash
 - "now that you mention md5, it's a good idea"
 - can use md5 to test the conversion
 - is there a technical reason for why not /n/ hashes?
 - the slow step goes away as people converge to the new hash
 - beneficial to make up some fake hash function for testing
 - is there a plan on how we decide which hash function?
 - trust junio to merge commits when appropriate
 - conservancy committee explicitly does not make code decisions
 - waiting will just give better data
 - some hash functions are in silicon (e.g. microsoft cares)
 - any movement in libgit2 / jgit?
   - basic stuff for libgit2; same testsuite problems
   - no work in jgit
 - most optimistic forecast?
   - could be done in 1-2y
 - submodules with one hash function?
   - unable to convert project unless all submodules are converted
   - OO-ing is not a prereq


Resumable clone (peff)
----------------------
 - also resumable fetch
 - a lot of proposals use a bundle, do that over resumable protocol
 - might be able to put it into the protocol
 - exact byte-for-byte to serve a fetch depends on many things (packfiles, deltas, versions, etc)
 - hash all server variability down
 - if client is cut off halfway, provide the token
 - server asks if on-disk state has changed, throwing up your hands is no worse than now
 - so depends on how often those things change
 - new packs break this, of course
 - reads:writes is 100:1
 - most major hosts have caching infrastructure; protocol change is generic
 - hosting providers can decide to deal this primitive as they will
 - token can provide a high-water mark for the packs to use
 - how does the client know how far it got?
   - byte offset
   - use same ref advertisement
 - likely `git clone --continue` to resume instead of auto-retry
 - overlaps with ability to send multiple packfiles; or using CDN
   - this is not helpful for CDN use case


Ref table (Stefan)
------------------
 - file format invented by Shawn, used server-side
 - efficient for compressing refs
 - smaller than packed refs file by 60%
 - hashes are stored in binary, prefix compression on ref names
 - still binary-searchable gives block in which ref in which ref would be stored
 - from infrastructure point of view, roughly like packfiles
 - eventually GC'd down to one reftable; so need a GC operation
 - gives a new feature to developers: "what did I fetch this morning"
 - reflog can answer updates; reftable can give the contents of one transaction
 - list made reference to some geometric compression
 - also gives atomic reads with all of its references
 - also gives reflogs for deleted references
 - would mean that reftable only has one global lock
 - but contention likely doesn't matter all that much
 - might get a 20ms delay waiting for the lock
 - also helps with case sensitivity of refs
 - need to keep file/directory comparison because back-compat
 - jgit has a reference implementation of reftable
 => multiple people are interested in it; please announce to list if you start working on it


Recreate merges (Johannes)
--------------------------
 - git for windows has patches atop core git (~570 on 70 branches)
 - steadily working towards upstreaming
 - currently have to be forward-ported each time
 - doesn't use rebase because would linearize the commits
 - git "garden shears" to snip the weeds out of the thicket of branches
 - backend to interactive rebase
 - use `exec` verb to make branch structure
 - works fine for a couple years
 - sequencer is now in C, and more performant / cross-platform
 - patch series has two parts
   - implement new verbs: "label" a work-tree-local ref / "reset" can reset to worktree / "merge"
   - write out interactive rebase script
 - problem with merge is how to represent the merge commit
 - `merge -C deadbeef cafe`
 - can create new merges by omitting `-C`
 - useful for patch series splitting into multiple merges
 - "evil" merges because, e.g. upstream changed a signature of a function
 - newest idea is to use duality of rebase/merge
 - pretend that a rebase was a merge; gives you base commit to merge
 - take the old merge commit; merge new tips as if they had been merged into upsteam, with old merge as merge-base
 - intend to introduce atop recreate-merges
 - who needs this, besides GVFS / git for windows?
 - git-imerge to help with rebasing evil-merged mess into a clean series?
 - want a way to train from merge commits and re-apply those?
 - rerere isn't sufficient to push the merge conflicts back; it's too language-agnostic
 - `git rebase -p` would become `--preserve-merges`
 - useful for admins that need to rebase onto rewritten history


Submodules (Stefan)
-------------------
 - want to deprecate `repo` tool
 - google has an internal fork of git that has a submodule workflow
 - doing refactoring first, then modify to add workflows as users want it
 - gave `--recurse-submodules` to more commands
 - in far future want submodules to be more transparent
 - `git commit` should tell you to write two commit messages if you touch things in a submodule
 - unless you specify, you work on the whole super-repo
 - any planned changes to gitlink?
   - no planned changes here
   - `repo` users sometimes want to follow latest master; tells you nothing about a point in time
 - gerrit or CI system can move the subrepo pointers
 - ~1y ago there was a follow-branch feature that confuses users
 - might just be a documentation gap
 - `git submodule update` does let you follow master, though it will show as differences
 - `git mv` does sortof work for submodules
 - submodule merge strategy can solve some of the merge conflicts
 - pull requests to two repos are problematic?  `git pull --rebase --recurse-submodules` will rebase the submodule
 - shared library code does not evolve as fast as main project code


Rebase modality (Stefan)
------------------------
 - problem is `git rebase` forces you into a mode
 - multiple tree entries in a commit which represent the index
 - merge conflict in a rebase could record multiple trees and then keep going
 - would that cause more conflicts later if you defer one? depends on the series
 - if you have a merge, it complains; could instead store higher-stage entries as metadata
 - hardest part is the user interaction; would like to see a side-by-side from the user interaction point of view
 - make sure that earlier conflicts get carried forward
 - some way to dry-run and see which would have conflicts
 - rebase is perhaps not the main gain from this; more that multiple trees may be useful
 - But this leads to explosion of possibilities, which don't actually include all of them!
 - But the dry run still has value
--8323329-495330139-1520640378=:23109--
