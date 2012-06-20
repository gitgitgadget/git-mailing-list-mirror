From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: start warning upcoming default change for push.default
Date: Wed, 20 Jun 2012 21:45:33 +0200
Message-ID: <vpqwr317oo2.fsf@bauges.imag.fr>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
	<1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehp9x3yz.fsf@alter.siamese.dyndns.org>
	<vpqpq8t96zw.fsf@bauges.imag.fr>
	<7va9zxvkyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQqX-0007gT-0J
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab2FTTpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:45:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36326 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab2FTTpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:45:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5KJjFBq000895
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 21:45:15 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ShQqM-0006lb-8m; Wed, 20 Jun 2012 21:45:34 +0200
In-Reply-To: <7va9zxvkyp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 12:31:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 20 Jun 2012 21:45:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5KJjFBq000895
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340826317.08965@ZZUo1+c/ubdkayXfn/GzQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200346>

Junio C Hamano <gitster@pobox.com> writes:

>> 3) Set push.default to 'current', in which case they have the same
>>    behavior as 'simple', except for the safety feature of 'simple'
>>    (refuse to push when the name doesn't match the upstream). They can't
>>    expect anything better anyway since they are sometimes using a
>>    machine which doesn't support 'simple' anyway.
>
> And they will be frozen to 'current' even after their sysadmins
> update the version of git that support 'simple'.  

And so what? They will miss the safety feature of 'simple', but that's
not really a big deal.

'simple' was not really designed to be _better_ than current or
upstream, but to be more adapted as a default value, because 1) it's
safer, so nice for beginners and 2) follows the least surprise
principle, as it does nothing in cases where there would be an
ambiguity. But once you're not really a beginner, the added value of
'simple' is really small compared to 'current' or 'upstream'.

> Telling somebody who would blindly follow what was suggested to use
> 'current' is what bothers me.

But what alternative do we have?

You suggest that I remove the mention of 'current', but then what should
users do? Removing it sounds like replacing it with "if you sometimes
use older versions of Git, you're doomed, sorry" to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
