From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Thu, 30 Jun 2011 13:33:55 +0900
Message-ID: <buohb78aqfg.fsf@dhlpc061.dev.necel.com>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
 <20110628224516.GB4192@sigill.intra.peff.net>
 <7vtyb8s4kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 06:34:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc8xC-0003gQ-44
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 06:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1F3EeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 00:34:00 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:41899 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab1F3Ed6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 00:33:58 -0400
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LNL00E6X60L9O80@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 30 Jun 2011 13:33:57 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LNL00D0460LEMB0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 30 Jun 2011 13:33:57 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id 1100128070; Thu, 30 Jun 2011 13:33:57 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id 0FF5828088; Thu,
 30 Jun 2011 13:33:57 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac2.idc.renesas.com with ESMTP id PAH20708; Thu,
 30 Jun 2011 13:33:57 +0900
X-IronPort-AV: E=Sophos;i="4.65,447,1304262000";   d="scan'208";a="34500856"
Received: from unknown (HELO relay21.aps.necel.com) ([10.29.19.50])
 by relmlii1.idc.renesas.com with ESMTP; Thu, 30 Jun 2011 13:33:56 +0900
Received: from relay21.aps.necel.com ([10.29.19.50] [10.29.19.50])
 by relay21.aps.necel.com with ESMTP; Thu, 30 Jun 2011 13:33:56 +0900
Received: from dhlpc061 ([10.114.97.87] [10.114.97.87])
 by relay21.aps.necel.com with ESMTP; Thu, 30 Jun 2011 13:33:56 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 5F54352E1FB; Thu,
 30 Jun 2011 13:33:56 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7vtyb8s4kv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176471>

Junio C Hamano <gitster@pobox.com> writes:
> All valid arguments against the change, I think.  Thanks.

Yeah, I think better to leave it alone.

I sometimes pipe the output of such progress-meter-using programs
through a filter that both sends the output to the terminal (where the
\rs are clearly desired) and logs it to a file -- and the \rs are even
useful for the latter purpose, and the filter can use them to delete
all but the last copy of each line before logging.

-Miles

-- 
My books focus on timeless truths.  -- Donald Knuth
