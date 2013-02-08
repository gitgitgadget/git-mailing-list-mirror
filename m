From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build the script
Date: Fri, 08 Feb 2013 18:34:37 +0100
Message-ID: <vpqzjzeaevm.fsf@grenoble-inp.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
	<1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
	<1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
	<7vhaln7wkg.fsf@alter.siamese.dyndns.org>
	<20130208042800.GB4157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rr7-0006CF-RT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946836Ab3BHRe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:34:59 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35807 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946817Ab3BHRe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:34:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r18HYZNK029254
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2013 18:34:35 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3rqP-0002yu-V9; Fri, 08 Feb 2013 18:34:37 +0100
In-Reply-To: <20130208042800.GB4157@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Feb 2013 23:28:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Feb 2013 18:34:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r18HYZNK029254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360949676.39136@yY9tvPtw+G9GPUTuK04yXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215788>

Jeff King <peff@peff.net> writes:

> That seems much cleaner to me. If done right, it could also let people
> put:
>
>   CONTRIB_PERL += contrib/mw-to-git/git-remote-mediawiki

Actually, you can already do this:

  SCRIPT_PERL += contrib/mw-to-git/git-remote-mediawiki.perl

probably not by design, but it works!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
