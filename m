From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: v3 [PATCH 2/2] status:introduce status.branch to enable --branch by default
Date: Tue, 11 Jun 2013 09:51:58 +0200
Message-ID: <vpqy5ah84pt.fsf@anie.imag.fr>
References: <51b5ede3.41a42a0a.02a1.3464SMTPIN_ADDED_BROKEN@mx.google.com>
	<CALkWK0mQ9e1nR1jBgZKB6hgV+ptEXr225MchsVoM6514-KdqPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 09:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmJND-0000ib-0C
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 09:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab3FKHwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 03:52:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51631 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab3FKHwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 03:52:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5B7pwun008658
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 09:51:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmJN0-0001Kl-UR; Tue, 11 Jun 2013 09:51:59 +0200
In-Reply-To: <CALkWK0mQ9e1nR1jBgZKB6hgV+ptEXr225MchsVoM6514-KdqPg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 11 Jun 2013 13:00:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 09:51:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227422>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> <y@ensimag.imag.fr> wrote:
>> [...]
>
> Good change.
>
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index 9a07f15..958617a 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>
> I expected one test.  Two, at most.  This is a bit overzealous. 

I actually had this discussion with Jorge (in real life). I first
thought this was too much, and I think we already removed one rendundant
test. But actually, this should be "two at least", since you really want
to test whether --[no-]branch takes precedence over status.branch or
not, in addition to testing status.branch alone.

The last two tests are less important, but they also test something (in
short: what happens when branch.status is set to something other than
"true"). So I think it makes sense to keep them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
