From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: configuring cherry-pick to always use -x?
Date: Tue, 15 Feb 2011 10:29:05 +0100
Message-ID: <4D5A4761.6010308@drmicha.warpmail.net>
References: <4D596435.9020605@gmail.com> <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com> <4D59A39C.9090402@gmail.com> <4D5A401B.1050103@drmicha.warpmail.net> <20110215091828.GA22661@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Adam Monsen <haircut@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpHGa-00065B-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1BOJcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:32:11 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48395 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753598Ab1BOJcK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 04:32:10 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8E4352015E;
	Tue, 15 Feb 2011 04:32:09 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 04:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TyoLWZ/mq1ZDnGsVxyfph4nXZgI=; b=NifNoV2sINs8kor6Y1zYVuhkII35zAK6LxoAH/FB/tPevUuFjnccomjD99Muz/gsefu/UrTFZIuYU2bT3WtssI//gosBk8veCmOpS57mK0TqRiKtKXgmWDLaQd5bLYRa0ucBQrYhI93Gtl8g4cGZZZbqGBFfB/ZBQvdoGmEF9Eo=
X-Sasl-enc: rF+9AesGo32lLrLvR5ZwCkzfrvSKI+7jE9++1DeM80QD 1297762329
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DDA23407BA8;
	Tue, 15 Feb 2011 04:32:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110215091828.GA22661@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166832>

Jonathan Nieder venit, vidit, dixit 15.02.2011 10:18:
> Michael J Gruber wrote:
> 
>> - If you do want them on the same branch "f-release", you probably know
>> beforehand which commits you don't want on master. You can fake-merge
>> these ("merge -Xours") to master and merge the others
> 
> For the record, I think that should be -sours.
> 
> I think it's just a typo but the difference is big --- -sours means
> "supersede by pretending to merge but actually keeping our version",
> while -Xours means "do a normal merge but be sloppy and favor our
> change when encountering adjacent or overlapping changes".

Yes, sorry and thanks.

-Xours may still be useful to know for the OP, but for the complete
fake-merge you need -sours. In fact, "-sours" has an awfully good
mnemonic when used for fake-merging commits which you do not want to
cherry-pick :)

Michael
