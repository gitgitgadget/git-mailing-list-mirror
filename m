From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, next version] git bisect: introduce 'fixed' and 'unfixed'
Date: Fri, 27 Jun 2008 16:03:36 -0700
Message-ID: <7vprq2o4zb.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
 <20080624163810.GA4654@sigill.intra.peff.net>
 <alpine.DEB.1.00.0806241750030.9925@racer>
 <alpine.DEB.1.00.0806241808400.9925@racer>
 <20080624174157.GB9500@sigill.intra.peff.net>
 <7vej6mbh3w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806271446180.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCMzs-0007HT-T6
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764862AbYF0XDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765035AbYF0XDr
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:03:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765389AbYF0XDp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:03:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 658EFE06D;
	Fri, 27 Jun 2008 19:03:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B1015E06B; Fri, 27 Jun 2008 19:03:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806271446180.9925@racer> (Johannes
 Schindelin's message of "Fri, 27 Jun 2008 14:48:31 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AA746A2-449D-11DD-B311-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86672>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When you look for a fix instead of a regression, it can be quite hard
> to twist your brain into choosing the correct bisect command between
> 'git bisect bad' and 'git bisect good'.

Hmm, I do not currently see any differene between master and next version
of bisect.  In what way is this 'next' version?

Aside from the 'visualize' issue this does not attempt to address, I
wonder if it may be a good idea to detect and warn mixed usage as well
(e.g. "You earlier said 'bad' but now you are saying 'fixed' -- are you
sure?"), and if so if it can be implemented easily.
