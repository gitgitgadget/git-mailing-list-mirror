From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 19:12:04 +0100
Message-ID: <vpqr4llhua3.fsf@grenoble-inp.fr>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
	<20130116160410.GC22400@sigill.intra.peff.net>
	<7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
	<CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
	<20130116171809.GA2476@farnsworth.metanate.com>
	<7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
	<20130116175057.GB27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXTd-0006if-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab3APSMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:12:21 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57552 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab3APSMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:12:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0GHxlNC004788
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2013 18:59:47 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TvXT2-0003J5-K3; Wed, 16 Jan 2013 19:12:04 +0100
In-Reply-To: <20130116175057.GB27525@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Jan 2013 09:50:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Jan 2013 18:59:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0GHxlNC004788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358963988.31283@IxNkZ1Vb/ohkl4miMrdL1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213789>

Jeff King <peff@peff.net> writes:

> It seems a little weird to me that clang defines __GNUC__, but I
> assume there are good reasons for it.

The reason is essentially that clang targets compatibility with GCC
(implementing the same extensions & cie), in the sense "drop in
replacement that should be able to compile legacy code possibly relying
on __GNUC__ and GCC extensions."

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
