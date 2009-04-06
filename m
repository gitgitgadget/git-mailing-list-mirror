From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git diff bug?
Date: Mon, 06 Apr 2009 21:32:43 +0200
Message-ID: <vpqzlet1stg.fsf@bauges.imag.fr>
References: <m2ocvdkyul.fsf@boostpro.com>
	<20090404014527.GA13350@coredump.intra.peff.net>
	<1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
	<20090406155303.GA3275@sigill.intra.peff.net>
	<vpqeiw53cpy.fsf@bauges.imag.fr>
	<7vskkl64yu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Abrahams <dave@boostpro.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqud4-00066L-Vc
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZDFTfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZDFTfg
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:35:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:60701 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915AbZDFTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:35:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n36JWjFC003071
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Apr 2009 21:32:45 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LquYl-0000sw-Lq; Mon, 06 Apr 2009 21:32:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LquYl-00089W-JL; Mon, 06 Apr 2009 21:32:43 +0200
In-Reply-To: <7vskkl64yu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 06 Apr 2009 10\:56\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Apr 2009 21:32:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115874>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> But the latter two lines are about preference: "here is how _I_ would
>>> like to generate diffs for el files".
>>
>> ... and they are commands to be executed. If they were in the
>> repository, and propagated with clone, then doing
>>
>> git clone git://some.git/repo
>> cd repo
>> git diff
>>
>> would execute arbitrary commands, which wouldn't be acceptable for
>> security reasons.
>
> Other configuration variables have such security implications, but diff
> hunk header bit doesn't.  You are a bit overly cautious in this particular
> case.

Oops, right, I was thinking of other parameters in the same section of
the config file. Thanks for correcting.

-- 
Matthieu
