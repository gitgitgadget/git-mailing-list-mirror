From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 08 Mar 2008 02:08:49 -0800
Message-ID: <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 11:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXw06-0000Fo-Vb
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 11:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYCHKI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2008 05:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYCHKI5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 05:08:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYCHKI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 05:08:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7501A294A;
	Sat,  8 Mar 2008 05:08:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 83AD72947; Sat,  8 Mar 2008 05:08:52 -0500 (EST)
X-maint-at: c8744d6a8b27115503565041566d97c21e722584
X-master-at: 60e3cad92ed93120b9e77116163b267fdda44f91
In-Reply-To: <7v8x0wie56.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 05 Mar 2008 22:02:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76556>

There are about half a dozen topics that need to be merged to 'maint'
before 1.5.4.4 can happen, which hopefully will be mid next week.  They
are already in 'master' and we haven't heard about breakages with them.

It would be really nice to also have msgfmt issue on OSX resolved (e.g.
http://article.gmane.org/gmane.comp.version-control.git/76355) before
that.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Junio C Hamano (1):
  test-lib: fix TERM to dumb for test repeatability

Pierre Habouzit (1):
  unquote_c_style: fix off-by-one.

Shawn O. Pearce (1):
  git-gui: Gracefully fall back to po2msg.sh if msgfmt --tcl fails

Uwe Kleine-K=C3=B6nig (1):
  config.txt: refer to --upload-pack and --receive-pack instead of --ex=
ec


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Do not use GUID on dir in git init --shared=3Dall on FreeBSD

Brandon Casey (10):
  builtin-reflog.c: fix typo that accesses an unset variable
  reflog-delete: parse standard reflog options
  git-reflog: add option --rewrite to update reflog entries while expir=
ing
  refs.c: make close_ref() and commit_ref() non-static
  git-reflog: add option --updateref to write the last reflog sha1 into=
 the
    ref
  git-stash: add new 'drop' subcommand
  git-stash: add new 'pop' subcommand
  t3903-stash.sh: Add missing '&&' to body of testcase
  git-reflog.txt: Document new commands --updateref and --rewrite
  t3903-stash.sh: Add tests for new stash commands drop and pop

Charles Bailey (4):
  Tidy up git mergetool's backup file behaviour
  Changed an internal variable of mergetool to support custom commands
  Teach git mergetool to use custom commands defined at config time
  Add a very basic test script for git mergetool

Christian Couder (1):
  run-command: Redirect stderr to a pipe before redirecting stdout to
    stderr

Denis Cheng (3):
  whatchanged documentation: share description of --pretty with others
  specify explicit "--pretty=3Dmedium" with `git log/show/whatchanged`
  log/show/whatchanged: introduce format.pretty configuration

Johannes Schindelin (1):
  Teach "git reflog" a subcommand to delete single entries

Junio C Hamano (1):
  send-email: --no-signed-off-cc should suppress 'sob' cc

