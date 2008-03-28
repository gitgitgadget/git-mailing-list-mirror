From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Thu, 27 Mar 2008 18:45:05 -0700
Message-ID: <7vk5jn7hb2.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
 <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
 <7vfxv0npis.fsf@gitster.siamese.dyndns.org>
 <7vod9hr7p1.fsf@gitster.siamese.dyndns.org>
 <7veja192i4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 02:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf3fL-0001y2-0Q
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 02:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYC1BpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 21:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYC1BpQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 21:45:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYC1BpO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 21:45:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91EC715FE;
	Thu, 27 Mar 2008 21:45:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22EC715FD; Thu, 27 Mar 2008 21:45:07 -0400 (EDT)
X-maint-at: 24362a5d3ffc5ef10ccbcd80b258a418a1c792b5
X-master-at: 1768905b51601d5d080168059acd24d13b888a2d
In-Reply-To: <7veja192i4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Mar 2008 03:08:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78379>

Again with a handful fixes, the most important of which is for regressi=
on
introduced in 1.5.4 to "git fetch" (if you are using .git/branches/it t=
o
name your remote repositories, "git fetch it" should update your local
"it" branch but it doesn't since the breakage), maybe we would need
another maintenance branch soon from 'maint'.

With fixes to a handful regressions in the changes that happened during
the 1.5.5 cycle, 'master' is nearling -rc2, which hopefully will happen
soon.  There still are one or two topics we may want to merge from 'nex=
t',
but at this point both testers and developers are encouraged to switch =
to
'master' if you have been using 'next' for your real work to catch the
last minute glitches.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (1):
  t/t3800-mktag.sh: use test_must_fail rather than '!'

Daniel Barkalow (2):
  Tighten refspec processing
  Fix branches file configuration

Guanqun Lu (1):
  Fix the wrong output of `git-show v1.3.0~155^2~4` in documentation.

Jeff King (1):
  Documentation: clarify use of .git{ignore,attributes} versus .git/inf=
o/*

Junio C Hamano (2):
  git-fetch test: test tracking fetch results, not just FETCH_HEAD
  Update draft release notes for 1.5.4.5


* The 'master' branch has these since the last announcement
  in addition to the above.

Dirk S=C3=BCsserott (1):
  Documentation: git-tag '-m'/'-F' implies '-a'

=46rank Lichtenheld (1):
  t9600-cvsimport.sh: set HOME before checking for cvsps availability

Gerrit Pape (1):
  imap-send: properly error out if imap.host is not set in config

Guanqun Lu (1):
  Fix the wrong output of `git-show v1.3.0~155^2~4` in documentation.

Johannes Schindelin (2):
  RelNotes: mention checkout/branch's --track option, too
  init: show "Reinit" message even in an (existing) empty repository

Johannes Sixt (1):
  builtin-remote: Fix missing newline at end of listing of pushed branc=
hes

Julian Phillips (1):
  Documentation/git-checkout: Update summary to reflect current abiliti=
es

Junio C Hamano (3):
  refspec: allow colon-less wildcard "refs/category/*"
  test_must_fail: 129 is a valid error code from usage()
  Update draft release notes for 1.5.5

SZEDER G=C3=A1bor (1):
  Always set *nongit_ok in setup_git_directory_gently()
