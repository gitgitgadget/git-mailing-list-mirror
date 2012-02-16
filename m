From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 15:15:27 +0100
Message-ID: <vpq62f627b4.fsf@bauges.imag.fr>
References: <vpq39abrxav.fsf@bauges.imag.fr>
	<1329395775-18294-1-git-send-email-Matthieu.Moy@imag.fr>
	<m3d39esxrg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 15:16:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry27u-0005tq-8o
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 15:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab2BPOP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 09:15:58 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55789 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2BPOP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 09:15:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1GECLLs018603
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Feb 2012 15:12:21 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ry27L-0000tZ-S2; Thu, 16 Feb 2012 15:15:27 +0100
In-Reply-To: <m3d39esxrg.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Thu, 16 Feb 2012 05:40:26 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Feb 2012 15:12:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1GECLLs018603
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330006342.57356@lsjPnPYzIenDsnsDbxoinA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190897>

Jakub Narebski <jnareb@gmail.com> writes:

> Nb. I think it would be good to put detecting PDF viewer in its own
> function, don't you?

I normally like functions, but for such a linear and small piece of
code, I think it adds more confusion that clarity to write

do_fo () {
   actual stuff
}

do_foo

than the actual stuff alone.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
