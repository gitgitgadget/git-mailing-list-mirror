From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/7] build: "make clean" should not remove configure-generated files
Date: Thu, 19 Jul 2012 08:56:59 +0200
Message-ID: <vpqy5mgdyro.fsf@bauges.imag.fr>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
	<cover.1342649928.git.stefano.lattarini@gmail.com>
	<e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:57:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srkfs-0005t8-Jc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 08:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab2GSG5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 02:57:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42441 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2GSG5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 02:57:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6J6t29C020754
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2012 08:55:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrkfT-0007RQ-SX; Thu, 19 Jul 2012 08:56:59 +0200
In-Reply-To: <e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com>
	(Stefano Lattarini's message of "Thu, 19 Jul 2012 00:35:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 19 Jul 2012 08:55:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6J6t29C020754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343285706.21202@dYG8NBUt+eOSWuBjlY6RUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201712>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> for example, an autotools old-timer that has run:
>
>     ./configure --prefix /opt/git
>
> in the past, without running "make distclean" afterwards, would
> expect a "make install" issued after a "make clean" to rebuild and
> install git in '/opt/git';

I've been hit by that behavior once. Thanks for fixing it. The patch
looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
