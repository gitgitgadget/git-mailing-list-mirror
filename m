From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How do I get a list of tracking branches
Date: Thu, 21 Jan 2010 10:52:01 +0100
Message-ID: <4B5823C1.9010904@drmicha.warpmail.net>
References: <26ae428a1001210125j156b61afs64bb915a934530c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtjo-0003Hg-E6
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab0AUJx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 04:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041Ab0AUJx6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:53:58 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36988 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035Ab0AUJx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 04:53:58 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 46889CDE6C;
	Thu, 21 Jan 2010 04:53:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 21 Jan 2010 04:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=7/4hQ2FI18ut5VggJEZpzJ3YkpE=; b=cqCAGS0znnVIJNZFDL0dBtQzxbdjyxUyEiwnOkrcS17jIltG1+PSqsLrRUN+LG1+G0ZdB4r7BSzOr0PzXZjqiIZUmE6G7/ROsG7lEs+lxU0TOgEksHeAKEavwPk8WG8iHZmWvTysdKQQaakdRt5PyL1OJytKvN33B1IL6YmGMPM=
X-Sasl-enc: JNamQguF1lRd8twhGpvDgiAp3LNUiCiT5BsY2sxBjlkO 1264067634
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B63F6BF17;
	Thu, 21 Jan 2010 04:53:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <26ae428a1001210125j156b61afs64bb915a934530c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137648>

Howard Miller venit, vidit, dixit 21.01.2010 10:25:
> Hi,
> 
> I know I can go and look at the config file and get this info but is
> there a simple command that shows which local branches are tracking
> remote branches? It seems like a very obvious thing to want to know
> but I can't find it. 'branch -av' even shows 'n behind' and/or 'n
> ahead' but not *what* it is behind or ahead.

The latter info you get with git branch -vv.

But you said you wanted to know which local branches have upstreams. Or
do you want to know which local branches have a specific remote as upstream?

Michael
