From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What happened to having to recover from upstream rebase?
Date: Wed, 13 May 2015 11:44:06 +0200
Message-ID: <vpq617wzuah.fsf@anie.imag.fr>
References: <555107F7.1040906@gmail.com>
	<b1686e402e9459e58acc7700a12f377d@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 11:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTD8-0000rL-GG
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933488AbbEMJoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:44:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42592 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933410AbbEMJoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:44:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9i5As004431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2015 11:44:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9i64n021944;
	Wed, 13 May 2015 11:44:06 +0200
In-Reply-To: <b1686e402e9459e58acc7700a12f377d@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 13 May 2015 11:37:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 May 2015 11:44:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4D9i5As004431
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432115049.19641@b1HU7NwZPi8bWFTMy/0aiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268969>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Phil,
>
> On 2015-05-11 21:50, Phil Susi wrote:
>> So it used to be that when upstream rebased, you'd get an error when
>> you tried to pull again
>
> Not necessarily. You would get this error *only* if there was a merge
> conflict between the revisions (one revision being your
> remote-tracking branch *before* the pull, the other revision being
> your remote-tracking branch *after* the fetch implied by the pull).

However, you would get an error if you try to *push* (non-fast forward,
because the remote has new commits which are different from yours even
though they represent similar changes). And one solution to this error
would be some rebase or reset magic.

So, Phil, that may be the error you remember.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
