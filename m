From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5 v4] diff: parse detached options like -S foo
Date: Mon, 02 Aug 2010 21:43:07 +0200
Message-ID: <vpqocdkdcms.fsf@bauges.imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v62ztnesc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0vY-0005Uq-TF
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0HBTn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:43:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51729 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab0HBTnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:43:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o72JWfj6025683
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 21:32:41 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Og0uh-0001yR-RA; Mon, 02 Aug 2010 21:43:07 +0200
In-Reply-To: <7v62ztnesc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 09\:46\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Aug 2010 21:32:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72JWfj6025683
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281382362.63954@Pzimk+40fSvCq+OO2QSxTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152443>

Junio C Hamano <gitster@pobox.com> writes:

> Just a style thing, but I think "arg + 2" is much easier to read in this
> particular case, as it won't risk tempting readers to go "Huh?  What does
> that 'c' mean"?

I'll take this "+ 2" in the next round.

> Do we have an option that can take a zero-length string as its value and
> do something meaningful?  I don't think of any offhand ("log -S'' -p" is
> not it---it may be meaningful but it is not useful), but this code would
> start giving "-p" instead of "" to the option in such a case.

I make it explicit in the commit message: only -S, -l and -O are
touched by my change among the one-letter options => no problem here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
