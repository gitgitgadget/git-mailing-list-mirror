From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t3200: test branch creation with -v
Date: Sat, 10 Sep 2011 15:29:43 +0200
Message-ID: <4E6B6647.7090802@drmicha.warpmail.net>
References: <20110909193033.GA31184@sigill.intra.peff.net> <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net> <20110909194357.GA31446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 10 15:31:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Nf1-0004Yq-Qk
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 15:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759353Ab1IJN3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 09:29:47 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49974 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319Ab1IJN3q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2011 09:29:46 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EB91624EFE;
	Sat, 10 Sep 2011 09:29:45 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Sat, 10 Sep 2011 09:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=XC7nMeYnjQMCIUCWwwQiHP
	z8yUk=; b=Fy+7H9ZooD68HNPeXPFZr/xgo3R+m5KPFYFw+phflxfLoF+2ZzeXXD
	WYLIgZdWTkdbUW239OsWr4AK4k2keBD9tKzQjWWyEGFXlXCgH6nUT6MlDpk1IQqS
	rGicbmCdSnnM6OJpHOA/hvuNWTJ8YT9wRl/dellOTC9dwF/vLsxrc=
X-Sasl-enc: jA6SwrNaMFko3m24LIiBPRcDGAzkgrqnPR19+2QM+0uR 1315661385
Received: from localhost.localdomain (p548590EE.dip0.t-ipconnect.de [84.133.144.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FE435402F9;
	Sat, 10 Sep 2011 09:29:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <20110909194357.GA31446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181154>

Jeff King venit, vidit, dixit 09.09.2011 21:43:
> On Fri, Sep 09, 2011 at 09:40:59PM +0200, Michael J Gruber wrote:
> 
>> +test_expect_success 'git branch -v t should work' ' +	git branch
>> -v t && +	test .git/refs/heads/t &&
> 
> test -f ?
> 
> Also, don't we have test_path_is_file which yields slightly prettier 
> output (and maybe some portability benefits; I don't remember)?
> 
>> +	git branch -d t && +	test ! -f .git/refs/heads/t
> 
> Ditto for 'test_path_is_missing' here.
> 
> -Peff

Well, I tried to follow the surrounding style. That t3200 could benefit
from some attention, though, which I did not want to mix in with the
issue at hand.

Michael
