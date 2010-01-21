From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Thu, 21 Jan 2010 14:51:41 +0100
Message-ID: <4B585BED.700@drmicha.warpmail.net>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi> <4B584DDD.7060701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 14:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXxV9-00087D-2M
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 14:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0AUNx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 08:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367Ab0AUNxx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 08:53:53 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54669 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754276Ab0AUNxk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 08:53:40 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A1B1CDF87;
	Thu, 21 Jan 2010 08:53:37 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 21 Jan 2010 08:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=s4R733DFoCR+Xmf8c+Rx2rElens=; b=jZVx79aP4g+kOmJElBYnYx3D0lYeh9PeThDO5E3xM9KyJc4PLT+/IJvhgGHsHwAizQO9P6vTmsUtWCpsemVI3vw+0lLidTk9zLpKU2eUElBN13wD9QLZOxOc3XwexJd4zvT0NqgHEXY9S8uC4E7TNXAnVi3t4jcBijrESkhCZaw=
X-Sasl-enc: YG/pTszTK+22Wxo3KKg6XqhmIboP3y7eTYMsoRDP+CXM 1264082017
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 979934B92F9;
	Thu, 21 Jan 2010 08:53:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <4B584DDD.7060701@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137655>

Johannes Sixt venit, vidit, dixit 21.01.2010 13:51:
> Works for me, thank you very much!
> 
> Junio, kindly squash in these speeling fixes in both patches:
> 
> sed -i 's/impiled/implied/g' `git diff HEAD^ --name-only Documentation/`
> 

Also, the option descriptions are kind of staccato English right now,
lacking a few "the" here and there. Should we fix this or simply leave
it at that?

Michael
