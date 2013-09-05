From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu, 05 Sep 2013 21:36:47 +0200
Message-ID: <vpqioyfukkw.fsf@anie.imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHfMX-0005om-IB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab3IEThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:37:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59697 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756278Ab3IETg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:36:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r85Jajo6016850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 21:36:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHfMG-0004iz-1a; Thu, 05 Sep 2013 21:36:48 +0200
In-Reply-To: <xmqqhadzhyjb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 Sep 2013 12:13:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Sep 2013 21:36:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r85Jajo6016850
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379014608.44101@YNG9Axt7PmlfcuV2IJo3xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233988>

Junio C Hamano <gitster@pobox.com> writes:

> One caveat, though.  The name "oldStyle" will become problematic,
> when we want to remove some wart in the output format long after
> this "no comment prefix by default" series lands.  Some people may
> expect setting oldStyle=true would give output from 1.8.4 era, while
> some others would expect that it would give output from 1.8.5 era
> that does not have comment prefix but still has that wart we will
> remove down the line.

I'm fine with any name actually (since it is enabled by default, people
don't need to know the name to benefit from the new output). Maybe
status.displayCommentPrefix was the best name after all.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
