From: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Tue, 06 Sep 2005 12:06:17 -0700
Message-ID: <431DE8A9.7010404@linuxmachines.com>
References: <430A84D1.2050206@linuxmachines.com> <Pine.LNX.4.63.0508230846180.26600@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 21:05:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECijb-0006Ry-4D
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 21:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVIFTDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVIFTDe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 15:03:34 -0400
Received: from [64.71.148.162] ([64.71.148.162]:44704 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750809AbVIFTDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 15:03:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id 5B79E6EFCD;
	Tue,  6 Sep 2005 12:06:16 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22713-08; Tue, 6 Sep 2005 12:06:15 -0700 (PDT)
Received: from [192.168.36.10] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 9C1096EFCB;
	Tue,  6 Sep 2005 12:06:15 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508230846180.26600@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8139>

On 08/22/2005 11:48 PM, Johannes Schindelin wrote:
> 
>>patch:
> 
> "git diff"
> 
> 
>>push:
> 
> "git push origin" (or maybe "git push HEAD:origin")
> 
> 
>>pull:
> 
> "git pull origin"
> 
> 
>>commit:
>>	vi changelog.txt
>>	GIT_AUTHOR_NAME="$(GIT_AUTHOR_NAME)" \
>>	GIT_AUTHOR_EMAIL="$(GIT_AUTHOR_EMAIL)" \
>>	git-commit-tree `git-write-tree` -p $(HEAD) < changelog.txt > .git/HEAD
>>	rm changelog.txt
> 
> 
> "git commit"

Well, I did that by hand so at the end I could have it append the
changes to a changelog file in the archive itself.

>>add_all:
>>	./git-ls-new-files |xargs -n 1 git-update-cache --add
> 
> 
> "git add $(git ls-files --others)"

I was using the version of git that was in debian sarge; it was too old
and didn't do the commands. I've updated and everything is working now.

Thanks for the help!
Jeff
