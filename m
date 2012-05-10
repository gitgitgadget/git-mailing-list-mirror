From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/8] "git apply --threeway"
Date: Thu, 10 May 2012 09:31:11 +0200
Message-ID: <vpqtxzobigw.fsf@bauges.imag.fr>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 09:31:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSNqP-00076E-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 09:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab2EJHbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 03:31:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40075 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab2EJHbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 03:31:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4A7NuF5001457
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2012 09:23:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SSNqC-0006sS-2D; Thu, 10 May 2012 09:31:12 +0200
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com> (Junio C.
	Hamano's message of "Wed, 9 May 2012 23:02:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 May 2012 09:23:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4A7NuF5001457
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1337239440.31897@GTcBmpEIFDgiu9v9/LzNpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197551>

Junio C Hamano <gitster@pobox.com> writes:

>  - After trying and failing to apply the patch text, we inspect our object
>    database and see if there is a blob object that matches what is
>    recorded on the "index" line of the patch as its preimage.

Just being curious: why is it called "index"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
