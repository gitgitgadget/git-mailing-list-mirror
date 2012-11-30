From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for quoted paths
Date: Fri, 30 Nov 2012 10:39:18 +0100
Message-ID: <vpqvccnctvd.fsf@grenoble-inp.fr>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
	<1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
	<20121129181141.GA17309@sigill.intra.peff.net>
	<7vvccop6dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 10:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeN4c-0000xl-WF
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2K3Jji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 04:39:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54116 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab2K3Jjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 04:39:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qAU9Uu5H028941
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Nov 2012 10:30:56 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TeN42-0003WO-B4; Fri, 30 Nov 2012 10:39:18 +0100
In-Reply-To: <7vvccop6dv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 29 Nov 2012 11:15:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 30 Nov 2012 10:30:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAU9Uu5H028941
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354872659.25744@5yPCcuPqsMUx5B8fJQskGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That "shell-style" contradicts with what fast-import.c says, though.
> It claims to grok \octal and described as C-style.

As Peff mentionned, my last version is better, although still a bit
incomplete. My new version documents things that _must_ be escaped, but
not what _can_.

I'm reluctant to try being exhaustive in the .txt documentation if there
is an exhaustive comment in the code. One option would be to actually
turn the comment into an official specification by moving it to the .txt
file, but that goes far beyond the scope of my patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
