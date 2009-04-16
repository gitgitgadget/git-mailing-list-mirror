From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Thu, 16 Apr 2009 18:44:16 +0200
Message-ID: <vpqiql4tuov.fsf@bauges.imag.fr>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vws9rdmgd.fsf@gitster.siamese.dyndns.org>
	<vpqfxgevy58.fsf@bauges.imag.fr> <vpqtz4rynhp.fsf@bauges.imag.fr>
	<7v7i1lqz24.fsf@gitster.siamese.dyndns.org>
	<20090416060027.GA2992@coredump.intra.peff.net>
	<20090416065223.GA927@coredump.intra.peff.net>
	<20090416071415.GC20071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuUm1-0005ik-40
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 18:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbZDPQrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 12:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756852AbZDPQrj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 12:47:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:38033 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811AbZDPQri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 12:47:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3GGiGds027890
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 18:44:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuUhE-0004up-Af; Thu, 16 Apr 2009 18:44:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuUhE-0007he-7v; Thu, 16 Apr 2009 18:44:16 +0200
In-Reply-To: <20090416071415.GC20071@coredump.intra.peff.net> (Jeff King's message of "Thu\, 16 Apr 2009 03\:14\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 18:44:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116709>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2009 at 02:52:23AM -0400, Jeff King wrote:
>
>> Anyway, I think this is a nice improvement on its own, and it should
>> make Matthieu's patch a little cleaner.
>
> Hmm, it looks like you just applied Matthieu's patch to next
> already.

2 things : my patch was lacking a Signed-off-by:, and your (Junio)
modification to add the documentation has a typo (quite instead of
quit). I'm resending the patch with a Signed-off-by, in case, and
another patch fixes the typo (and updates the help with 'g' and '/').

-- 
Matthieu
