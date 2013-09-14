From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t7508: avoid non-portable sed expression
Date: Sat, 14 Sep 2013 19:50:33 +0200
Message-ID: <vpqppsbe1hy.fsf@anie.imag.fr>
References: <1379134032-83211-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 19:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKu5x-0006zV-L2
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 19:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207Ab3INR5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 13:57:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34475 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488Ab3INR5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 13:57:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8EHoVHU016737
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 14 Sep 2013 19:50:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VKtzN-0000uU-Ht; Sat, 14 Sep 2013 19:50:33 +0200
In-Reply-To: <1379134032-83211-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sat, 14 Sep 2013 00:47:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 14 Sep 2013 19:50:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8EHoVHU016737
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379785835.35002@wq7Bn5c11oaZA31+CFiADw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234806>

Eric Sunshine <sunshine@sunshineco.com> writes:

>  strip_comments () {
> -	sed "s/^\# //; s/^\#$//; s/^#\t/\t/" <"$1" >"$1".tmp &&
> +	tab='	'
> +	sed "s/^\# //; s/^\#$//; s/^#$tab/$tab/" <"$1" >"$1".tmp &&

Sounds trivially right.

Sorry for breaking this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
