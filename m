From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Sat, 20 Dec 2008 06:45:32 +0900
Message-ID: <20081220064532.6117@nanako3.lavabit.com>
References: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
 <20081219124452.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 22:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnCT-000656-LI
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 22:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYLSVqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 16:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYLSVqm
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 16:46:42 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50755 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYLSVqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 16:46:42 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 56386C88B9;
	Fri, 19 Dec 2008 15:46:41 -0600 (CST)
Received: from 1713.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 9B6KFLCFIWBR; Fri, 19 Dec 2008 15:46:41 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Ph4CZQfi7EuCvRaDLHUsrGpwIkyIEf7hQxnaE+NymtRseJlpbNjJD20LinpgJ94m5bhk/9D+mFxSTtkTGWXdZCSmAbip+QL9pd4piDgbpUC3oUK/ZKgQk7YL0Z+BFT4BeRxdqVLIEeqtu78sawLpFYtDj6/rjgUb8ymEEaXphzI=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103585>

Quoting Junio C Hamano <gitster@pobox.com>:

> I hope this clears up confusion and fear.

You are correct that I misunderstood what Alan meant by corrected branch.

I think your explanation will help people if we make it part of the documentation.  Especially because two different cases need two different recovery methods, and people need to learn which is which.

Thank you for your detailed response.
-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
