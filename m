From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Troubles when directory is replaced by symlink
Date: Fri, 26 Jun 2009 00:51:35 +0200
Organization: private
Message-ID: <86bpocsz9k.fsf@broadpark.no>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
 <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
 <20090611114846.GC4409@coredump.intra.peff.net> <861vpmkhob.fsf@broadpark.no>
 <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Gladysh <agladysh@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxq3-0005pN-3s
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbZFYWy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZFYWy2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:54:28 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:35130 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZFYWy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:54:27 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KLT00BD5GW9R450@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 26 Jun 2009 00:52:57 +0200 (CEST)
Received: from localhost ([84.48.79.229]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KLT007W7GW81AA0@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 26 Jun 2009 00:52:57 +0200 (CEST)
In-reply-to: <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122254>

James Pickens <jepicken@gmail.com> writes:

> On Sun, Jun 14, 2009, Kjetil Barvik<barvik@broadpark.no> wrote:
>> From: Kjetil Barvik <barvik@broadpark.no>
>> Date: Sun, 14 Jun 2009 15:08:28 +0200
>> Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter
>
> My project ran into this bug today, and I can confirm that this patch
> fixes it.  I think it's an important bug; it hasn't been mentioned yet,
> but this can result in lost work if the user had modified, but not added,
> one of the files that Git wrongly deleted.
>
> So, what's the status of this patch?

  Sorry, have not have much time, and did not get any response on the
  patch, and I almost forgot about it for a while.

  But, since you say that the patch is ok, I shall try make a more
  "final" patch by 14:00 UTC Friday 26.

  Thanks for reminding me!

  -- kjetil
