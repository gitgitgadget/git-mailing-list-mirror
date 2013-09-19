From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #05; Wed, 18)
Date: Thu, 19 Sep 2013 12:16:56 +0200
Message-ID: <vpqob7pt8tj.fsf@anie.imag.fr>
References: <xmqqwqmdu6rg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 12:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMbIP-00062y-1v
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 12:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab3ISKRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 06:17:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32824 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3ISKRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 06:17:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8JAGuHR026370
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Sep 2013 12:16:56 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VMbI9-0003GL-8G; Thu, 19 Sep 2013 12:16:57 +0200
In-Reply-To: <xmqqwqmdu6rg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Sep 2013 15:03:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 19 Sep 2013 12:16:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8JAGuHR026370
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380190616.48282@toXwa8L7MRDLn6pIU4iM+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235011>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
>   (merged to 'next' on 2013-09-13 at 82e8b91)
>  + rebase: fix run_specific_rebase's use of "return" on FreeBSD
>
>  Work around a bug in FreeBSD shell that caused a regression to "git
>  rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
>  success report 

We just did:

  http://thread.gmane.org/gmane.comp.version-control.git/234825/focus=234870

>  Will merge to 'master' in the fifth batch.

Don't forget maint, too.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
