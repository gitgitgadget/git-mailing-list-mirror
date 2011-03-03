From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Adding non-bare branches to a non-bare repository
Date: Thu, 03 Mar 2011 15:23:33 +0100
Message-ID: <4D6FA465.2060703@drmicha.warpmail.net>
References: <201103031053.35864.mail@samtuke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "mail@samtuke.com" <mail@samtuke.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 15:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv9Uh-0004Xf-9j
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 15:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1CCO07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 09:26:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56226 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751786Ab1CCO07 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 09:26:59 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 890EE2097D;
	Thu,  3 Mar 2011 09:26:58 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Mar 2011 09:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pE7cdTbWs31uUzz8m//z4LlvlTY=; b=X6vhVvrA7sy3WMqqhy1RIl/04GQQy0pBT1ujWHFEuAJIEZsGGAcfB3AKWPmaHMt2WXPwjxfNRerg5HKj52ezY17t9HovThf6kK0hJqNGZBXywUFp4tHutt8RlArDD+ylgYxBUtwsFJpb9OTrVvDJbbNVsX5JbkHoJoQcrU1/9Rk=
X-Sasl-enc: 1Kf5rGlwKHUbudN3nzWOw5j5nnt9DGXvwTPG3qzOeJy3 1299162418
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1056F400EC6;
	Thu,  3 Mar 2011 09:26:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <201103031053.35864.mail@samtuke.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168394>

mail@samtuke.com venit, vidit, dixit 03.03.2011 11:53:
> Hi,
> 
> My website is a non-bare git repository. I have a copy of the website for 
> testing purposes which is a separate git repository. Currently these two 
> repositories are not aware of each other, and I copy across files from one to 
> the other in order to bring features from the test repo into the live site.
> 
> I would like to make the testing repository into a branch of the live website 
> repository so that I can easily merge in changes from one to the other.
> 
> Both repositories need to be complete copies of files as they are web 
> accessible and must be functional.
> 
> Is this possible?
> 
> In future I also need to make a third copy of the site to have a beta as well 
> as an alpha testing copy of the website.

You probably should replace "branch" by "clone" in all that you have
said above.

There is no problem adding a non-bare repo as a new remote to an
existing non-bare repo. You can easily fetch from such a repo. The only
problematic thing is pushing to a branch in a remote repo which is
checked out there.

Michael
