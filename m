From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Does anyone use git-notes?
Date: Thu, 26 Aug 2010 10:09:27 +0200
Message-ID: <4C762137.1090801@drmicha.warpmail.net>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 10:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoXWj-0002AM-Lj
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 10:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0HZIJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 04:09:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42132 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752363Ab0HZIJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 04:09:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2D508351;
	Thu, 26 Aug 2010 04:09:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Aug 2010 04:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=apXEjt+MNVZlLAiSUwNkn2Fms0M=; b=c+/fuVv0gg4uvVC8AKDVx5chByzvdLe2owiWARAvi+22jhnE1TbqOUb60c6tvs92bzGKci25L0xbP6BRj/insfAxE3k8Z/tk6Z6HCN67/ZILEZbJBQ9ZV634rAmubri5JPL2CCFpc3mK5hornotOQ/bNUVOfsx/dJrotUEg1ohk=
X-Sasl-enc: dDo1A7sos3fNdrzET0i2BGIUZ2cOwuSfrs8Ats++kddY 1282810167
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4EA8F40201B;
	Thu, 26 Aug 2010 04:09:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154531>

Scott Chacon venit, vidit, dixit 25.08.2010 20:15:
> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis.  I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anything
> practical.  Can someone share with me how they use them and what the
> cycle is?

I use it to store the patch comments (the part that goes after the
"---", before the diff) along with my commits so that I have them in my
git.git tree, not only in my mbox. This makes it also easier to redo a
patch and keep the comment when regenerating the patch e-mail with
format-patch. (I don't have a good solution for the cover letter yet.)

Michael
