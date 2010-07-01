From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git reflog delete / manpage confusion
Date: Thu, 01 Jul 2010 15:09:41 +0200
Message-ID: <4C2C9395.1080900@drmicha.warpmail.net>
References: <AANLkTik3bApuScgjXtr-VjhmY4NIuakoX_RZaYLqqpwL@mail.gmail.com>	<20100701101613.GA1961@sigill.intra.peff.net> <AANLkTilaKwB1BYTNIJ49M0CZAJGrsPetQDOxZj_RHRv3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 15:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUJXI-0008Pj-Pb
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 15:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab0GANKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 09:10:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55702 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124Ab0GANKa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 09:10:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3E89510B7E8;
	Thu,  1 Jul 2010 09:10:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 01 Jul 2010 09:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YIozBA7tb10XDz9LQfDMJcnb5so=; b=T4jF2J5ujpgyqqZkkxgQvD0yixHw6gB6/rDn53eswkQgBXaUYzT/8NUIyPCmQ+jdQHL8EZRd0ttdsOM6FZZDaVJ8mo+n1o7DzPRmodNwcklvmZWc90tiX766w11X2L8OBYNbY4dZ4PJXnyidnXZSHZCilb98ZgWBkSNgPxbsDDw=
X-Sasl-enc: 2XG/QsC+Axbl8jPLYYemdkcqB/de85S5aZs6ySz+lfqN 1277989829
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 55A054E4967;
	Thu,  1 Jul 2010 09:10:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTilaKwB1BYTNIJ49M0CZAJGrsPetQDOxZj_RHRv3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150034>

Mahesh Vaidya venit, vidit, dixit 01.07.2010 12:58:
> Hi I am confused again as it indeed removed HEAD{4}
> 
>  -2993260 HEAD@{4}: commit (initial)

It didn't, that's what Jeff explained and what the content of
.git/logs/HEAD showed (which you chose to cut; also, please don't top-post).

It really deleted the line for 364bcc0, but when showing the reflog git
mistakenly shows 364bcc0 rather than 2993260 (for the new HEAD{@3}) in
this case.

Michael
