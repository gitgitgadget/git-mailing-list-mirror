From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Sun, 31 Aug 2008 16:49:01 +0200
Message-ID: <vpqk5dxqlya.fsf@bauges.imag.fr>
References: <20080828171533.GA6024@blimp.local>
	<20080828212722.GF6439@steel.home>
	<7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
	<81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
	<20080830171331.GA26932@steel.home>
	<7vprnqifd2.fsf@gitster.siamese.dyndns.org>
	<20080831135023.GA6616@blimp.local>
	<20080831135458.GB6616@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 16:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZoI4-00042t-2V
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 16:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYHaOvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYHaOvY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 10:51:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:55096 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYHaOvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 10:51:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7VEnFQo014631
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 31 Aug 2008 16:49:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KZoEf-0004oY-7I; Sun, 31 Aug 2008 16:49:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KZoEf-0005xu-4j; Sun, 31 Aug 2008 16:49:01 +0200
In-Reply-To: <20080831135458.GB6616@blimp.local> (Alex Riesen's message of "Sun\, 31 Aug 2008 15\:54\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 31 Aug 2008 16:49:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94486>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is off(0) by default, to avoid scaring people unless they asked to.
> If set to a non-0 value, wait for that amount of deciseconds before
> running the corrected command.

Perhaps off should be -1 (or, say, anything negative), so that the
value 0 can be used to mean "execute the corrected command without
waiting".

(not that I really care personnally, I'd probably keep it off anyway).

-- 
Matthieu
