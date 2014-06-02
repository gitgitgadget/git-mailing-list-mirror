From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] string-list.h: Add a value to string_list initializer lists
Date: Mon, 02 Jun 2014 12:54:51 +0200
Message-ID: <vpqa99vr37o.fsf@anie.imag.fr>
References: <1401699504-29826-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 12:55:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrPtN-0005BF-8c
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbaFBKy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 06:54:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38726 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbaFBKy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 06:54:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s52Asnr3029037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jun 2014 12:54:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s52AspRX017102;
	Mon, 2 Jun 2014 12:54:51 +0200
In-Reply-To: <1401699504-29826-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 2 Jun 2014 01:58:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Jun 2014 12:54:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s52Asnr3029037
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402311292.00343@oobKaNqE04Rh1ZdEVUtJ7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250562>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add a NULL value in the end of STRING_LIST_INIT_NODUP and
> STRING_LIST_DUP to initialize `compare_strings_fn`.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> When I used a malloced string_list to play around with string-list API and
> used the default init_list, it caused a seg fault. After an hour of debugging
> I saw that comapre_strings_fn should be initialized to NULL. In C, even an
> incomplete initialzer initializes every value to NULl or 0, so in normal
> usage in the codebase this problem never occurs. Still it is better to be
> thorough.

Part of this comment should be in the commit message itself. The "I
used ..." part should not (it is your experience), but the last two
sentences make sense IMHO.

Other than that, the changes sounds good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
