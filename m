From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 09 Dec 2007 02:32:44 -0800
Message-ID: <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 11:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1JTH-0004KS-Br
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbXLIKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 05:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXLIKcy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:32:54 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:52418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbXLIKcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:32:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F69E5362;
	Sun,  9 Dec 2007 05:32:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A19FE535B;
	Sun,  9 Dec 2007 05:32:46 -0500 (EST)
X-maint-at: 6281f394674bf2db861967da6c2215cfc3fc78af
X-master-at: 4eb39e9bcccc54eb23af8a7e2676c63e5bf32866
In-Reply-To: <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2007 01:50:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67617>

One more topic remains in 'next' before 1.5.4-rc0 where "bugfix only"
freeze period begins.  We have a handful regression fixes on 'master'
from the fallout from massive C-rewrite during this cycle.

People still following 'next' are requested to switch to 'master', and
spare a bit more time on finding and fixing regressions there instead of
coming up with new topics from now on.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Jim Meyering (1):
  config.c:store_write_pair(): don't read the byte before a malloc'd
    buffer.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Jeff King (3):
  wt-status.c:quote_path(): convert empty path to "./"
  add status.relativePaths config variable
  git-status: documentation improvements

Junio C Hamano (13):
  War on whitespace: first, a bit of retreat.
  git-diff: complain about >=8 consecutive spaces in initial indent
  core.whitespace: add test for diff whitespace error highlighting
  builtin-apply: rename "whitespace" variables and fix styles
  builtin-apply: teach whitespace_rules
  core.whitespace: documentation updates.
  Use gitattributes to define per-path whitespace rule
  git-bisect visualize: work in non-windowed environments better
  mailmap: fix bogus for() loop that happened to be safe by accident
  shortlog: code restructuring and clean-up
  ls-remote: resurrect pattern limit support
  Fix commit-msg hook to allow editing
  Re-fix "builtin-commit: fix --signoff"

Nicolas Pitre (3):
  pack-objects: fix delta cache size accounting
  pack-objects: reverse the delta search sort list
  pack-objects: fix threaded load balancing

Pini Reznik (1):
  Open external merge tool with original file extensions for all three
    files

Sergei Organov (1):
  Let git-help prefer man-pages installed with this version of git

Wincent Colaiuta (4):
  Teach "git add -i" to colorize whitespace errors
  Allow --no-verify to bypass commit-msg hook
  Documentation: fix --no-verify documentation for "git commit"
  Add tests for pre-commit and commit-msg hooks
