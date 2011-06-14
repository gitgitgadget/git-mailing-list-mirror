From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Wed, 15 Jun 2011 08:40:22 +0900
Message-ID: <87vcw8f0d5.fsf@catnip.gol.com>
References: <20110614181732.GA31635@sigill.intra.peff.net>
	<20110614181821.GA32685@sigill.intra.peff.net>
	<7vaadkkvew.fsf@alter.siamese.dyndns.org>
	<20110614204950.GB12776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?en=C3=A9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>, git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWdMY-0007Y3-Hc
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 01:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab1FNXtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 19:49:33 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:54584 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab1FNXtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 19:49:33 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2011 19:49:33 EDT
Received: from 218.231.154.3.eo.eaccess.ne.jp ([218.231.154.3] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1QWdDc-0003Fh-0O; Wed, 15 Jun 2011 08:40:24 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 288D2DF8D; Wed, 15 Jun 2011 08:40:23 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20110614204950.GB12776@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jun 2011 16:49:50 -0400")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175804>

Jeff King <peff@github.com> writes:
>> I didn't know it was that easy (primarily because I didn't know zlib had a
>> ready-to-eat interface to do this).
>
> Yes, though I think it may be worth doing the more flexible,
> external-filters approach. See elsewhere in the thread.

Given the relatively trivial code, isn't it worth doing both...?

One method for flexibility/multi-threaded-speed, the other for
portability/robustness (doesn't depend on configuration / setup
details)...

-Miles

-- 
"Though they may have different meanings, the cries of 'Yeeeee-haw!' and
 'Allahu akbar!' are, in spirit, not actually all that different."
