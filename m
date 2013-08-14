From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 00:59:02 +0200
Message-ID: <vpqy583hoax.fsf@anie.imag.fr>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
	<CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
	<201308141125.59991.mfick@codeaurora.org>
	<520C01C3.2060804@googlemail.com>
	<7vhaersx74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9k2F-0002Yy-89
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473Ab3HNW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:59:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37741 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933411Ab3HNW7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:59:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7EMx0cf013730
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Aug 2013 00:59:00 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9k1v-0003yg-40; Thu, 15 Aug 2013 00:59:03 +0200
In-Reply-To: <7vhaersx74.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Aug 2013 15:51:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Aug 2013 00:59:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7EMx0cf013730
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377125942.13341@NOZwRZA5Q7g26BkWW5Rxug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232320>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> I asked for a todo wish list a few weeks ago, but got no real answer,
>> but rather: "Pick your choice and try to come up with good patches".
>
> Hmph, I hope that wasn't me.
>
> There are some good ones here;
>
>   http://git-blame.blogspot.com/search?q=leftover

See also:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
