From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: cache file deltas
Date: Tue, 02 Oct 2007 21:10:04 -0700
Message-ID: <7vbqbgj0tf.fsf@gitster.siamese.dyndns.org>
References: <20070925192941.GA8564@coredump.intra.peff.net>
	<7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0710021832520.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcvZP-0005Gp-6B
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXJCEKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXJCEKM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:10:12 -0400
Received: from rune.pobox.com ([208.210.124.79]:35445 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbXJCEKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:10:11 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id CC4A61407FD;
	Wed,  3 Oct 2007 00:10:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3630B140104;
	Wed,  3 Oct 2007 00:10:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710021832520.3579@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 2 Oct 2007 18:36:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59778>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, that renaming apparently never happened, and it's still called 
> diff_free_filespec_data_large() now that it's in master.
>
> That said, I think this patch should make it into the maintenance branch 
> too, renamed or not, since it's such a huge performance issue.

Thanks.
