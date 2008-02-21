From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 12:08:18 -0800
Message-ID: <7v1w76ul70.fsf@gitster.siamese.dyndns.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org>
 <7vodaauunn.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802210922100.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSHo9-0001KU-An
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbYBUUNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbYBUUNm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:13:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbYBUUNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:13:41 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2008 15:13:41 EST
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FF86233F;
	Thu, 21 Feb 2008 15:08:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 761BF233E; Thu, 21 Feb 2008 15:08:27 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802210922100.7833@woody.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 21 Feb 2008 09:31:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74649>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It includes your "continue" fix, since that was actually related to the 
> "remove_index_entry()" addition this needs. It also contains the hash next 
> pointer initialization.

In the meantime, 'master' will get that single-liner "continue"
fix, which may conflict but the resolution is trivial.

> But I'm still looking at this. In particular, I want to add some 
> assertions to make sure the index state matches the name hash state, but 
> your lazy patch makes that less convenient.

Please feel free to revert it.
