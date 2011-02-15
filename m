From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Regarding GIT API
Date: Tue, 15 Feb 2011 13:40:47 +0100
Message-ID: <4D5A744F.5000208@drmicha.warpmail.net>
References: <loom.20110215T120434-373@post.gmane.org> <AANLkTim4ucYtoyNEM2+=-dJTmpBtqy1zJOEX3k3Wk+XU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Abhinav Goyal <honeykool23@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 13:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKG6-0003LA-PU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 13:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab1BOMny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 07:43:54 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36051 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754539Ab1BOMnx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 07:43:53 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 401C020565;
	Tue, 15 Feb 2011 07:43:52 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 07:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=yY5UdASlHy8Oiyn66cf3EKSPgoU=; b=ruuGI9xcjFyyk5iKEEr06IO12vLXj5E8ci1+YWER98aH476EQpegDCjLytd/PZiWetL6k6BCKUF68aPMOSgkcHi2QwTinDwSi2qlAIwneyFVOO4vzVI9+pH5jwkauce9y7AFWpFXZpkwISVGJBj2EC619vpxQrzOuUteaJFXPL8=
X-Sasl-enc: 1coRBRWxUfy/K7vQ/dlQm1Lt0RsT+l8l3IqdyUi6UlE7 1297773831
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A22FA4488AC;
	Tue, 15 Feb 2011 07:43:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim4ucYtoyNEM2+=-dJTmpBtqy1zJOEX3k3Wk+XU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166842>

Dmitry Potapov venit, vidit, dixit 15.02.2011 12:49:
> On Tue, Feb 15, 2011 at 11:08:14AM +0000, Abhinav Goyal wrote:
>> I just need the git command
>> support for my C++ application. I have my own reason for not using command
>> prompt system call.
> 
> If you need full git functionality, currently the only proper way is to
> use git porcelain command, i.e. run commands using system() and parse
> their output. Git porcelain commands are designed to be used in this way,
> so their output is easy to parse. Also, their output should not change
> between different versions, in contrast to front-end git commands, which
> provide more human oriented output.

You mean "plumbing" for the commands with robust interface.

The front-end commands are "porcelain": they may break when used for
heavy (scripting) work...

> 
> NOTE: There are libraries for some other languages such as Java and Ruby
> (jGit and Grit correspondingly), but they contain re-implementation of
> most git functionality. No one has bothered to write anything like that
> in C. So, libgit2 provides only low-level and very limited functionality.
> 
> More information about git interfaces to different languages, you can
> find here:
> 
> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Interfaces_to_other_programming_languages
> 
> 
> Dmitry
