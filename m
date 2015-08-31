From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PUB]What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 09:36:51 +0200
Message-ID: <vpqzj17hpt8.fsf@anie.imag.fr>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:37:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWJeL-0001Wt-PW
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 09:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbHaHhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 03:37:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44097 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbbHaHhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 03:37:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V7apQT005565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 09:36:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V7apLR008362;
	Mon, 31 Aug 2015 09:36:51 +0200
In-Reply-To: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 28 Aug 2015 14:11:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 09:36:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V7apQT005565
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441611413.37358@C2suvysDmrOEoqINGLpHJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276851>

Junio C Hamano <gitster@pobox.com> writes:

> * ad/bisect-terms (2015-08-03) 4 commits
>  - bisect: allow setting any user-specified in 'git bisect start'
>  - bisect: add 'git bisect terms' to view the current terms
>  - bisect: add the terms old/new
>  - bisect: sanity check on terms
>
>  The use of 'good/bad' in "git bisect" made it confusing to use when
>  hunting for a state change that is not a regression (e.g. bugfix).
>  The command learned 'old/new' and then allows the end user to
>  say e.g. "bisect start --term-old=fast --term=new=slow" to find a
>  performance regression.
>
>  Michael's idea to make 'good/bad' more intelligent does have
>  certain attractiveness ($gname/272867), and makes some of the work
>  on this topic a moot point.
>
>  Will hold.

This topic has been there for a while and unless I missed a discussion,
nothing happened. While I agree that Michael's idea is good and makes
this series less useful, I think this topic also makes sense.

I'd be in favor of merging it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
