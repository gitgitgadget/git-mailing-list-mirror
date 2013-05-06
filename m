From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Mon, 06 May 2013 09:58:06 +0200
Message-ID: <vpqli7s8rqp.fsf@grenoble-inp.fr>
References: <cover.1367551846.git.worldhello.net@gmail.com>
	<CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<CAPig+cR--LQSkxc27_tMRrEnFJFApymqK9268BQA0bab38W3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 06 09:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZGJe-00009x-QX
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 09:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab3EFH60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 03:58:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42213 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582Ab3EFH6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 03:58:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r467w5QN024847
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 May 2013 09:58:06 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UZGJC-00025M-MR; Mon, 06 May 2013 09:58:06 +0200
In-Reply-To: <CAPig+cR--LQSkxc27_tMRrEnFJFApymqK9268BQA0bab38W3OQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 5 May 2013 08:35:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 06 May 2013 09:58:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r467w5QN024847
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368431890.05552@5CDFl8uxUaVnBLT3sxzoDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223428>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The pattern [y] will match file named 'y'. It probably is unusual for
> files named 'y', 'n', etc. to exist in the top-level directory, but
> the gitignore patterns already provide an escape hatch for these
> unusual cases.

But how does the user know that?

I'd rather stay away from dwim that works in 99% of cases but do
something dangerous in the 1% remaining, and complex un-guessable escape
scheme to solve these few cases. The two stages (yes/no/edit, and then
escape patterns) is clear, and does not require so many additional
keystrokes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
