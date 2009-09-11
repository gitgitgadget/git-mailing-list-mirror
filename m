From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 15:11:35 +0200
Message-ID: <4AAA4C87.6010900@drmicha.warpmail.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: james bardin <jbardin@bu.edu>
X-From: git-owner@vger.kernel.org Fri Sep 11 15:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm5v4-00065s-BE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 15:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbZIKNLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 09:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbZIKNLp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 09:11:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36784 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733AbZIKNLo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 09:11:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 64AA269692;
	Fri, 11 Sep 2009 09:11:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 11 Sep 2009 09:11:47 -0400
X-Sasl-enc: IqnYX5YLcDBr/qrhdvEecm5WkSkXIrpn272fmveD3rsW 1252674707
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D274835D56;
	Fri, 11 Sep 2009 09:11:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128190>

james bardin venit, vidit, dixit 10.09.2009 17:13:
> Hi,
> 
> I'm making a git rpm for our site, and I'm getting an error with
> bash_completion on RHEL/CentOS 5.
> 
> When outside a repo, any completion causes git to spit out
>   fatal: error processing config file(s)
> 
> This is 1.6.4.2 using the contrib bash completion file
> 
> Thanks
> -jim

I can't reproduce this with git version 1.6.5.rc0.164.g5f6b0 on Fedora 11.

Which exact steps reproduce it for you, and which relevant settings (PS1
and GIT_PS1_...) do you use? Do you have a system or global .gitconfig?

Michael
