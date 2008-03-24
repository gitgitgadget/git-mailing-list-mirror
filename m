From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Sun, 23 Mar 2008 17:24:02 -0700
Message-ID: <7v4pax3r6l.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site>
 <alpine.LSU.1.00.0803232144070.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdaUg-0007eS-Gs
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775AbYCXAYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757954AbYCXAYN
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:24:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775AbYCXAYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 20:24:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A20B20AE;
	Sun, 23 Mar 2008 20:24:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7D7D320AD; Sun, 23 Mar 2008 20:24:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77982>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When initializing a non-bare repositories, you most likely want to avoid
> pushing into the current branch (because a push does not touch the
> working tree at all).

As I described in my other message, I suspect that treating the current
branch specially like this is a wrong approach.  The configuration might
be a good idea, but shouldn't it prevent any local branch from getting
updated?  Push into non-bare repository is simply a fetch run in reverse
direction.
