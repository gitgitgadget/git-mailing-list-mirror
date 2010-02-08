From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: imap.preformattedHTML and imap.sslverify
Date: Mon, 08 Feb 2010 16:31:35 -0600
Message-ID: <4B7090C7.4040700@codeweavers.com>
References: <7v7hqqxj10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robert Shearman <robertshearman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NecTy-0000D2-9V
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab0BHWxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:53:25 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53280 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0BHWxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:53:24 -0500
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2010 17:53:24 EST
Received: from jwhite.mn.codeweavers.com ([10.69.137.101] ident=jwhite)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1Nec7x-0004RX-6w; Mon, 08 Feb 2010 16:30:45 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
In-Reply-To: <7v7hqqxj10.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139331>

Hi Junio,

>            [imap]
>                 sslverify = True

*blush* - I never looked at the parsing rules; = True, or = 1 would have seemed fine to me.
I blame Rob.  He led me astray.  That's my story, and I'm sticking to it <grin>.

>  - The config parser downcases the key before calling the parse callback
>    function, so !strcmp("preformattedHTML", key) will never trigger.

Um...the patch I submitted used the (admittedly badly named) key 'html':
  http://marc.info/?l=git&m=123445427011604&w=2

I'm guessing that you changed it to preformattedHTML prior to committing;
that was something we discussed:
  http://marc.info/?l=git&m=123453315529656&w=2

So I think I can claim 'not guilty!' on that one (but only that one :-/).

> Could peole _test_ this patch and report, as I don't use this program at
> all.

I did confirm that your patch does work.

However, I assumed that my original patch was rejected.  
I never realized that it had been applied.

That clearly means that no one has ever used this option.

I'll remain unhurt if you revert it (c64d84f1452ec56fd1586493a0b0707bf7442c42), but
let me know if you choose to apply your patch instead; I'll make a point
to use it.

Cheers,

Jeremy
