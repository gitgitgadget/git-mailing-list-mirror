From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Wed, 30 Jan 2008 00:32:22 -0800
Message-ID: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 09:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK8NT-0006rn-RL
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbYA3Icd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYA3Icd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:32:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbYA3Icc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:32:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18CAC3D4F;
	Wed, 30 Jan 2008 03:32:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1303D4E;
	Wed, 30 Jan 2008 03:32:28 -0500 (EST)
X-maint-at: aadd4efa715f56e0eac5ac459c8ff4933b56d4ce
X-master-at: 0eab8ca68ad7bfcbb7c0aff37985116cbbdacd44
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72051>

There shouldn't be anything eye-popping.  Hopefully we can do
the final soonish, perhaps this weekend.

I may have made small touch-ups to a few commits, so please
check them over.

Thanks.

* The 'master' branch has these since v1.5.4-rc5

Brandon Casey (1):
  git-relink: avoid hard linking in objects/info directory

Bruno Ribas (1):
  gitweb: Make use of the $git_dir variable at sub
    git_get_project_description

Christian Couder (3):
  Documentation: config: add "browser.<tool>.path".
  Documentation: help: specify supported html browsers.
  instaweb: use 'browser.<tool>.path' config option if it's set.

Jakub Narebski (1):
  gitweb: Add info about $projectroot and $projects_list to gitweb/README

Jeff King (1):
  t9001: add missing && operators

Jim Meyering (1):
  fix doc typos

Johannes Schindelin (1):
  Add test for rebase -i with commits that do not pass pre-commit

Junio C Hamano (1):
  reflog-expire: Avoid creating new files in a directory inside readdir(3)
    loop

Yasushi SHOJI (1):
  gitweb: Convert generated contents to utf8 in commitdiff_plain
