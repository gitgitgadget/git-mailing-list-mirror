From: Junio C Hamano <gitster@pobox.com>
Subject: What's _not_ cooking in git.git yet
Date: Sun, 20 Jul 2008 23:33:33 -0700
Message-ID: <7vy73vvj9e.fsf@gitster.siamese.dyndns.org>
References: <7vtzejx0q1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 08:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKoyi-0000LI-46
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 08:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYGUGdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 02:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbYGUGdj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 02:33:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYGUGdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 02:33:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 443533123C;
	Mon, 21 Jul 2008 02:33:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A06E53123B; Mon, 21 Jul 2008 02:33:35 -0400 (EDT)
In-Reply-To: <7vtzejx0q1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 22:31:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F327F200-56EE-11DD-B8BF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89306>

There are a few topics that are still not ready but should be in the -rc1.

 * I want Pasky's "saner git-mv" to be in if possible, although I am
   moderately pessimistic about the submodule work that comes on top of
   it.

 * "optimize ssh connection for throughput not for latency" may be a
   worthy goal, but I think the point Jeff raised about the shared
   connection is a valid concern.  It might be better not to do anything
   funky at the software level, but just add an entry in tips&tricks
   section of gitwiki.

Other than that, we should be focused more on fixes on regressions (if
any), fixes in new features added in v1.6.0 cycle, than adding not-yet-in
features nor code clean-ups.

I'll switch my production branch to 'master' tonight.  I expect active
contributors to do the same and keep it that way until 1.6.0 final.  Right
now, with 'merge -Xtheirs' removed, the difference between 'master' and
'next' is extremely thin.

Thanks.
