From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 14 Apr 2008 00:00:26 -0700
Message-ID: <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 09:01:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIgy-0006uo-HX
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYDNHAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 03:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbYDNHAm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:00:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYDNHAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 03:00:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96D9F37C9;
	Mon, 14 Apr 2008 03:00:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EA05537C7; Mon, 14 Apr 2008 03:00:37 -0400 (EDT)
X-maint-at: 02604e293a3b7d48b0ce4e34149de8dc89c674e5
X-master-at: f43e2fd43b50d5a82a34bb3e4f848cb38bf93b7f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79470>

* The 'maint' branch has these fixes since v1.5.5; perhaps v1.5.5.1 mid
  next week.

Bj=C3=B6rn Steinbrink (1):
  Fix section about backdating tags in the git-tag docs

Carlos Rica (2):
  Fix documentation syntax of optional arguments in short options.
  core-tutorial.txt: Fix showing the current behaviour.

Christian Couder (2):
  bisect: fix bad rev checking in "git bisect good"
  bisect: report bad rev better

Clifford Caoile (1):
  Docs gitk: Explicitly mention the files that gitk uses (~/.gitk)

Daniel Barkalow (1):
  Fix config key miscount in url.*.insteadOf

Dirk Suesserott (1):
  Documentation/git-request-pull: Fixed a typo ("send" -> "end")

Jeff King (1):
  git-fetch: fix status output when not storing tracking ref

Johannes Sixt (1):
  Document option --only of git commit

Junio C Hamano (3):
  Document -w option to shortlog
  Documentation/git-submodule: typofix
  t7401: squelch garbage output

Michele Ballabio (1):
  revision.c: make --date-order overriddable

Pedro Melo (1):
  Force the medium pretty format on calls to git log

Ping Yin (1):
  git-submodule: Avoid 'fatal: cannot describe' message

Ren=C3=A9 Scharfe (1):
  git-archive: ignore prefix when checking file attribute


* The 'master' branch has these since the last announcement
  in addition to the above.

Christian Couder (1):
  bisect: add "git bisect help" subcommand to get a long usage string

Johannes Sixt (1):
  builtin-commit.c: Remove a redundant assignment.

Junio C Hamano (1):
  git_config_bool_or_int()
