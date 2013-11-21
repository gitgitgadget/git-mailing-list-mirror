From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 21:58:58 +0100
Message-ID: <874n754gkt.fsf@thomasrast.ch>
References: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
	<20131121115423.GC7171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 21:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjbLJ-0001TQ-G1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab3KUU7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:59:13 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:48193 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab3KUU7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:59:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3B0324D6505;
	Thu, 21 Nov 2013 21:59:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cCiwSCkbSS7z; Thu, 21 Nov 2013 21:59:01 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 5D4AF4D6414;
	Thu, 21 Nov 2013 21:59:00 +0100 (CET)
In-Reply-To: <20131121115423.GC7171@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 21 Nov 2013 06:54:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238153>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 21, 2013 at 12:30:56PM +0100, Thomas Rast wrote:
>
>> +Later, you can whether your changes have been applied by saying (still
>> +on `topic`):
>
> s/can/& see/ ?
>
>> +Note that this uses , and assumes that
>> +`core.autosetupmerge` is enabled (the default).
>
> I couldn't quite parse this. Is there a word missing before the comma,
> or is it "uses and assumes that..."?

I will just let this stand as evidence that I had a bad day.  Two
sentences ruined by botched editing in all of five paragraphs.  Sheesh.

Thanks for reading carefully.

> Given that it is the default, I wonder if it is worth mentioning at all.
> Even I, who knows what autosetupmerge does, took a minute to figure out
> why it is relevant here. I suspect it may just confuse most readers.

Ok, then let's remove it.

-- 
Thomas Rast
tr@thomasrast.ch
