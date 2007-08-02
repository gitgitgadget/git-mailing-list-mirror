From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 14:08:17 +0200
Message-ID: <vpqzm1a2l72.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZVf-0002KC-1w
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbXHBMK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbXHBMK1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:10:27 -0400
Received: from imag.imag.fr ([129.88.30.1]:56026 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbXHBMK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:10:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l72C8In7013735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 14:08:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGZTV-0001Li-TL; Thu, 02 Aug 2007 14:08:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGZTV-0002M4-RA; Thu, 02 Aug 2007 14:08:17 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 03\:01\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 14:08:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54543>

Junio C Hamano <gitster@pobox.com> writes:

> Quite honestly, a script that indiscriminately touches everybody
> but only modifies a few is simply broken.  Think about "make".
> "git diff" reporting many cache-dirty files is simply reminding
> you the brokenness of such a script.

I wouldn't call this "broken", but clearly suboptimal, yes. But for an
occasionnal one-liner (perl -pi -e ... or so), I lose less time
recompiling extra-files than I would writting a cleaner script. "make"
has no way to detect the absence of modification, while git has.

-- 
Matthieu
