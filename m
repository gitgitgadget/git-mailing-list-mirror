From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 21 Jun 2008 03:06:52 -0700
Message-ID: <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 12:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA01J-0002qr-1R
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 12:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbYFUKHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jun 2008 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYFUKHF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 06:07:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYFUKHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jun 2008 06:07:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1255DA814;
	Sat, 21 Jun 2008 06:07:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6CCD3A813; Sat, 21 Jun 2008 06:06:56 -0400 (EDT)
X-maint-at: 3b2bbe9b8584947e33e9149f605149530faa7361
X-master-at: 73f03627f4f1b0f66b30fa96a25537f3600cce0b
In-Reply-To: <7vwsknyz9m.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 18 Jun 2008 00:32:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB044968-3F79-11DD-8C7B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85703>

* The 'maint' branch has now preparing for 1.5.6.1, with these noncriti=
cal
  fixes.

Brandon Casey (2):
  git-merge.sh: fix typo in usage message: sucesses --> succeeds
  t7502-commit.sh: test_must_fail doesn't work with inline environment
    variables

Dan McGee (1):
  completion: add --graph to log command completion

Jan Kr=C3=BCger (1):
  Documentation: fix formatting in git-svn


* The 'master' branch has these since the last announcement
  in addition to the above.  Not much to see here (yet).

Cristian Peraferrer (1):
  Print errno upon failure to open the COMMIT_EDITMSG file

Jakub Narebski (1):
  t/README: Add 'Skipping Tests' section below 'Running Tests'

Lea Wiemann (1):
  test-lib.sh: add --long-tests option

Lukas Sandstr=C3=B6m (1):
  Add a helper script to send patches with Mozilla Thunderbird

Shawn O. Pearce (1):
  Correct documentation for git-push --mirror

Teemu Likonen (2):
  bash: Add more option completions for 'git log'
  Add target "install-html" the the top level Makefile
