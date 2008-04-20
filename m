From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 21:14:31 -0700
Message-ID: <7viqydduxk.fsf@gitster.siamese.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 06:15:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnQxm-0007bK-6y
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 06:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbYDTEOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 00:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbYDTEOk
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 00:14:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYDTEOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 00:14:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D54A73A4;
	Sun, 20 Apr 2008 00:14:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 199D673A3; Sun, 20 Apr 2008 00:14:33 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sat, 19 Apr 2008 15:39:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79949>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> At least two of them are due to ce_smudge_racily_clean_entry(), which in
> turn is because we trigger the is_racy_timestamp() test. Hmm.

There is one change that has been held back in 'next' for quite some time.
Perhaps it would help?
