From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 11:21:46 +0100
Message-ID: <vpqlin0n8w5.fsf@bauges.imag.fr>
References: <4F63205A.6000202@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8UIK-000481-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 11:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032677Ab2CPKVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 06:21:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35513 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031136Ab2CPKVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 06:21:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2GAHFIN025556
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 11:17:15 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8UI7-0000lr-6H; Fri, 16 Mar 2012 11:21:47 +0100
In-Reply-To: <4F63205A.6000202@seap.minhap.es> (Nelson Benitez Leon's message
	of "Fri, 16 Mar 2012 12:13:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Mar 2012 11:17:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2GAHFIN025556
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332497837.93835@JW/lcZTSeAUZ52GYPTcesg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193250>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> +# You can re-order the commit lines to affect the order on which
> +# the commits will be applied.

That's probably the main use of "rebase -i", so it deserves a mention,
yes.

Maybe shorten it to one line like

  You can re-order the lines to change the order of commits in history.

(BTW, is it not 'order in which', not '_on_ which'?)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
