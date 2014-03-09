From: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
Subject: Re: howto to run git without a master branch
Date: Sun, 09 Mar 2014 23:58:59 +0000
Message-ID: <531D0043.5060507@ist.utl.pt>
References: <531B8D91.6020800@ist.utl.pt> <531C1C69.6080809@web.de> <531CC6FE.2040803@ist.utl.pt> <531CE837.1080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, ikke@ikke.info
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMnPq-00073q-IR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 00:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbaCIXpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2014 19:45:54 -0400
Received: from smtp2.ist.utl.pt ([193.136.128.22]:59447 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaCIXpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 19:45:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 25658700048C;
	Sun,  9 Mar 2014 23:45:52 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id iUIz1+qodrv4; Sun,  9 Mar 2014 23:45:51 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 4175A700048A;
	Sun,  9 Mar 2014 23:45:51 +0000 (WET)
Received: from [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7] (unknown [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7])
	(Authenticated sender: ist12604)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 056112003FD9;
	Sun,  9 Mar 2014 23:45:51 +0000 (WET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
In-Reply-To: <531CE837.1080504@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243703>


> There is a "git remote set-head" to manipulate HEAD in a remote 
> repository.
Thanks, that is useful (like git symbolic-ref HEAD master-x suggested by 
Kevin, much better than editing the text file)
> I agree that this might be viewed as a user experience issue.
> But I can not come up with a possible solution.  Can you?
The branch where the user was when he/she pushed the repo to the server? 
it would be his/her responsibility to checkout the proper branch before 
pushing... if that was not good enough than he/she could always use git 
remote set-head... my point is: pointing to a bad branch that exists 
seems better than pointing to a branch that does not exist...

Anyway I agree this is not important, as we can easily change HEAD.
> I do not think there should be any issues.
Thank you very much for your answers,

Carlos
