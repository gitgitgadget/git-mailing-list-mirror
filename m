From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 23 Jun 2008 00:25:33 -0700
Message-ID: <7vej6oipea.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAgRm-00088z-Pu
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 09:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbYFWHZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFWHZr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 03:25:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYFWHZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 03:25:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E8F09206B8;
	Mon, 23 Jun 2008 03:25:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C96EB206B7; Mon, 23 Jun 2008 03:25:41 -0400 (EDT)
X-maint-at: 010a2dacc1acf3305e399ef1eb2e620110b95d5e
X-master-at: 112db553b0db4c4f2b39e5e3e433b2102be10085
In-Reply-To: <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 21 Jun 2008 03:06:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97D45CAE-40F5-11DD-B7AF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85844>

There are a few more fixes destined for maint, being tested in next fir=
st.

* The 'maint' branch has these fixes since the last announcement.

Michele Ballabio (1):
  parse-options.c: fix documentation syntax of optional arguments

Stephan Beyer (3):
  api-builtin.txt: update and fix typo
  api-parse-options.txt: Introduce documentation for parse options API
  Extend parse-options test suite


* The 'master' branch has these since the last announcement
  in addition to the above.

Jakub Narebski (2):
  gitweb: Separate filling list of projects info
  gitweb: Separate generating 'sort by' table header

Jeff King (5):
  fix whitespace violations in test scripts
  mask necessary whitespace policy violations in test scripts
  avoid whitespace on empty line in automatic usage message
  avoid trailing whitespace in zero-change diffstat lines
  enable whitespace checking of test scripts

Junio C Hamano (1):
  diff -c/--cc: do not include uninteresting deletion before leading
    context

Karl Hasselstr=C3=B6m (2):
  Clean up builtin-update-ref's option parsing
  Make old sha1 optional with git update-ref -d

Linus Torvalds (3):
  racy-git: an empty blob has a fixed object name
  Make git_dir a path relative to work_tree in setup_work_tree()
  Shrink the git binary a bit by avoiding unnecessary inline functions

Marius Storm-Olsen (3):
  Add an optional <mode> argument to commit/status -u|--untracked-files
    option
  Add argument 'no' commit/status option -u|--untracked-files
  Add configuration option for default untracked files mode

Nanako Shiraishi (2):
  environment.c: remove unused function
  config.c: make git_env_bool() static

Pieter de Bie (1):
  builtin-fast-export: Add importing and exporting of revision marks

Rafael Garcia-Suarez (1):
  gitweb: remove git_blame and rename git_blame2 to git_blame

Ren=C3=A9 Scharfe (1):
  Teach new attribute 'export-ignore' to git-archive
