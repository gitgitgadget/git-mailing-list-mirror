From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 15:00:51 +0200
Message-ID: <vpqmvzmwrng.fsf@anie.imag.fr>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8TFh-0002cS-8l
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 15:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbFZNBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 09:01:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37149 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbbFZNA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 09:00:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5QD0npm004763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 15:00:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QD0pCk008968;
	Fri, 26 Jun 2015 15:00:51 +0200
In-Reply-To: <CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
	(Christian Couder's message of "Fri, 26 Jun 2015 14:44:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 15:00:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QD0npm004763
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435928450.58729@B9s7gbD1cNTdP3Ekk74Lng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272777>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 26, 2015 at 1:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> [...]
>
>> +Eventually there will be no more revisions left to bisect, and the
>> +command will print out a description of the first bad commit, and also
>> +create a reference called `refs/bisect/bad` that points at that
>> +commit.
>
> This could be understood as meaning that `refs/bisect/bad` is created
> only at the end of the bisection.
>
>> -Eventually there will be no more revisions left to bisect, and you
>> -will have been left with the first bad kernel revision in "refs/bisect/bad".
>
> The original looks better to me in this regard.

I'm changing it to:

Eventually there will be no more revisions left to bisect, and the
command will print out a description of the first bad commit. The
reference `refs/bisect/bad` created by bisect will point at that
commit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
