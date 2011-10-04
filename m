From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 04 Oct 2011 20:49:55 +0200
Message-ID: <4E8B5553.2080706@drmicha.warpmail.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net> <20111004105008.GA11789@sigill.intra.peff.net> <4E8AEDBD.4070404@drmicha.warpmail.net> <20111004113713.GA19171@sigill.intra.peff.net> <4E8AF812.5090906@drmicha.warpmail.net> <20111004124344.GA30162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 20:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBA4h-0001BB-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 20:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab1JDSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 14:49:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59423 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753855Ab1JDSt6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 14:49:58 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A22602B603;
	Tue,  4 Oct 2011 14:49:57 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 04 Oct 2011 14:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5QkE44tzJSBXKdVC38CvjF
	2jSxg=; b=eaqr408xeyhJH2wI/z7F+TxG8BAFpaYv6hDUH1MraanZQxdUWYGYWa
	3CbFyvkP4gPAHv4+DA4EblKJ3DiXpiwrsNNMPxQ6diNZiCJbFljVPfTGyT3C9ym6
	q5njWRsDa+7nwxJpvgEZ2uxMugy3UzPLvBzCBVHLEdleu34t0Yl48=
X-Sasl-enc: +xZnQ7rrUbNau0iacOF2k3KiFmNKL08oL8VUXG7ZpKXv 1317754197
Received: from localhost.localdomain (p5485928F.dip0.t-ipconnect.de [84.133.146.143])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F1D17900A00;
	Tue,  4 Oct 2011 14:49:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111004124344.GA30162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182786>

Jeff King venit, vidit, dixit 04.10.2011 14:43:
> On Tue, Oct 04, 2011 at 02:12:02PM +0200, Michael J Gruber wrote:
> 
>>> The latter is especially useful if you have put a username in your
>>> ~/.gitconfig, in which case you get:
>>
>> I'm actually wondering why git can't infer the user from
>>
>> https://user@host.com
>>
>> with last week's next, at least.
> 
> It can, and it has for some time. Part of the configurable-username
> thing was that it would be way nicer to just use a user-agnostic URL,
> because it means it's easier to share with other people.
> 

We seem to mean something different:

git config --get remote.bitbucket.pushurl
https://grubix@bitbucket.org/grubix/git.git
SSH_ASKPASS= git push -n bitbucket
Username for 'bitbucket.org':

I mean that git should not need to ask for the username here.

Michael
