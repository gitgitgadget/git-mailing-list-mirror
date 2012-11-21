From: Junio C Hamano <gitster@pobox.com>
Subject: Topics currently in the Stalled category
Date: Tue, 20 Nov 2012 16:05:41 -0800
Message-ID: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
 <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 01:06:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaxpH-00025P-Us
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 01:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab2KUAFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 19:05:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab2KUAFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 19:05:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E8FA6D0;
	Tue, 20 Nov 2012 19:05:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=veUaiQmKwk0rjRoBU0CA7kjins4=; b=kNTA2t
	SxeLy4vBpXUaGc3bBn0x7gfKx/SJ0l7+F1z1OUif0R7OuzOS9+dQ3DgvyCQL6KSz
	HFiqyy3xBWxHo3gLmMOZCN5FGOqPUT0JsfHKbqOhLuFCXvdZKch7IE2FUaFnfHjI
	kvFRRsIyfayvwUYzXazsCSIxi2Bt7PoD5rn9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WU9tDkmv2TtEvjiZ/5m+VnzhAzVTJ7NA
	/Xhb041f5CZ7QsnLR/81UdRhghORv2Y8L5YDXz4LmfnHHj2yAmDfv576EyOy4ggw
	jjmfadthZ5wowoR7QQsoYxve5zJOQjWORSTvLran0XdRyRYH7RnSdRvc0XwOT8yW
	73Jvfhuj99E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56967A6CF;
	Tue, 20 Nov 2012 19:05:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67208A6CD; Tue, 20 Nov 2012
 19:05:42 -0500 (EST)
In-Reply-To: <7vy5hvq1ey.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 20 Nov 2012 15:50:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30999830-336F-11E2-ADEB-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210126>

Here is a list of stalled topics I am having trouble deciding what
to do (the default is to dismiss them around feature freeze).

* fc/fast-export-fixes (2012-11-08) 14 commits

 Renaming of remote-testgit feels to be a mistake.  It probably
 should keep its source in remote-testgit.bash and generate it, and
 moreover, if it wants to rename remote-testgit.py to remote-testpy,
 the new one should be called remote-testbash.  There was one reroll
 after what used to be queued, but nobody seemed to be interested in
 reviewing the series.

 This mostly happened while I was away, and judging from the
 discussion around this topic (and earlier iterations), I do not
 feel comfortable merging this series (or v5 reroll) as-is.

 Help?


* pf/editor-ignore-sigint (2012-11-11) 5 commits

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Some people raised issues with emacsclient, which are addressed by this
 re-roll. It should probably also handle SIGQUIT, and there were a
 handful of other review comments.

 Anybody interested in moving this forward?
 

* mo/cvs-server-updates (2012-10-16) 10 commits
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic

 Needs review by folks interested in cvsserver.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
 - config: exit on error accessing any config file
 - doc: advertise GIT_CONFIG_NOSYSTEM
 - config: treat user and xdg config permission problems as errors
 - config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT; I think a bit more refactored approach to consistently
 address permission errors across config, exclude and attrs may be
 desirable.

 Should we merge this as-is and build on top?  What are the chances
 of potential regressions?


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name

 Duy helped to reroll this, but it seems that there weren't any
 activity since then during my absense.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Is this still in "Needs review" state?  Are people involved in the
 remote interface happy with this change?


* jk/send-email-sender-prompt (2012-11-15) 8 commits
 - send-email: do not prompt for explicit repo ident
 - Git.pm: teach "ident" to query explicitness
 - var: provide explicit/implicit ident information
 - var: accept multiple variables on the command line
 - ident: keep separate "explicit" flags for author and committer
 - ident: make user_ident_explicitly_given static
 - t7502: factor out autoident prerequisite
 - test-lib: allow negation of prerequisites

 Avoid annoying sender prompt in git-send-email, but only when it is
 safe to do so.

 Perhaps keep only the first three patches, and replace the rest
 with the one from Felipe that takes a much simpler approach (the
 rationale of that patch needs to be cleaned up first, along the
 lines Jeff outlined, though).  Frozen until that happens.


* nd/unify-appending-of-s-o-b (2012-11-15) 1 commit
 - Unify appending signoff in format-patch, commit and sequencer

 I am not sure if the logic to refrain from adding a sign-off based
 on the existing run of sign-offs is done correctly in this change.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.


* mh/ceiling (2012-10-29) 8 commits
 - string_list_longest_prefix(): remove function
 - setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 - longest_ancestor_length(): require prefix list entries to be normalized
 - longest_ancestor_length(): take a string_list argument for prefixes
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

 I think the fear that this would regress the intended use case of
 the environment variable turned out to be unfounded during the
 discussion.

 Should we merge this as-is to 'next', cook for a while to make sure
 nobody screams?

Thanks.
