From: Junio C Hamano <gitster@pobox.com>
Subject: 1.6.0-rc0 tagged
Date: Sun, 20 Jul 2008 23:20:30 -0700
Message-ID: <7vd4l7wyfl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 08:21:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKom7-0006GU-MU
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 08:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbYGUGUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYGUGUf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 02:20:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYGUGUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 02:20:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2713335823;
	Mon, 21 Jul 2008 02:20:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6CC6B35822; Mon, 21 Jul 2008 02:20:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20603D06-56ED-11DD-8E8E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89305>

I've tagged and pushed out v1.6.0-rc0 tonight.  Those who are not
following the git development regularly should take note and please have a
serious look at it, as the upcoming v1.6.0 release will bring in major
usability and modernization changes that we have been announcing/warning
in Release Notes for the past few releases.

 * Most subprograms such as git-cat-file will be installed outside your
   $PATH by default.  Your "/bin/ls /usr/bin" will be much smaller as all
   of you have been asking, but you may have to update your scripts as
   outlined in the release notes for v1.5.4.

 * The new release in the default configuration will produce packfile and
   pack idx files that won't be accessible by git older than v1.4.4.5.  By
   now, those who use git for anything serious should be using v1.5.3 or
   later anyway, though.

 * The ".dotest" temporary area "git am" and "git rebase" use will be
   moved to $GIT_DIR/rebase.  We might change it to $GIT_DIR/rebase-apply
   which would be more logical name before the final, though.

People who have regularly followed 'master' (and 'next') should not take
this tag too seriously; there is nothing surprising about it since the
last issue of "What's cooking/What's in".
