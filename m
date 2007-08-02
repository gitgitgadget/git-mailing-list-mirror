From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 16:49:34 +0200
Message-ID: <vpq7ioeyosh.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<vpq4pji3zwm.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021315510.14781@racer.site>
	<vpqir7y15sr.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021537490.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGc01-000641-D0
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbXHBOt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbXHBOt5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:49:57 -0400
Received: from imag.imag.fr ([129.88.30.1]:37221 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbXHBOt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:49:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l72EnYeL018484
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 16:49:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGbza-0005gw-Jr; Thu, 02 Aug 2007 16:49:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGbza-0003Qn-HR; Thu, 02 Aug 2007 16:49:34 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0708021537490.14781@racer.site> (Johannes Schindelin's message of "Thu\, 2 Aug 2007 15\:39\:20 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 16:49:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54556>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The question remains: why should someone running git-diff get this,
>> and someone running git-status not get this?
>
> Because git-status is an index-updating operation.  That's why.

That sounds like "it is this way because it is not the other way
around".

So, yes, git-status updates the index because it's an index-updating
operation, while git-diff does not update the index because it's a
non-index-updating operation.

Then, I'll rephrase my sentence as "*why* is git-status an
index-updating operation while git-diff is not". But you'll probably
find another way to avoid answering.

-- 
Matthieu
