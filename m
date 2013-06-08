From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module instead of the constant pragma
Date: Sat, 08 Jun 2013 20:27:17 +0200
Message-ID: <vpqtxl8v4oq.fsf@anie.imag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
	<20130608032324.GA20226@sigill.intra.peff.net>
	<51B32B0F.1030400@gmail.com>
	<20130608173149.GC28029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?C=E9lestin?= Perdu <tohwiq@gmail.com>,
	=?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:27:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlNrT-0004Oj-Pv
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3FHS1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 14:27:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43454 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab3FHS1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:27:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58IRFAS009982
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 20:27:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlNrB-0001OH-Uc; Sat, 08 Jun 2013 20:27:17 +0200
In-Reply-To: <20130608173149.GC28029@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2013 13:31:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 20:27:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58IRFAS009982
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371320839.04774@oxGzrwwK5y9J15yfTAtNZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226852>

Jeff King <peff@peff.net> writes:

> Thanks both for the explanation.  I don't see us using that to our
> advantage anywhere in the patch. So I think this is purely a style
> issue, which to me indicates that the extra dependency is not worth it,
> and the patch should be dropped.

Same here: I'd rather keep the dependency list small.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
