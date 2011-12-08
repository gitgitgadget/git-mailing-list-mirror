From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Thu, 08 Dec 2011 14:28:33 +0100
Message-ID: <vpqiplrchvi.fsf@bauges.imag.fr>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
	<1323349817-15737-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:29:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYe2C-0002PW-R9
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab1LHN2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:28:41 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57421 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab1LHN2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:28:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id pB8DMT1C017675
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2011 14:22:29 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RYe1a-0004g3-5R; Thu, 08 Dec 2011 14:28:34 +0100
In-Reply-To: <1323349817-15737-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 8 Dec 2011 18:40:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Dec 2011 14:22:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pB8DMT1C017675
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1323955351.64461@MphQHxZ4fMv0WokeUqTM3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186561>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  test_expect_success "--batch-check with multiple sha1s gives correct format" '
> -    test "$batch_check_output" = \
> -    "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
> +    echo "$batch_check_output" >expect &&
> +    echo_without_newline "$batch_check_input" | git cat-file
> + --batch-check >actual &&
> +    test_cmp expect actual
>  '

Whitespace damage?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
