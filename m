From: Dan Zwell <dzwell@gmail.com>
Subject: Re: $GIT_DIR usage
Date: Sun, 05 Aug 2007 09:02:08 -0400
Message-ID: <46B5CA50.3050500@gmail.com>
References: <46B59F63.8020707@gmail.com> <Pine.LNX.4.64.0708051332230.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHflZ-0006bf-5r
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbXHENDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXHENDZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:03:25 -0400
Received: from mailhub.lawrence.edu ([143.44.0.14]:43396 "EHLO lawrence.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751259AbXHENDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:03:25 -0400
Received: from [69.140.46.21] (account zwelld HELO [192.168.2.3])
  by lawrence.edu (CommuniGate Pro SMTP 5.1.10)
  with ESMTPSA id 29972797; Sun, 05 Aug 2007 08:03:24 -0500
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0708051332230.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55013>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 5 Aug 2007, Dan Zwell wrote:
> 
>> $ export GIT_DIR="`pwd`/.git_public"
>> $ git init
>> warning: templates not found /usr/share//git-core/templates/
>> Initialized empty Git repository in /home/user/temp/.git_public/
> 
> I think that you implicitly created a bare repository with that.  Just 
> check if "git config core.bare" returns true.
> 
> If so, you need to change that in order to have a working tree.
> 
> Hth,
> Dscho
> 
> 

You are exactly right, I accidentally created a bare repository. I can 
do 2 things: I can change core.bare to true, or I can create .git in the 
normal way, then move rename it. Both things still have the problem of 
git not knowing where the working directory is. Is the only way to fix 
this in 1.5.2.4, or is my only option to upgrade?

Thanks,
Dan
