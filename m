From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 21:09:16 -0700
Message-ID: <7vfxumyr2r.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
 <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803192228260.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcC6S-0000d2-Aj
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbYCTEJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYCTEJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:09:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYCTEJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:09:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 343062630;
	Thu, 20 Mar 2008 00:09:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 569B8262E; Thu, 20 Mar 2008 00:09:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803192228260.2947@xanadu.home> (Nicolas
 Pitre's message of "Wed, 19 Mar 2008 23:13:52 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77620>

Nicolas Pitre <nico@cam.org> writes:

> So you have 17.1 seconds for a single pack vs 18.4 seconds for 66 packs.
>
> Compare that to 24.9s without that patch.

Very interesting --- why should it affect a single pack case at all?

> And I still have some further optimizations to implement eventually 
> (http://marc.info/?l=git&m=118062793413099&w=2), but which would 
> probably make a significant difference only in the hundreds-of-packs 
> case anyway.
>
> So I really think that the default gc.autopacklimit could be raised.

Thanks, let's raise it to 50 then.

But I am still puzzled...
