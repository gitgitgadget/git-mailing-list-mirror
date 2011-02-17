From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to git checkout a orgin(unstage) version file in another
 directoy?
Date: Thu, 17 Feb 2011 13:35:15 +0100
Message-ID: <4D5D1603.6040208@drmicha.warpmail.net>
References: <loom.20110217T074533-358@post.gmane.org> <4D5CDBAD.4050700@drmicha.warpmail.net> <loom.20110217T110820-459@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq37t-0000aq-NT
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1BQMiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:38:25 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37891 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609Ab1BQMiX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 07:38:23 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 530A9207F8;
	Thu, 17 Feb 2011 07:38:23 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 17 Feb 2011 07:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ctywqe1LXtR7d5cbuEvj1kNwAAE=; b=GE/JZ265RdiuDopxXBuyLRTZnnXT3RlwvAtHd4EY34ChjeIycfPeJP1pZSo11anHIpZmn3Dn/UfYa5UGP5OMQM6B2pBwn8o5wJPq1Moa28DfdO8DEz84HV5pAs9qUIZ4qjhc/opNEFxxyZvgx912WFMP3bBNvPzeCcXConBb/ik=
X-Sasl-enc: VmH+lbyiXmHF0/wPJfe0Y/tzBi4sKjYVY/N6Y43ZJWnG 1297946303
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CAE954099A0;
	Thu, 17 Feb 2011 07:38:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <loom.20110217T110820-459@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167077>

Chunlin Zhang venit, vidit, dixit 17.02.2011 11:17:
> Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> 
>> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
> But after I test,I found that after run this command,the file I do 
> checkout action become unstaged.
> It is weard,because I have set the "--work-tree" to another directory.
> my command line for example:
> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout 
> HEAD -- Android.mk
> 
> You can test with a git repository.I have no idea how to work around now.
> 

So, you don't really want to "checkout" the file. You only want its
contents without updating the index. (My brain is apparently too
git-rotted already to even think of the possibility that you didn't mean
"our checkout" by "checkout").

Jonathan gave you the perfect solution for what you want.

Michael
