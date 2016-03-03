From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 03 Mar 2016 18:09:14 +0100
Message-ID: <vpqvb53ij45.fsf@anie.imag.fr>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan>
	<CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
	<vpq1t7rlfi1.fsf@anie.imag.fr>
	<CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: authmillenon@riot-os.org, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: Martine Lenders <mlenders@riot-os.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:09:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWkc-0001Rg-E0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867AbcCCRJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:09:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36847 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817AbcCCRJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:09:19 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u23H9CBI025484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 18:09:12 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23H9EMw032354;
	Thu, 3 Mar 2016 18:09:14 +0100
In-Reply-To: <CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
	(Martine Lenders's message of "Thu, 3 Mar 2016 17:48:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Mar 2016 18:09:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23H9CBI025484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457629753.0368@sM5onV8CohmMtNo2UztgXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288191>

Martine Lenders <mlenders@riot-os.org> writes:

>> [ Please, don't top-post on this list ]

... and as much as possible keep the "XYZ wrote:" line so that we know
who wrote what ;-).

I wrote:
>> I wish I could write commit messages like
>>
>> fixup! deadbeef: fix typo (foo -> bar)
>>
>> So that the commit message contains both the instruction for "rebase
>> --autosquash" and a quick explanation of what the commit is doing (as
>> usual commit messages).
>>
>> AFAIK, it's not possible currently but shouldn't be hard to implement.
>
> I would love that, too :-). This differs however from the original
> intent of my feature request. So maybe we finish this thread (since my
> John's proposal is 100% sufficient for me in that regard) and open a
> new one? How are the procedures for this on this list?

We don't have "procedure" for feature requests. It happens often that
someone dreams aloud like I did above, and it's OK as long as "it
shouldn't be hard to implement" is understood as "one day I should do
it" and not "hey, you lazy devs, why don't you code that for me?" ;-).

But in general, people get more interested when a proposal has a patch
attached.

I've added the idea here:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

(except I already changed my mind in the syntax)

I may get some students to work on this in May, or do it myself one day.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
