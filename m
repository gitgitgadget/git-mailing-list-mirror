From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Standardize python shebangs
Date: Thu, 08 May 2014 13:48:46 +0200
Message-ID: <vpqlhucmqxt.fsf@anie.imag.fr>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ydpiog.fsf@anie.imag.fr>
	<536a842838fbb_76ff7a52ec5d@nysa.notmuch>
	<vpqr445nxrw.fsf@anie.imag.fr>
	<536a9a34e8194_76ff7a52ec7f@nysa.notmuch>
	<vpq1tw5nw7q.fsf@anie.imag.fr>
	<d15f06ad-0418-48ed-a9dc-6ca1e955e75c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 13:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiMot-00015a-LA
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 13:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbaEHLsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 07:48:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47951 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaEHLsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 07:48:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s48Bmige013393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 May 2014 13:48:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s48Bmkau008675;
	Thu, 8 May 2014 13:48:46 +0200
In-Reply-To: <d15f06ad-0418-48ed-a9dc-6ca1e955e75c@email.android.com> (James
	Denholm's message of "Thu, 08 May 2014 08:19:15 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 May 2014 13:48:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s48Bmige013393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400154526.71074@eLk7RL0PlDCvTfs6uWlCwg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248418>

James Denholm <nod.helm@gmail.com> writes:

> On 8 May 2014 06:57:13 GMT+10:00, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Matthieu Moy wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>> > If you want to use python2, then use '/usr/bin/env python2'.
>>>> 
>>>> Err, yes, this is what the code does before your patch.
>>>
>>> Not for all the instances.
>>
>>Well, I guess not all scripts require python2, hence not all scripts
>>declare that they depend on python2.
>
> Does it make sense for git to have a strict subset of python scripts as
> version agnostic, though? Given that some scripts depend on python2
> already, and hence we know that the user has python2,

No, we don't. People do not have to use _all_ Python scripts. The
discussion started about git-multimail.py, which I use on a server which
doesn't have python3, while my desktop (where I use other Git commands)
has Python3.

It is very important that git-multimail keeps running with Python2
(ideally, it could be portable Python 2 or 3, but it's not so easy to
do), but that would be strange to force even non-git-multimail-users to
use Python2 for that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
