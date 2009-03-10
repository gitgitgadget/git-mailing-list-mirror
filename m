From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Tue, 10 Mar 2009 18:57:55 -0500
Message-ID: <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <20090308144240.GA30794@coredump.intra.peff.net>
 <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
 <20090310181730.GD26351@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 01:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhBrX-0001Fv-IX
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 00:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZCJX6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 19:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZCJX6W
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 19:58:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbZCJX6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 19:58:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1367B575B;
	Tue, 10 Mar 2009 19:58:18 -0400 (EDT)
Received: from [192.168.1.241] (unknown [76.201.177.183]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7431D5759; Tue,
 10 Mar 2009 19:58:14 -0400 (EDT)
In-Reply-To: <20090310181730.GD26351@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 53A94DA8-0DCF-11DE-84BB-CBE7E3B37BAC-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112858>

On 2009 Mar 10, at 13:17, Jeff King wrote:
> Can somebody with an OS X box try:
>
>   $ /bin/sh
>   $ eval 'false
>
>     '
>   $ echo $?
>
> It should print '1'; if it prints '0', the shell is broken.

I wrote t3505 on a Mac OS X 10.4.11 system. On that system, /bin/sh  
is a copy of bash v2.05b. Your test code prints 1 here.

-- 
Chris
