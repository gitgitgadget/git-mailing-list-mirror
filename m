From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Mon, 11 Mar 2013 09:00:27 +0100
Message-ID: <vpqk3pefjs4.fsf@grenoble-inp.fr>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
	<1362786889-28688-2-git-send-email-gitster@pobox.com>
	<vpqmwubgsqy.fsf@grenoble-inp.fr>
	<7vboaqbeou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 09:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UExfV-0008DT-6G
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 09:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3CKIAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 04:00:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38863 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab3CKIAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 04:00:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2B80RnF005419
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 09:00:27 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UExem-0004y1-Az; Mon, 11 Mar 2013 09:00:28 +0100
In-Reply-To: <7vboaqbeou.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Mar 2013 00:04:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 09:00:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2B80RnF005419
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363593628.44797@yYGgnTMPR+Azf43CxMT+/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217858>

Junio C Hamano <gitster@pobox.com> writes:

> So let's squash these two steps into one and keep that in 'next'
> until 2.0 ships.

OK, then we may update the comment describing the plan (for people
digging in the code to find out what the plan is). Small patch serie
follows with this (will probably give conflict with your patch, feel
free to drop if resolving them is too painful given the benefit) and
another minor improvement.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
