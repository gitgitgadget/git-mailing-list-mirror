From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 17:22:38 +0100
Message-ID: <5106A5CE.3000800@drmicha.warpmail.net>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 17:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzrU5-0000YO-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 17:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab3A1QWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 11:22:40 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50825 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab3A1QWj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 11:22:39 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 10BF420637;
	Mon, 28 Jan 2013 11:22:38 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 28 Jan 2013 11:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=CUFmUl7oTs/szQV+5J7di+
	N4FPI=; b=oq8mCh+0zouf45pJQ/Fus3HTnj1uSfrJFvZb75/atU02UlKaOE+lfl
	bu3p6wd7LX+YFM0LDKdwnxGrmI5g28hcBqu9LBOZ7jz86yYvC6BO3UEhEV4NIyqf
	0IhAKIQfoaVMfAU/s+T0CSslPKQDSIyufnXgzOMMDPEzbtllS/z/w=
X-Sasl-enc: TvWuNkzLKxl1bOkLFLqrcU5IaB38n4PSJiJK98TmBxyG 1359390157
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4ADF38E08BC;
	Mon, 28 Jan 2013 11:22:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <510684FB.80104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214837>

Manlio Perillo venit, vidit, dixit 28.01.2013 15:02:
> Il 28/01/2013 13:52, Michael J Gruber ha scritto:
>> Manlio Perillo venit, vidit, dixit 28.01.2013 10:26:
>>> Il 28/01/2013 00:00, Junio C Hamano ha scritto:
>>>> wookietreiber <kizkizzbangbang@googlemail.com> writes:
>>>
>>>>> I have a feature request for `git add` auto completion:
>>>>>
>> [...]
>>> For the OP: the last patch can be found in the mailing list archive,
>>> with the subject:
>>> 	[PATCH v5] git-completion.bash: add support for path completion
>>> and date:
>>> 	Fri, 11 Jan 2013 19:48:43 +0100
>>>
>>> Can you please test it?
>>>
> 
>> I haven't looked at the patch, but in the example above, untracked
>> files) could be added as well (unless you use -u), so maybe the scope
>> should depend on the option? If the new completion code kept me from
>> adding untracked files easily it wouldn't be an improvement.
> 
> 
> The patch will suggest (for git add command), all the files that are
> candidate to be added to the index file.
> 
> Please, test it and report any behaviour you think is incorrect.

OK, that seems to work and to be quite helpful.

Minor nit: "git add -u" could use the same fileset as "git commit". But
I don't know whether completion can act upon the presence of options.
Currently, it also includes untracked files (just like without -u) but
omits unmodified and ignored ones, which is already quite an improvement.

I won't be able to review the completion code but may contribute a few
lines to t/t9902-completion.sh, possibly.

Michael
