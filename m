From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/WIP v3 4/4] ref-filter: move code from 'for-each-ref'
Date: Thu, 28 May 2015 22:35:00 +0200
Message-ID: <vpq382go2yz.fsf@anie.imag.fr>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:35:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4WG-0007g8-Kt
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbbE1UfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:35:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38143 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbbE1UfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:35:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKYv4a012533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 22:34:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SKZ006017902;
	Thu, 28 May 2015 22:35:00 +0200
In-Reply-To: <1432835025-13291-4-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 28 May 2015 23:13:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 22:34:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SKYv4a012533
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433450101.24612@pdNzPOqQ+MNX67jMbC+HRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270192>

Karthik Nayak <karthik.188@gmail.com> writes:

> Move most of the code from 'for-each-ref' to 'ref-filter' to make
> it publically available to other commands, this is to unify the code

s/publically/publicly/

> --- /dev/null
> +++ b/ref-filter.h

Moving file to the .h file should be done in a separate patch. I don't
want to review the 1050 lines of cut-and-paste other than by doing the
cut-and-paste myself and see if I get the same result, but this part is
not as straightforward and needs proper thinking and review.

In short: the big code movement should be *only* a cut-and-paste, alone
in its own patch.

On overall, we're getting close to an acceptable version for these 4
patches. My advice: prioritize polishing these few patches, so that we
can do a detailed review and then consider this part "done" (either
merged in git.git or not, but I'd like to avoid having to review the
code movement & refactoring again when we move to the next patches).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
