From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PUB]What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Thu, 02 Jul 2015 11:33:12 +0200
Message-ID: <vpqbnfudhuv.fsf@anie.imag.fr>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 11:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAasH-0005mk-NK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 11:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbbGBJdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 05:33:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39316 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbbGBJdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 05:33:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t629XB45001029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 11:33:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t629XCTF004395;
	Thu, 2 Jul 2015 11:33:12 +0200
In-Reply-To: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 15:37:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 11:33:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t629XB45001029
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436434392.38057@YaczosoWo00t0DjxA1NTlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273223>

Junio C Hamano <gitster@pobox.com> writes:

> * ad/bisect-terms (2015-06-29) 10 commits
>  - bisect: allow setting any user-specified in 'git bisect start'
>  - bisect: add 'git bisect terms' to view the current terms
>  - bisect: add the terms old/new
>  - bisect: sanity check on terms
>  - bisect: don't mix option parsing and non-trivial code
>  - bisect: simplify the addition of new bisect terms
>  - bisect: replace hardcoded "bad|good" by variables
>  - Documentation/bisect: revise overall content
>  - Documentation/bisect: move getting help section to the end
>  - bisect: correction of typo
>
>  The use of 'good/bad' in "git bisect" made it confusing to use when
>  hunting for a state change that is not a regression (e.g. bugfix).
>  The command learned 'old/new' and then allows the end user to
>  say e.g. "bisect start --term-old=fast --term=new=slow" to find a
>  performance regression.
>
>  The bottom part has been quite well cooked.  Perhaps split it into
>  two topisc and merge the earlier ones to 'next' before the rest
>  settles.  Michael's idea to make 'good/bad' more intelligent does
>  have certain attractiveness ($gname/272867).

I think it makes sense to merge the first patches soon:

 - bisect: don't mix option parsing and non-trivial code
 - bisect: simplify the addition of new bisect terms
 - bisect: replace hardcoded "bad|good" by variables
 - Documentation/bisect: revise overall content
 - Documentation/bisect: move getting help section to the end
 - bisect: correction of typo

I have nothing to add on the last ones, but they can cook in pu a bit
longer.

Do you expect anything from my side?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
