From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 18:58:55 +0100
Message-ID: <87vbzkiahs.fsf@linux-k42r.v.cablecom.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
	<87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
	<20131122172626.GA4881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 18:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjv0f-0004Z1-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab3KVR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:59:13 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:50143 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756Ab3KVR7M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:59:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id DBDD14D6505;
	Fri, 22 Nov 2013 18:59:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yAJq4Twjfkvj; Fri, 22 Nov 2013 18:58:58 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [89.204.135.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 80EAD4D6414;
	Fri, 22 Nov 2013 18:58:57 +0100 (CET)
In-Reply-To: <20131122172626.GA4881@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2013 12:26:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238203>

Jeff King <peff@peff.net> writes:

>> Hmm, maybe I missed something, but AFAICS you (or Vicent) never acted on
>> or responded to my June reviews in this thread:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/228918
[...]
>> Granted, the way I verified this was checking whether you renamed
>> rlw_xor_run_bit() to something more fitting, so perhaps you just forgot
>> that one thing but did all the rest.
>
> I didn't touch that. Vicent, did you have a comment on the name (it
> really does look like it is a negation, and the only caller is
> ewah_not).

Hmm, so it really was that one unlucky thing :-)

I don't have much to say on the area, but if you think it helps you I
can set aside some time RSN to review the second half of the series,
too.  Back in June I only looked at the first half.

-- 
Thomas Rast
tr@thomasrast.ch
