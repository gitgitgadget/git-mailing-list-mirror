From: Junio C Hamano <gitster@pobox.com>
Subject: Current queue status before I go to bed.
Date: Mon, 09 Feb 2009 01:44:33 -0800
Message-ID: <7vhc34uepq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSia-00064v-US
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbZBIJok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbZBIJok
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:44:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbZBIJoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:44:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 107C42AC10;
	Mon,  9 Feb 2009 04:44:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 727522A64E; Mon, 
 9 Feb 2009 04:44:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4393926E-F68E-11DD-948F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109061>

I hate doing this, but I am running out of energy and I'd make a quick
report on the recent patches queued on master but won't be pushed out
tonight, so that people do not have to waste time on pinging me wondering
why their obviously good patches hasn't appeared in any of my public
repositories..

These are queued for 'master' and by the time I wake up hopefully have
passed all the tests and can be pushed out ;-)

  git-web--browse: Fix check for /bin/start

  gitweb: add $prevent_xss option to prevent XSS by repository content
  (this one is on maint as well)

  rev-list: fix showing distance when using --bisect-all

  completion: Get rid of tabbed indentation in comments. Replace with spaces.

  completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variable errors.

  doc/bundle: Use the more conventional suffix '.bundle'

  Add two extra tests for git rebase
  (this is only t/ in Dscho's "checkout -q" thinko-patch)

  Documentation: clarify commits affected by gitk --merge

  add -p: get rid of Git.pm warnings about unitialized values

On the next front, nothing but a merge from 'master' has happened, except
that "rebase: explain why when the HEAD could not be detached" was reverted.

I've parked the "delete current branch with git-push" topic in 'pu' for
now.
