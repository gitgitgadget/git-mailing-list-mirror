From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: using aliases within the subdirectory
Date: Wed, 13 Apr 2011 14:18:08 +0200
Message-ID: <4DA59480.5080307@drmicha.warpmail.net>
References: <4DA579CA.5030908@ge.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matej Batic <matej.batic@ge.infn.it>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9z1W-0000rp-49
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab1DMMSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 08:18:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48007 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755448Ab1DMMSM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 08:18:12 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 12D1D20B9F;
	Wed, 13 Apr 2011 08:18:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 13 Apr 2011 08:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WXnLt6IpPsJyCakvoyyIArU1JIY=; b=BHmIepgMMNCb8WKOIAjNApB91R4YLzOePcm9f0fMwVw4mM4H/7vyKL0MvR3GIuVDjSga0AGcEjNfkO9WkBpn5kxCzXhjT1PhrakFCTJhnQN3uPTgw7C7t9jpVJr7/m3eXaVfCLsm37HvDalrh/kqUmBCe1f1642XdmOz1ssRhcM=
X-Sasl-enc: nGqvSeayL0BLy10cAXaDEq67FxZ02F8g7bE658v1i0mA 1302697090
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8F58E40F3E7;
	Wed, 13 Apr 2011 08:18:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4DA579CA.5030908@ge.infn.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171446>

Matej Batic venit, vidit, dixit 13.04.2011 12:24:
> Dear all,
> 
> I am facing a problem, noted previously in
>     
> http://git.661346.n2.nabble.com/git-alias-always-chdir-to-top-td1609456.html  
> 
>     http://kerneltrap.org/mailarchive/git/2010/5/5/29818/thread
> which in practice means that I cannot pass the " -- 
> relative_path_to_some_file_in_the_tree" argument to my alias.
> 
> Is there any way to get the current working dir before git changes dir 
> to root directory?
> 
> Best regards,
> Matej

This may depend on your shell and rc files, but for me, $PWD gives the
original current working dir.

Also, revisiting that topic after 1.7.5 seems worthwhile.

Michael
