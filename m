From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 09:45:50 +0200
Message-ID: <4D918E2E.4000206@drmicha.warpmail.net>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com> <7voc4uto9o.fsf@alter.siamese.dyndns.org> <4D91858F.7030404@drmicha.warpmail.net> <201103290938.41528.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RGFuaWVsIE55c3Ryw7Zt?= <daniel.nystrom@timeterminal.se>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TgF-0006KG-0y
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1C2Ht3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 03:49:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59697 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750935Ab1C2Ht2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:49:28 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1BCF20CFD;
	Tue, 29 Mar 2011 03:49:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 29 Mar 2011 03:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NL0cq0otdDTHIDdasLzx1mvgUBw=; b=tzF3LocroFQwYBdKyxizUyBr82VvgOdCHBMizRoXf/DS58luUekVAvJkorEx/7EgpACCRdHwbg+RAxj5gKksCMIuGH9xKBCeyzGeK6nxtqM6Attgj9kqBXeHE7BeGPVRPkkqxO3DE5vBMv3Qh5t4V5r+kQlvfFRramwJs0v3S+o=
X-Sasl-enc: 2/uuamffXDpCCb86lTItBE5oqgBizSI30h5OQw2Z/Qe/ 1301384967
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E3B8A4488A5;
	Tue, 29 Mar 2011 03:49:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <201103290938.41528.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170243>

Johan Herland venit, vidit, dixit 29.03.2011 09:38:
> On Tuesday 29 March 2011, Michael J Gruber wrote:
>> Note that you can share
>> notes when you set up refspecs etc in a push/pull based workflow. (I'm
>> not sure how well we support merging/pulling notes refs yet.)
> 
> Since v1.7.4, you can use "git notes merge" for merging notes ref. It's not 
> yet integrated with "pull", though, so typically you want to fetch it to a 
> different ref name, and then manually "git notes merge" that into the 
> original notes ref.

Yes, but what I meant with "well" was: If I merge regular branches, do
the notes get merged automatically? And the answer is "no", and as you
explain above, "git notes merge" copes with that (and with merging notes
for the same commit).

> E.g. if you want to sync "refs/notes/foo" with remote "bob", you can "git 
> fetch bob refs/notes/foo:refs/notes/bobs_foo", and then
> merge them with "git notes --ref=foo merge bobs_foo".

Longing for that refs/ layout overhaul...

>> This does not work well in a patch/e-mail-based workflow.
> 
> ...although there have been mailing list discussions on getting notes added 
> to "git format-patch" output (after the "---"), and then picked up again by 
> "git am".

So, here my "not well" was even overly positive ;)

Michael
