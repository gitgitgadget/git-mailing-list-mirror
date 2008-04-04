From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 04 Apr 2008 11:24:51 -0700
Message-ID: <7vbq4pzde4.fsf@gitster.siamese.dyndns.org>
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
 <7vk5jn7hb2.fsf@gitster.siamese.dyndns.org>
 <7v8wzzmgmf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 20:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhqbb-0006G0-I0
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 20:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbYDDSY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756346AbYDDSY7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 14:24:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbYDDSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 14:24:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E85F6F4D;
	Fri,  4 Apr 2008 14:24:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 625356F4C; Fri,  4 Apr 2008 14:24:53 -0400 (EDT)
X-maint-at: f8dd64fdbf47ac65c1b8d2ed25b789ae2655f8c8
X-master-at: 6c41b80153a2e4ee347d0e968ee8d0d9abfc8862
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78810>

* The 'master' branch has these since the last announcement and we are now
  at 1.5.5-rc3.  The real 1.5.5 hopefully this weekend.

Brandon Casey (2):
  mktag.c: improve verification of tagger field and tests
  mktag.c: tweak validation of tagger field and adjust test script

Christian Couder (1):
  help: Add a missing OPT_END().

Damien Diederen (7):
  cvsserver: Respond to the 'editors' and 'watchers' commands
  cvsserver: Only print the file part of the filename in status header
  cvsserver: Do not include status output for subdirectories if -l is
    passed
  cvsserver: Add a few tests for 'status' command
  cvsserver: Implement update -p (print to stdout)
  cvsserver: Add test for update -p
  cvsserver: Use the user part of the email in log and annotate results

Johannes Sixt (3):
  filter-branch: Test renaming directories in a tree-filter
  verify-tag: Clean up the temporary file if gpg cannot be started.
  t7004-tag: Skip more tests if gpg is not available.

Jonathan del Strother (1):
  git-gui: Add shortcut keys for Show More/Less Context

Josh Elsasser (1):
  Allow git-cvsserver database table name prefix to be specified.

Junio C Hamano (2):
  Accept git aliases outside a git repository
  GIT 1.5.5-rc3

Paolo Bonzini (1):
  git-cvsserver: handle change type T

Shawn O. Pearce (1):
  git-gui 0.10

Teemu Likonen (1):
  Describe the bug in handling filenames with funny characters in 'git add
    -i'

veillette@yahoo.ca (1):
  filter-branch: Fix renaming a directory in the tree-filter
