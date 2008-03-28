From: Junio C Hamano <gitster@pobox.com>
Subject: What's outstanding
Date: Thu, 27 Mar 2008 23:17:16 -0700
Message-ID: <7v4par4bkj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 07:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf7uf-0007Pn-Dv
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 07:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYC1GRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 02:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbYC1GRZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 02:17:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYC1GRW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 02:17:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F0712DD2;
	Fri, 28 Mar 2008 02:17:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7CEBF2DD1; Fri, 28 Mar 2008 02:17:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78386>

Here is the index of topics that I am aware of; some of them may not be
anywhere in git.git.


Regressions?

* fetch with "refs/*:refs/*" errors out erroneously
  http://article.gmane.org/gmane.comp.version-control.git/77335

I think tonight's patch would fix it; let's see how well it goes...

* "git fetch" shows error when dangling symref exists at the remote
  but does not really error out
  http://article.gmane.org/gmane.comp.version-control.git/76658

* "git fetch" does not exit with non-zero status when it failed to update
  some refs due to non-ffness
  http://article.gmane.org/gmane.comp.version-control.git/77178



New features that won't be merged before 1.5.5 final.

* ff=only (Sverre Hvammen Johansen)
  http://article.gmane.org/gmane.comp.version-control.git/78250

  With vastly improved documentation and justification compared to the
  previous rounds, I am beginning to actulaly like this series.

* more help backends (Christian Couder)
  http://article.gmane.org/gmane.comp.version-control.git/78150

  With the documentation clarification the overall idea looked fine.

* cvsserver updates (Damien Diederen with help by Frank Lichtenheld)
  http://article.gmane.org/gmane.comp.version-control.git/78188

  Looked cleanly done.

* use single database to serve more than one cvsserver instances (Josh Elsasser)
  http://article.gmane.org/gmane.comp.version-control.git/78366

  Looked cleanly done.

* rewriting annotated tags in filter-branch (Brandon Casey)
  http://article.gmane.org/gmane.comp.version-control.git/78286

  I haven't been heavily involved in this program, neither as a user nor a
  designer, so I am not absolutely sure about the details, but the idea
  looked clean and sane.

* git lost-found vs git fsck --lost-found (me)
  http://article.gmane.org/gmane.comp.version-control.git/78267

* core.inithook (Dscho)
  http://article.gmane.org/gmane.comp.version-control.git/78123

  This would hopefully give a cleaner way for mingw folks to futz with
  core.autocrlf without breaking existing setups.

* receive.localBranches = { refuse | allow } (Dscho)
  http://article.gmane.org/gmane.comp.version-control.git/78065

  The infamous "do not push into a repository with work tree".

* autosetting core.ignorecase (Dmitry Potapov)
  http://article.gmane.org/gmane.comp.version-control.git/78176

  Follow-up to Linus's "case insensitive" git

* mailinfo extention to extract Message-ID and others (Anton Gladkov)
  http://article.gmane.org/gmane.comp.version-control.git/78006

* add -p with mode change (Jeff King)
  http://article.gmane.org/gmane.comp.version-control.git/78340

* rebase -p
  http://article.gmane.org/gmane.comp.version-control.git/78074

  I highly suspect that this is much deeper than just the implementation.

* synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
  http://article.gmane.org/gmane.comp.version-control.git/72243

  I sent an invitation for this topic earlier, but we are at -rc2 and it
  is too late for 1.5.5 now.

* "[alias] st = status" and "cd .git && git st" (Jeff King)
  http://article.gmane.org/gmane.comp.version-control.git/72327

* use "assume unchanged" bit to implement narrow checkout
  http://article.gmane.org/gmane.comp.version-control.git/77046

* send-pack vs receive-pack history exchange (me)
  http://article.gmane.org/gmane.comp.version-control.git/77643

* zlib abstraction (Marco)
  http://article.gmane.org/gmane.comp.version-control.git/72262

* git --index-file=<foo> <cmd> (Linus)
  http://article.gmane.org/gmane.comp.version-control.git/77332
