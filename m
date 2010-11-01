From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 20/23] git notes merge: Add testcases for merging notes
 trees at different fanouts
Date: Mon, 01 Nov 2010 01:09:38 +0100
Message-ID: <201011010109.38459.johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <1287965333-5099-21-git-send-email-johan@herland.net>
 <7vwrp16o21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 01:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PChyZ-0002Bb-2l
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 01:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0KAAKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 20:10:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48474 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab0KAAKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 20:10:03 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB600EH8J459H60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 01 Nov 2010 01:09:41 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 442301798F41_CCE0545B	for <git@vger.kernel.org>; Mon,
 01 Nov 2010 00:09:41 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2E6391796FD4_CCE0545F	for <git@vger.kernel.org>; Mon,
 01 Nov 2010 00:09:41 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB6006IAJ45BQ00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 01 Nov 2010 01:09:41 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <7vwrp16o21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160456>

On Friday 29 October 2010, Junio C Hamano wrote:
> Subject: [PATCH] portability fix for [20/23]
> 
>     test "$(line generator | wc -l)" = $expected_number_of_lines (bad)
> 
> is not portable, as "wc -l" can prefix the number with whitespaces.
> 
> Either write the $(... | wc -l) without enclosing in a dq pair, i.e.
> 
>     test $(line generator | wc -l) = $expected_number_of_lines (good)
> 
> or compare them numerically with
> 
>     test "$(... | wc -l)" -eq $num (ok)
> 
> The former is preferred for readability.

Ack. I'll fold this fix into the next iteration.

Thanks!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
