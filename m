From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Documentation/git-merge.txt: weaken warning about uncommited changes
Date: Tue, 18 Jun 2013 10:56:39 +0200
Message-ID: <vpqppvju794.fsf@anie.imag.fr>
References: <1371544975-18703-1-git-send-email-Matthieu.Moy@imag.fr>
	<CALkWK0=USVa2htHSTyj4C7FrKEko-e_UGAnu-3UNvx_ue1vwig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 10:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uorii-0007vr-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab3FRI4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:56:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57019 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980Ab3FRI4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:56:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5I8uc77018323
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 10:56:38 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoriR-0005aY-Cp; Tue, 18 Jun 2013 10:56:39 +0200
In-Reply-To: <CALkWK0=USVa2htHSTyj4C7FrKEko-e_UGAnu-3UNvx_ue1vwig@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 14:19:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 10:56:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228177>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> Weaken the warning by discouraging only merge with /non-trivial/
>> uncommited changes.
>>
>> I don't think documenting all the failure cases in the doc would be a
>> good idea, so I've left the "in some cases" part.
>
> It's already documented in the pre-merge checks section, as Jonathan
> pointed out [1]. 

I had missed this one. But that's not the only case, you may also have
problems with renames. The complete list would be really long to have
here, and won't bring much to the user.

> We should update the documentation to point to it: I do not think
> "non-trivial" is much of an improvement.

Actually, I think it essentially says it all. If your changes are
important enough to deserve a real backup, you should stash or commit.
If you're ready to take the risk of losing it (the risk is small, but
does exist), it's OK to run "git merge" blindly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
