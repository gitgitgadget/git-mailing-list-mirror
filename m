From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [ANNOUNCE] Git v2.2.0
Date: Thu, 27 Nov 2014 13:32:24 -0800
Message-ID: <20141127213224.GA27443@dispater.uplinklabs.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:32:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu6g2-0000ot-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 22:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbaK0Vcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 16:32:35 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62688 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaK0Vcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 16:32:33 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so5477942pac.8
        for <git@vger.kernel.org>; Thu, 27 Nov 2014 13:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=98WZj2o6c0k9tYLPxNDiPG39kEVLoCCAxQXGho5viEI=;
        b=E2M7cAJwC0KR92PHbjwYEKCKgmP94Ct+4o1byv3g67a2kIWpC6eJEos2VqUIU4Qp9z
         ncDyLzoMK2stue2PDOSQkFTB743Bw/EYoeaxi/sOvuM47PzWuQ/qWBSA3E8dzjVHPYQa
         tHAMnWS2rLB5XI2hpgyCiMdJ/mKOKQiztRF14wK4l6g16o2Th3GSxr/5j+Azl4x5a37M
         /QbfFuuIEt0Hj7a3EG1c/usnZbth5CybgFttKSJdbEVyra1RUaN4/8CF7jtx5DXRI2g8
         TD20wmyG8q4MNmn0PGuwsMOse5Y5wt1oy1YtFLHHdQR296FHIFthueUJJbLt5ZKYgnMH
         m7uQ==
X-Gm-Message-State: ALoCoQn1PDHiGhzuSaj1cSgP6HCZyJcJYJZFIOjhhxI8PI8WuLv/AgzfkLbGm0QdiBpPVVxphk5O
X-Received: by 10.70.89.174 with SMTP id bp14mr9161340pdb.136.1417123952754;
        Thu, 27 Nov 2014 13:32:32 -0800 (PST)
Received: from dispater.uplinklabs.net ([2002:6898:6b85:beef:6a05:caff:fe0a:6ec2])
        by mx.google.com with ESMTPSA id ju4sm7897539pbc.81.2014.11.27.13.32.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Nov 2014 13:32:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
Received: by 10.114.229.39 with HTTP; Thu, 27 Nov 2014 12:59:18 -0800 (PST)
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260353>

On Wed, Nov 26, 2014 at 3:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The latest feature release Git v2.2 is now available at the usual
> places.  Big thanks go to 77 contributors, among which 20 are new
> people, who made 550+ changes in total since Git v2.1 was released.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/
>
> The following public repositories all have a copy of the 'v2.2.0'
> tag and the 'master' branch that the tag points at:
>
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = https://code.google.com/p/git-core/
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
>
> Git v2.2 Release Notes
> ======================
>
> Updates since v2.1
> ------------------
>
> Ports
>
>  * Building on older MacOS X systems automatically sets
>    the necessary NO_APPLE_COMMON_CRYPTO build-time option.
>
>  * Building with NO_PTHREADS has been resurrected.
>
>  * Compilation options have been updated a bit to better support the
>    z/OS port.
>
>
> UI, Workflows & Features
>
>  * "git archive" learned to filter what gets archived with a pathspec.
>
>  * "git config --edit --global" starts from a skeletal per-user
>    configuration file contents, instead of a total blank, when the
>    user does not already have any global config.  This immediately
>    reduces the need to later ask "Have you forgotten to set
>    core.user?", and we can add more to the template as we gain
>    more experience.
>
>  * "git stash list -p" used to be almost always a no-op because each
>    stash entry is represented as a merge commit.  It learned to show
>    the difference between the base commit version and the working tree
>    version, which is in line with what "git stash show" gives.
>
>  * Sometimes users want to report a bug they experience on their
>    repository, but they are not at liberty to share the contents of
>    the repository.  "fast-export" was taught an "--anonymize" option
>    to replace blob contents, names of people, paths and log
>    messages with bland and simple strings to help them.
>
>  * "git difftool" learned an option to stop feeding paths to the
>    diff backend when it exits with a non-zero status.
>
>  * "git grep" learned to paint (or not paint) partial matches on
>    context lines when showing "grep -C<num>" output in color.
>
>  * "log --date=iso" uses a slight variant of the ISO 8601 format that is
>    more human readable.  A new "--date=iso-strict" option gives
>    datetime output that conforms more strictly.
>
>  * The logic "git prune" uses is more resilient against various corner
>    cases.
>
>  * A broken reimplementation of Git could write an invalid index that
>    records both stage #0 and higher-stage entries for the same path.
>    We now notice and reject such an index, as there is no sensible
>    fallback (we do not know if the broken tool wanted to resolve and
>    forgot to remove the higher-stage entries, or if it wanted to unresolve
>    and forgot to remove the stage #0 entry).
>
>  * The temporary files "git mergetool" uses are renamed to avoid too
>    many dots in them (e.g. a temporary file for "hello.c" used to be
>    named e.g. "hello.BASE.4321.c" but now uses underscore instead,
>    e.g. "hello_BASE_4321.c", to allow us to have multiple variants).
>
>  * The temporary files "git mergetool" uses can be placed in a newly
>    created temporary directory, instead of the current directory, by
>    setting the mergetool.writeToTemp configuration variable.
>
>  * "git mergetool" understands "--tool bc" now, as version 4 of
>    BeyondCompare can be driven the same way as its version 3 and it
>    feels awkward to say "--tool bc3" to run version 4.
>
>  * The "pre-receive" and "post-receive" hooks are no longer required
>    to consume their input fully (not following this requirement used
>    to result in intermittent errors in "git push").
>
>  * The pretty-format specifier "%d", which expands to " (tagname)"
>    for a tagged commit, gained a cousin "%D" that just gives the
>    "tagname" without frills.
>
>  * "git push" learned "--signed" push, that allows a push (i.e.
>    request to update the refs on the other side to point at a new
>    history, together with the transmission of necessary objects) to be
>    signed, so that it can be verified and audited, using the GPG
>    signature of the person who pushed, that the tips of branches at a
>    public repository really point the commits the pusher wanted to,
>    without having to "trust" the server.
>
>  * "git interpret-trailers" is a new filter to programmatically edit
>    the tail end of the commit log messages, e.g. "Signed-off-by:".
>
>  * "git help everyday" shows the "Everyday Git in 20 commands or so"
>    document, whose contents have been updated to match more modern
>    Git practice.
>
>  * On the "git svn" front, work progresses to reduce memory consumption and
>    to improve handling of mergeinfo.
>
>
> Performance, Internal Implementation, Development Support etc.
>
>  * The API to manipulate the "refs" has been restructured to make it
>    more transactional, with the eventual goal to allow all-or-none
>    atomic updates and migrating the storage to something other than
>    the traditional filesystem based one (e.g. databases).
>
>  * The lockfile API and its users have been cleaned up.
>
>  * We no longer attempt to keep track of individual dependencies to
>    the header files in the build procedure, relying instead on automated
>    dependency generation support from modern compilers.
>
>  * In tests, we have been using NOT_{MINGW,CYGWIN} test prerequisites
>    long before negated prerequisites e.g. !MINGW were invented.
>    The former has been converted to the latter to avoid confusion.
>
>  * Optimized looking up a remote's configuration in a repository with very many
>    remotes defined.
>
>  * There are cases where you lock and open to write a file, close it
>    to show the updated contents to an external processes, and then have
>    to update the file again while still holding the lock; now the
>    lockfile API has support for such an access pattern.
>
>  * The API to allocate the structure to keep track of commit
>    decoration has been updated to make it less cumbersome to use.
>
>  * An in-core caching layer to let us avoid reading the same
>    configuration files several times has been added.  A few commands
>    have been converted to use this subsystem.
>
>  * Various code paths have been cleaned up and simplified by using
>    the "strbuf", "starts_with()", and "skip_prefix()" APIs more.
>
>  * A few codepaths that died when large blobs that would not fit in
>    core are involved in their operation have been taught to punt
>    instead, by e.g. marking a too-large blob as not to be diffed.
>
>  * A few more code paths in "commit" and "checkout" have been taught
>    to repopulate the cache-tree in the index, to help speed up later
>    "write-tree" (used in "commit") and "diff-index --cached" (used in
>    "status").
>
>  * A common programming mistake to assign the same short option name
>    to two separate options is detected by the parse_options() API to help
>    developers.
>
>  * The code path to write out the packed-refs file has been optimized,
>    which especially matters in a repository with a large number of
>    refs.
>
>  * The check to see if a ref $F can be created by making sure no
>    existing ref has $F/ as its prefix has been optimized, which
>    especially matters in a repository with a large number of existing
>    refs.
>
>  * "git fsck" was taught to check the contents of tag objects a bit more.
>
>  * "git hash-object" was taught a "--literally" option to help
>    debugging.
>
>  * When running a required clean filter, we do not have to mmap the
>    original before feeding the filter.  Instead, stream the file
>    contents directly to the filter and process its output.
>
>  * The scripts in the test suite can be run with the "-x" option to show
>    a shell-trace of each command they run.
>
>  * The "run-command" API learned to manage the argv and environment
>    arrays for child process, alleviating the need for the callers to
>    allocate and deallocate them.
>
>  * Some people use AsciiDoctor, instead of AsciiDoc, to format our
>    documentation set; the documentation has been adjusted to be usable
>    by both, as AsciiDoctor is pickier than AsciiDoc about its input
>    mark-up.
>
>
> Also contains various documentation updates and code clean-ups.
>
>
> Fixes since v2.1
> ----------------
>
> Unless otherwise noted, all the fixes since v2.1 in the maintenance
> track are contained in this release (see the maintenance releases'
> notes for details).
>
>  * "git log --pretty/format=" with an empty format string did not
>    mean the more obvious "No output whatsoever" but "Use default
>    format", which was counterintuitive.
>
>  * "git -c section.var command" and "git -c section.var= command"
>    should pass the configuration value differently (the former should be a
>    boolean true, the latter should be an empty string).
>
>  * Applying a patch not generated by Git in a subdirectory used to
>    check for whitespace breakage using the attributes of incorrect
>    paths. Also whitespace checks were performed even for paths
>    excluded via the "git apply --exclude=<path>" mechanism.
>
>  * "git bundle create" with a date-range specification was meant to
>    exclude tags outside the range, but it didn't.
>
>  * "git add x" where x used to be a directory and is now a
>    symbolic link to a directory misbehaved.
>
>  * The prompt script checked the $GIT_DIR/ref/stash file to see if there
>    is a stash, which was a no-no.
>
>  * Pack-protocol documentation had a minor typo.
>
>  * "git checkout -m" did not switch to another branch while carrying
>    the local changes forward when a path was deleted from the index.
>
>  * "git daemon" (with NO_IPV6 build configuration) used to incorrectly
>    use the hostname even when gethostbyname() reported that the given
>    hostname is not found.
>    (merge 107efbe rs/daemon-fixes later to maint).
>
>  * With sufficiently long refnames, "git fast-import" could have
>    overflowed an on-stack buffer.
>
>  * After "pack-refs --prune" packed refs at the top-level, it failed
>    to prune them.
>
>  * Progress output from "git gc --auto" was visible in "git fetch -q".
>
>  * We used to pass -1000 to poll(2), expecting it to also mean "no
>    timeout", which should be spelled as -1.
>
>  * "git rebase" documentation was unclear that it is required to
>    specify on what <upstream> the rebase is to be done when telling it
>    to first check out <branch>.
>    (merge 95c6826 so/rebase-doc later to maint).
>
>  * "git push" over HTTP transport had an artificial limit on the number of
>    refs that can be pushed, imposed by the command line length.
>    (merge 26be19b jk/send-pack-many-refspecs later to maint).
>
>  * When receiving an invalid pack stream that records the same object
>    twice, multiple threads got confused due to a race.
>    (merge ab791dd jk/index-pack-threading-races later to maint).
>
>  * An attempt to remove the entire tree in the "git fast-import" input
>    stream caused it to misbehave.
>    (merge 2668d69 mb/fast-import-delete-root later to maint).
>
>  * Reachability check (used in "git prune" and friends) did not add a
>    detached HEAD as a starting point to traverse objects still in use.
>    (merge c40fdd0 mk/reachable-protect-detached-head later to maint).
>
>  * "git config --add section.var val" when section.var already has an
>    empty-string value used to lose the empty-string value.
>    (merge c1063be ta/config-add-to-empty-or-true-fix later to maint).
>
>  * "git fsck" failed to report that it found corrupt objects via its
>    exit status in some cases.
>    (merge 30d1038 jk/fsck-exit-code-fix later to maint).
>
>  * Use of the "--verbose" option used to break "git branch --merged".
>    (merge 12994dd jk/maint-branch-verbose-merged later to maint).
>
>  * Some MUAs mangle a line in a message that begins with "From " to
>    ">From " when writing to a mailbox file, and feeding such an input
>    to "git am" used to lose such a line.
>    (merge 85de86a jk/mbox-from-line later to maint).
>
>  * "rev-parse --verify --quiet $name" is meant to quietly exit with a
>    non-zero status when $name is not a valid object name, but still
>    gave error messages in some cases.
>
>  * A handful of C source files have been updated to include
>    "git-compat-util.h" as the first thing, to conform better to our
>    coding guidelines.
>    (merge 1c4b660 da/include-compat-util-first-in-c later to maint).
>
>  * The t7004 test, which tried to run Git with small stack space, has been
>    updated to use a bit larger stack to avoid false breakage on some
>    platforms.
>    (merge b9a1907 sk/tag-contains-wo-recursion later to maint).
>
>  * A few documentation pages had example sections marked up not quite
>    correctly, which passed AsciiDoc but failed with AsciiDoctor.
>    (merge c30c43c bc/asciidoc-pretty-formats-fix later to maint).
>    (merge f8a48af bc/asciidoc later to maint).
>
>  * "gitweb" used deprecated CGI::startfrom, which was removed from
>    CGI.pm as of 4.04; use CGI::start_from instead.
>    (merge 4750f4b rm/gitweb-start-form later to maint).
>
>  * Newer versions of 'meld' break the auto-detection we use to see if
>    they are new enough to support the `--output` option.
>    (merge b12d045 da/mergetool-meld later to maint).
>
>  * "git pack-objects" forgot to disable the codepath to generate the
>    object reachability bitmap when it needs to split the resulting
>    pack.
>    (merge 2113471 jk/pack-objects-no-bitmap-when-splitting later to maint).
>
>  * The code to use cache-tree trusted the on-disk data too much and
>    fell into an infinite loop upon seeing an incorrectly recorded
>    index file.
>    (merge 729dbbd jk/cache-tree-protect-from-broken-libgit2 later to maint).
>
>  * "git fetch" into a repository where branch B was deleted earlier,
>    back when it had reflog enabled, and then branch B/C is fetched
>    into it without reflog enabled, which is arguably an unlikely
>    corner case, unnecessarily failed.
>    (merge aae828b jk/fetch-reflog-df-conflict later to maint).
>
>  * "git log --first-parent -L..." used to crash.
>    (merge a8787c5 tm/line-log-first-parent later to maint).

I'm sad to report that I'm getting test failures with this release.
Built from git and did 'make -C t prove NO_SVN_TESTS=1' and got this
result:

$ make -j8
$ make -C t prove NO_SVN_TESTS=1 PROVE="prove -j8"
[...]
Test Summary Report
-------------------
t4202-log.sh                                     (Wstat: 256 Tests: 42 Failed: 2)
  Failed tests:  41-42
  Non-zero exit status: 1
t5534-push-signed.sh                             (Wstat: 256 Tests: 7 Failed: 2)
  Failed tests:  6-7
  Non-zero exit status: 1
t5801-remote-helpers.sh                          (Wstat: 256 Tests: 28 Failed: 2)
  Failed tests:  21-22
  Non-zero exit status: 1
t6050-replace.sh                                 (Wstat: 256 Tests: 33 Failed: 4)
  Failed tests:  30-33
  Non-zero exit status: 1
t6300-for-each-ref.sh                            (Wstat: 256 Tests: 134 Failed: 19)
  Failed tests:  115-133
  Non-zero exit status: 1
t7510-signed-commit.sh                           (Wstat: 256 Tests: 10 Failed: 10)
  Failed tests:  1-10
  Non-zero exit status: 1
t7612-merge-verify-signatures.sh                 (Wstat: 256 Tests: 6 Failed: 5)
  Failed tests:  2-6
  Non-zero exit status: 1
t7600-merge.sh                                   (Wstat: 256 Tests: 49 Failed: 2)
  Failed tests:  48-49
  Non-zero exit status: 1
t7004-tag.sh                                     (Wstat: 256 Tests: 136 Failed: 32)
  Failed tests:  65-66, 69-72, 74-75, 77-100
  Non-zero exit status: 1
Files=685, Tests=11975, 88 wallclock secs ( 3.97 usr  0.70 sys + 73.84 cusr 22.10 csys = 100.61 CPU)
Result: FAIL


I suspect that gnupg v2.1 is to blame somehow (I've had similar bad behavior
with my own projects using GPG in automation). Running through several of the
git tests shows that gpg is failing to sign:


$ make -C t t7510-signed-commit GIT_TEST_OPTS="--verbose --debug"
make: Entering directory '/home/snoonan/Development/git/t'
*** t7510-signed-commit.sh ***
Initialized empty Git repository in /home/snoonan/Development/git/t/trash directory.t7510-signed-commit/.git/
expecting success:
[...]
gpg: starting migration from earlier GnuPG versions
gpg: porting secret keys from '/home/snoonan/Development/git/t/trash directory.t7510-signed-commit/gpghome/secring.gpg' to gpg-agent
gpg: key CDDE430D: secret key imported
gpg: key B7227189: secret key imported
gpg: migration succeeded
gpg: signing failed: Operation cancelled
gpg: signing failed: Operation cancelled
error: gpg failed to sign the data
fatal: failed to write commit object
gpg: signing failed: Operation cancelled
gpg: signing failed: Operation cancelled
error: gpg failed to sign the data
fatal: failed to write commit object
not ok 1 - create signed commits


If I build and install the old gnupg v2.0.26 package, things are
happier:


$ make -C t prove NO_SVN_TESTS=1 PROVE="prove -j8"
[...]
All tests successful.
Files=685, Tests=11975, 87 wallclock secs ( 4.02 usr  0.69 sys + 76.41 cusr 21.96 csys = 103.08 CPU)
Result: PASS


Using Arch Linux on x86_64. Anyone else able to repro?
