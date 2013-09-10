From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Tue, 10 Sep 2013 10:10:39 +0200
Message-ID: <vpqwqmpjdvk.fsf@anie.imag.fr>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJJ3I-0001UX-MD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab3IJIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:11:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40351 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab3IJILx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:11:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8A8AcG5027607
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Sep 2013 10:10:38 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJJ1z-0000l1-L3; Tue, 10 Sep 2013 10:10:39 +0200
In-Reply-To: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Sep 2013 15:53:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Sep 2013 10:10:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8A8AcG5027607
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379405441.93779@o7n/tmLDBKhig+l89gwrxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234423>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
>  - rebase: fix run_specific_rebase's use of "return" on FreeBSD
>
>  Work around a bug in FreeBSD shell that caused a regression to "git
>  rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
>  success report to make sure we didn't miss any other use of a bare
>  "return" from dot-sourced script.
>
>  Will merge to 'next'.

BTW, this is a candidate for maint too I guess.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
