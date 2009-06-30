From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Tue, 30 Jun 2009 09:20:28 -0700
Message-ID: <7vws6t8zhv.fsf@alter.siamese.dyndns.org>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLgEQ-0001Kf-FC
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:30:54 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLg4W-0001rT-QC
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:20:40 +0200
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLg4W-0001rQ-PC
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:20:40 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLg4V-0008Ms-3b
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZF3QU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 12:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZF3QU0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 12:20:26 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63639 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZF3QU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 12:20:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630162029.MPEZ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jun 2009 12:20:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id AGLU1c00J4aMwMQ04GLVnD; Tue, 30 Jun 2009 12:20:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hoH3GwZHzGIA:10 a=P5A2dcuk-WcQU_8zwY8A:9
 a=uY0P3X4fBg-yHx140azVcZZHVE0A:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 77E363600E0DC622716D15ED27D43618CFE3CF17
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 45 total 2548134 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122521>

Michal Marek <mmarek@suse.cz> writes:

> git request-pull called inside a terminal prints part of the output to
> the terminal and other parts are piped through the pager. Fix this.

Hmph, I have always thought this was meant to be a feature.

That is, you run it to yourself, instead of piping it to a file or "| mail
torvalds", in order to sanity check before you actually do the latter.
When the request is larger than a screenful, you would want a pager while
reviewing.

Admittedly, I do not regularly use request-pull, so I wouldn't know if use
of the pager is inconvenient to people who have to use this feature
regularly. Your patch could be addressing a real usability issue.

But I have this nagging suspicion that you may be lacking F (or FX) from
your LESS environment variable?
