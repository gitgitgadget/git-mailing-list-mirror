From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Sun, 27 Apr 2008 10:31:49 -0700
Message-ID: <7vej8rgq62.fsf@gitster.siamese.dyndns.org>
References: <20080427151610.GB57955@Hermes.local>
 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAkN-000546-6d
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbYD0RcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbYD0RcE
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbYD0RcB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D06D3339B;
	Sun, 27 Apr 2008 13:32:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4FE72339A; Sun, 27 Apr 2008 13:31:57 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 27 Apr 2008 16:22:29 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80458>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...  It did not 
> help that I hated the fact that that series changed the original design 
> without even understanding it.

Care to elaborate on this point further?  I do not get it.

Do you mean to say "I hate it because it does things differently from how
I did it originally", or "Because it does things differently from how the
original did, it breaks this and that cases"?

If the latter, "this and that" part is especially useful.  A solution to
fix that may end up to be closer to the original implementation.
