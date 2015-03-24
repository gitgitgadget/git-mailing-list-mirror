From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Tue, 24 Mar 2015 18:31:43 +0100
Message-ID: <vpq4mpas3nk.fsf@anie.imag.fr>
References: <20150324163730.GA8366@yoshi.chippynet.com>
	<CACRoPnRBBVGt8PVHVEYct46abLMJvKf0+MNz7bX2nx2C7OHd3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSgT-0004OK-BL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbbCXRbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:31:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42488 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbbCXRbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:31:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2OHVfRX025562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2015 18:31:41 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2OHVhm6009555;
	Tue, 24 Mar 2015 18:31:43 +0100
In-Reply-To: <CACRoPnRBBVGt8PVHVEYct46abLMJvKf0+MNz7bX2nx2C7OHd3Q@mail.gmail.com>
	(Paul Tan's message of "Wed, 25 Mar 2015 01:22:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Mar 2015 18:31:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2OHVfRX025562
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427823103.70974@DqqC+fBu3jz/Gf45s5bJAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266205>

Paul Tan <pyokagan@gmail.com> writes:

> On Tue, Mar 24, 2015 at 6:19 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> About the timeline: I'd avoid too much parallelism. Usually, it's best
>> to try to send a first patch to the mailing list as soon as possible,
>> hence focus on one point first (I'd do that with pull, since that's the
>> one which is already started). Then, you can parallelize coding on git
>> am and the discussion on the pull patches. Whatever you plan, review and
>> polishing takes more than that ;-). The risk is to end up with an almost
>> good but not good enough to be mergeable code. That said, your timeline
>> does plan patches and review early, so I'm not too worried.
>>
>
> Well, I was thinking that after the full rewrite (2nd stage, halfway
> through the project), any optimizations made to the code will be done
> iteratively (and in separate small patches)

Yes, that's why I'm not too worried. But being able to say "this part is
done, it won't disturb me anymore" ASAP is still good IMHO, even if
"this part" is not so big.

But again, I'm thinking out loudly, feel free to ignore.

>> A general advice: if time allows, try to contribute to discussions and
>> review other than your own patches. It's nice to feel integrated in the
>> community and not "the GSoC student working alone at home" ;-).
>
> Yeah I apologize for not participating in the list so actively because
> writing the git-pull prototype and the proposal took a fair chunk of
> my time.

Don't apologize, you're doing great. I'm only pointing out things that
could be "even better", but certainly not blaming you!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
