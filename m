From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PUB]What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 19:16:37 +0200
Message-ID: <vpq4mjf74zu.fsf@anie.imag.fr>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<vpqzj17hpt8.fsf@anie.imag.fr>
	<xmqqmvx7xz45.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWShT-0005ep-Un
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbbHaRQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:16:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37711 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbbHaRQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:16:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7VHGZ9g026277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 19:16:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7VHGbPk021710;
	Mon, 31 Aug 2015 19:16:37 +0200
In-Reply-To: <xmqqmvx7xz45.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 31 Aug 2015 08:21:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 31 Aug 2015 19:16:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7VHGZ9g026277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441646197.81623@fxa4BlaNry0h7rfC1l4fkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276893>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * ad/bisect-terms (2015-08-03) 4 commits
>>>  - bisect: allow setting any user-specified in 'git bisect start'
>>>  - bisect: add 'git bisect terms' to view the current terms
>>>  - bisect: add the terms old/new
>>>  - bisect: sanity check on terms
>>>
>>>  The use of 'good/bad' in "git bisect" made it confusing to use when
>>>  hunting for a state change that is not a regression (e.g. bugfix).
>>>  The command learned 'old/new' and then allows the end user to
>>>  say e.g. "bisect start --term-old=fast --term=new=slow" to find a
>>>  performance regression.
>>>
>>>  Michael's idea to make 'good/bad' more intelligent does have
>>>  certain attractiveness ($gname/272867), and makes some of the work
>>>  on this topic a moot point.
>>>
>>>  Will hold.
>>
>> This topic has been there for a while and unless I missed a discussion,
>> nothing happened. While I agree that Michael's idea is good and makes
>> this series less useful, I think this topic also makes sense.
>>
>> I'd be in favor of merging it.
>
> "Nothing happened" is never a good enough reason to argue for
> merging new stuff, but now you are starting a discussion here, let's
> see where it takes us to.  I am neutral myself at this moment.

Right, but my feeling after the previous discussion was that people were
mostly in favor of merging the changes (i.e. allowing user-defined
bisect terms), but we wanted to make sure we didn't get any objection on
second thought, hence it was a good thing to have an extended cooking
period.

To add arguments in favor of merging: even if we get the "auto swap
good/bad", having user-defined terms can still help for situations where
the change between states does not correspond to a situation where one
state is 'good' and one is 'bad' eg. --term-old=red --term-new=blue.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
