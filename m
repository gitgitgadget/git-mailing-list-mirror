From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 0/4] send-email: correct various issues
Date: Wed, 01 Apr 2009 10:33:04 +0200
Message-ID: <vpqiqlolqnz.fsf@bauges.imag.fr>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lovwk-0005wt-J9
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbZDAIfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbZDAIfq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:35:46 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:59459 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469AbZDAIfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:35:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n318X4Kx012874;
	Wed, 1 Apr 2009 10:33:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lovse-0007e4-Ai; Wed, 01 Apr 2009 10:33:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lovse-0007wT-8R; Wed, 01 Apr 2009 10:33:04 +0200
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com> (Jay Soffian's message of "Tue\, 31 Mar 2009 12\:22\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 01 Apr 2009 10:33:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115354>

Jay Soffian <jaysoffian@gmail.com> writes:

> Junio, these are technically all independent bug fixes, but they were
> minor, so I've lumped them together. I figured you'd just add them to
> the js/send-email topic anyway. Also, I apologize for causing trouble in
> master. :-(

But I shall thank you for fixing them ;-).

> Jay Soffian (4):
>   send-email: don't attempt to prompt if tty is closed

Works, I don't have garbage anymore in my logs.

>   send-email: ask_default should apply to all emails, not just the
>     first

Works, I get the informational message in my logs once, and all the
mails are sent successfully.

>   send-email: correct two tests which were going interactive
>   send-email: ensure quoted addresses are rfc2047 encoded

Didn't test these.

-- 
Matthieu
