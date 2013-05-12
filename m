From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 02/10] Show items of interactive git-clean in columns
Date: Sun, 12 May 2013 19:09:39 +0200
Message-ID: <vpqli7ki0q4.fsf@grenoble-inp.fr>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 19:09:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZmW-00043O-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab3ELRJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:09:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58872 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569Ab3ELRJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:09:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4CH9bU1008268
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 May 2013 19:09:37 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UbZmF-0007Vi-B0; Sun, 12 May 2013 19:09:39 +0200
In-Reply-To: <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 12 May 2013 19:09:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4CH9bU1008268
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368983379.00424@PNp/My0+fZA7yuFrI8Mksw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224054>

Jiang Xin <worldhello.net@gmail.com> writes:

> +column.clean::
> +	Specify whether to output cleaning files in `git clean -i` in columns.
> +	See `column.ui` for details.
> +


> +static void pretty_print_dels()

Ah, OK. That's the helper function I was expecting in 01/10. The patches
would be easier to review if the helper was introduced in 01/10 and
then modified here to add column display, but the result is OK.

> +	/*
> +	 * always enable column display, we only consult column.*
> +	 * about layout strategy and stuff
> +	 */

Isn't this conflicting with the documentation above?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
