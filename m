From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Wed, 03 Apr 2013 10:52:51 +0200
Message-ID: <vpq4nfoatcs.fsf@grenoble-inp.fr>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
	<vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>
	<20130312013736.GB7105@unpythonic.net>
	<vpqwqtdkq9z.fsf@grenoble-inp.fr>
	<CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
	<vpqwqslgfzf.fsf@grenoble-inp.fr> <515B45AB.5030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git <git@vger.kernel.org>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 10:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNJSI-0004Ae-Po
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 10:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762770Ab3DCIxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 04:53:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36216 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760385Ab3DCIxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 04:53:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r338qp80000577
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Apr 2013 10:52:51 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UNJR6-0002zb-88; Wed, 03 Apr 2013 10:52:52 +0200
In-Reply-To: <515B45AB.5030503@gmail.com> (Manlio Perillo's message of "Tue,
	02 Apr 2013 22:55:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Apr 2013 10:52:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r338qp80000577
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365583977.21175@buZwBE+6Gz2yUfML6RCeOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219927>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> By the way: have you filled a bug report to Debian?

No, but this is a bug touching very few users, in Debian stable which is
reaching its end of life. I do not think the Debian folks would be
interested in fixing this non-security, non-critical bug now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
