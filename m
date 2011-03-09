From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] log: fix --max-count when used together with -S or -G
Date: Wed, 09 Mar 2011 22:49:12 +0100
Message-ID: <vpqk4g8hsmf.fsf@bauges.imag.fr>
References: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
	<1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110309213824.GA4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxRGv-00008S-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab1CIVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:50:16 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35218 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1CIVuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:50:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p29LnALJ001699
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Mar 2011 22:49:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PxRFo-0005lM-P6; Wed, 09 Mar 2011 22:49:12 +0100
In-Reply-To: <20110309213824.GA4400@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 9 Mar 2011 16:38:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Mar 2011 22:49:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p29LnALJ001699
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300312151.91246@0capcUP8+c7z4112W0kHMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168768>

Jeff King <peff@peff.net> writes:

> So it's definitely a much deeper topic than your small patch. Which
> maybe means we should apply your patch now as a band-aid and hope for a
> better solution in the long term. I dunno.

I'm too lazy/don't have time to do an in-depth fix. It doesn't seem
crazy to apply the patch, since it fixes the common case, and adds tests
for it, but I don't care personnaly about the feature/bug, so I won't
fight if it's rejected. I can resend with a more explicit comment in the
code saying it would deserve a better fix if someone cares.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
