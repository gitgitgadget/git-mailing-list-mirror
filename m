From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 13:52:23 +0100
Message-ID: <51067487.9050505@drmicha.warpmail.net>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzoCa-0002gm-Tb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 13:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab3A1MwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 07:52:23 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39882 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754580Ab3A1MwW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 07:52:22 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 91F1320BE4;
	Mon, 28 Jan 2013 07:52:22 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Jan 2013 07:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=l84A5ro60uknCCYj95IW6g
	P/j0M=; b=aY5k4aHZzlJKuJvZXBdUxAtarh9S/1KcHXllE0mxOF0Ws9/DwdSHyZ
	Lynt5oVpteZVSY3g7uQhGtBQjIFn+wg4Fj+rBLo9k2H78YHbLk0fOGGzQ1m2Xq+7
	nAn0Ilqye4/h86caOKEMN6sHY9Tg57hMRrtXdz5ClNbDIo7AIEZNQ=
X-Sasl-enc: KkE5KJH3V58BejRXbd6UDZpGbqhHg4bV0fJqUMXXu0kD 1359377542
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B75FC8E089F;
	Mon, 28 Jan 2013 07:52:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <5106444F.2040007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214835>

Manlio Perillo venit, vidit, dixit 28.01.2013 10:26:
> Il 28/01/2013 00:00, Junio C Hamano ha scritto:
>> wookietreiber <kizkizzbangbang@googlemail.com> writes:
> 
>>> I have a feature request for `git add` auto completion:
>>>
>>> `git add` auto completion suggests all files / directories,
>>> filtered by nothing. I guess it would be much nicer (as in
>>> increasing productivity) if it would only suggest unstaged
>>> content, as reported by `git status`, because that would be the
>>> only content one would be able to add.
> 
>> I think that is what Manlio Perillo tried to do with the stalled
>> mp/complete-paths topic that is queued in 'pu'.
> 
>> Manlio, any progress?
> 
> Well, I assumed that the patch was stalled due to missing review from
> git completion experts...
> 
> For this reason I have not updated it with your latest suggestions,
> waiting for the review (also, because now I'm busy with other projects).
> 
> For the OP: the last patch can be found in the mailing list archive,
> with the subject:
> 	[PATCH v5] git-completion.bash: add support for path completion
> and date:
> 	Fri, 11 Jan 2013 19:48:43 +0100
> 
> Can you please test it?
> 
> 
> 
> 
> Regards   Manlio
> 

I haven't looked at the patch, but in the example above, untracked
files) could be added as well (unless you use -u), so maybe the scope
should depend on the option? If the new completion code kept me from
adding untracked files easily it wouldn't be an improvement.

Michael
