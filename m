From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 14:05:13 +0200
Message-ID: <vpq4pji3zwm.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZTm-0001cL-1J
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbXHBMIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbXHBMIa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:08:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:55547 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbXHBMI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:08:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l72C5EdA013142
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 14:05:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGZQX-0001K7-UI; Thu, 02 Aug 2007 14:05:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGZQX-0002Lu-Rj; Thu, 02 Aug 2007 14:05:13 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 02\:54\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 14:05:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54542>

Junio C Hamano <gitster@pobox.com> writes:

> The default should be tuned for users who perform manual editing
> with status checks.  And power users like yourself who run "bulk
> touch indiscriminately but modify only some" scripts should
> learn to run git-status (or "update-index --refresh") after such
> operation.  Swapping the defaults to optimize for the abnormal
> case is madness.

I fully agree that git should be optimized for the common case. But
even for the common case, I also find the feature strange. You didn't
answer that part of my message, but I still fail to see a rationale
for making "git-diff; git-status" different from "git-status; git-diff".

IOW, why should people running git-status before git-diff not get a
reminder if you think people running git-diff without or before
git-status should get it?

-- 
Matthieu
