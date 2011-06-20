From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Tue, 21 Jun 2011 00:00:27 +0200
Message-ID: <20110620220027.GD32765@one.firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org> <1308445625-30667-2-git-send-email-andi@firstfloor.org> <7vsjr4b3tf.fsf@alter.siamese.dyndns.org> <7vk4cgb24p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmWJ-0004kF-Or
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1FTWAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:00:31 -0400
Received: from one.firstfloor.org ([213.235.205.2]:51750 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1FTWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:00:30 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 9B65A1A980FE; Tue, 21 Jun 2011 00:00:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk4cgb24p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176099>

> I would need to clarify with s/introduce noise/introduce more noise/; the
> existing codebase is not noise-free.
> 
> But I do not see much point in making things worse, only to squelch
> "reaches end of non void function" warnings that will be given under the
> NO_NORETURN workaround configuration.

Can you please give specific guidance what I should do to make
the patchkit acceptable?

Current options are:

1) use original minimal patchkit (which had two warnings or so)
1b) use original minimal patchkit with warnings fixed
2) use global patch proposal for NO_NORETURN (= lots of warnings)
2b) use patch proposal + additional patch to fix warnings (posted here)
3) something I missed.

Which one do you prefer? If 3 I would prefer specific guidance.

Thanks,

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
