From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 14:26:12 +0200
Message-ID: <vpqir7y15sr.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<vpq4pji3zwm.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021315510.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZmn-0008Ku-Rz
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbXHBM2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbXHBM2K
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:28:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:61291 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbXHBM2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:28:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l72CQC00017117
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 14:26:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGZkq-0001vD-8s; Thu, 02 Aug 2007 14:26:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGZkq-0002qN-6b; Thu, 02 Aug 2007 14:26:12 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0708021315510.14781@racer.site> (Johannes Schindelin's message of "Thu\, 2 Aug 2007 13\:19\:55 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 14:26:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54547>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I fully agree that git should be optimized for the common case. But
>> even for the common case, I also find the feature strange. You didn't
>> answer that part of my message, but I still fail to see a rationale
>> for making "git-diff; git-status" different from "git-status; git-diff".
>
> For performance reasons, git always compares the files' stat information 
> with that stored in the index.

I know that, but how does it answer the part of my message that you
are citing?

> So when you do "git diff" and it tells you all those diff lines, while no 
> file was really changed, it tells you "get your act together!  You just 
> _willfully_ slowed down git's performance".

The question remains: why should someone running git-diff get this,
and someone running git-status not get this?

(I mean, from the user point of view, not the implementation point of
view)

-- 
Matthieu
