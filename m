From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 21:16:34 +0100
Message-ID: <87bo1ci44d.fsf@linux-k42r.v.cablecom.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
	<87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
	<20131122172626.GA4881@sigill.intra.peff.net>
	<CAFFjANQni7mvFBuAqJnPpTJ_68+rJKU6KmdRAWbyK_jbi0S=xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 21:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjxA6-0003GW-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 21:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab3KVURG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 15:17:06 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:50446 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756081Ab3KVUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 15:16:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 95A754D6580;
	Fri, 22 Nov 2013 21:16:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RwFk3n1DBhny; Fri, 22 Nov 2013 21:16:39 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [89.204.155.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 51DB54D6414;
	Fri, 22 Nov 2013 21:16:38 +0100 (CET)
In-Reply-To: <CAFFjANQni7mvFBuAqJnPpTJ_68+rJKU6KmdRAWbyK_jbi0S=xA@mail.gmail.com>
	(Vicent Marti's message of "Fri, 22 Nov 2013 20:40:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238212>

Vicent Marti <vicent@github.com> writes:

> On Fri, Nov 22, 2013 at 6:26 PM, Jeff King <peff@peff.net> wrote:
>> I didn't touch that. Vicent, did you have a comment on the name (it
>> really does look like it is a negation, and the only caller is
>> ewah_not).
>
> Yes, the name was ported straight from the original library and kept
> as-is to make the translation more straightforward. These sources are
> --again-- a translation, so I tried to remain as close to the original
> Java implementation as possible.
>
> I agree the name is not ideal, but it does make quite a bit of sense.
> It effectively inverts the word based on the run bit, which is the
> equivalent of xoring it with the bit if it's one.

It's a funny xor that doesn't take a second argument ;-)

Anyway, let's not argue forever about the choice of this name.  It's
just the first thing that came to my mind from the original review, so I
used it as an indicator to see if you had done something about it.  It
seems I picked an indicator that is not significant for the overall
state.

-- 
Thomas Rast
tr@thomasrast.ch
