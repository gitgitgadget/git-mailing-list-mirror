From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Tue, 21 Jun 2011 00:03:47 +0200
Message-ID: <20110620220347.GE32765@one.firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org> <1308445625-30667-2-git-send-email-andi@firstfloor.org> <7vsjr4b3tf.fsf@alter.siamese.dyndns.org> <20110620213001.GB32765@one.firstfloor.org> <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmZV-0006bC-7A
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab1FTWDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:03:48 -0400
Received: from one.firstfloor.org ([213.235.205.2]:51762 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1FTWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:03:48 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 4FF9B1A980FE; Tue, 21 Jun 2011 00:03:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176100>

> Sorry, I do not recall suggesting to add these dummy returns. The NO_NORETURN
> workaround (your [1/3]) is what I remember.

It was just a logical followup to quelch the warning storm NO_NORETURN 
caused.

> 
> >> these will introduce noise for build without NO_NORETURN (either when
> >> profile feedback is not used, or when profile feedback build is in use and
> >> it no longer requires the NO_NORETURN workaround).
> >
> > I fixed the noise in a followon patch. 
> 
> I suspect that we are talking about different warnings.
> 
> The extra unreachable returns this patch adds will introduce more
> "unreachable code" warnings, which was what my message you are responding
> to is about.

Hmm I didn't see any additional warnings from the patch, neither
in profile feedback nor in a normal build with gcc 4.5. Did I miss
something?

-Andi
