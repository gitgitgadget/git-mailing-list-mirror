From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 19:44:22 +0100
Message-ID: <vpqbpsq9x15.fsf@bauges.imag.fr>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
	<7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com>
	<450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcOqH-0001kk-55
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbZBYStW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 13:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbZBYStW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:49:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:62130 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772AbZBYStV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 13:49:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1PIjCsS017359
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 19:45:12 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LcOk2-0001Y4-Eo; Wed, 25 Feb 2009 19:44:22 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LcOk2-0005Vz-CS; Wed, 25 Feb 2009 19:44:22 +0100
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com> (John Dlugosz's message of "Wed\, 25 Feb 2009 13\:02\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 25 Feb 2009 19:45:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111477>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> 	Oldstuff--A--B--C  remote
> 	       \
> 	        LC--X--Y  mine
>
> LC is "Local Changes", X and Y are changes I made, and A, B, C are
> changes from other developers.
>
> After a fetch, I have:
>
> 	Oldstuff--LC--X--Y--A'--B'--C'  mine

No, your changes get rebased:

 	Oldstuff--A--B--C--LC'--X'--Y'   mine

You should just be carrefull not to push in this state, since you'd
push LC too. But you can throw away LC later with "git rebase -i".

-- 
Matthieu
