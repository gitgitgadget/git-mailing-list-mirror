From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Thu, 06 Sep 2007 01:52:50 -0700
Message-ID: <7v3axsch0d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 10:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITD6k-0003uz-Pu
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbXIFIw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbXIFIw6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:52:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbXIFIw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:52:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0130F12F563;
	Thu,  6 Sep 2007 04:53:13 -0400 (EDT)
X-maint-at: 4e560158c6de154fafab9fc3f6028d9edcc53e6b
X-master-at: b5ef6ac978012475660a36583b2174e9bd8188a5
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57842>

* The 'maint' branch has these fixes since v1.5.3.1

Dmitry V. Levin (1):
  Makefile: Add cache-tree.h to the headers list

Junio C Hamano (1):
  git-apply: do not read past the end of buffer

Shawn O. Pearce (3):
  Don't allow contrib/workdir/git-new-workdir to trash existing dirs
  Cleanup unnecessary file modifications in t1400-update-ref
  Include a git-push example for creating a remote branch


* The 'master' branch has these since v1.5.3 in addition to the
  above.

Carlos Rica (1):
  Function for updating refs.

Douglas Stockwell (1):
  send-email: Add support for SSL and SMTP-AUTH

Junio C Hamano (1):
  Start 1.5.4 cycle

Simon Hausmann (8):
  git-p4: Always call 'p4 sync ...' before submitting to Perforce.
  git-p4: After submission to p4 always synchronize from p4 again
      (into refs/remotes). Whether to rebase HEAD or not is still
      left as question to the end-user.
  git-p4: Cleanup; moved the code for getting a sorted list of p4
      changes for a list of given depot paths into a standalone
      method.
  git-p4: Cleanup; moved the code to import a list of p4 changes
      using fast-import into a separate member function of P4Sync.
  git-p4: Cleanup; Turn self.revision into a function local variable
      (it's not used anywhere outside the function).
  git-p4: Cleanup; moved the code for the initial #head or revision
      import into a separate function, out of P4Sync.run.
  git-p4: Cleanup; moved the (duplicated) code for turning a branch
      into a git ref (for example foo ->
      refs/remotes/p4/<project>/foo) into a separate method.
  git-p4: Added support for automatically importing newly appearing
      perforce branches.
