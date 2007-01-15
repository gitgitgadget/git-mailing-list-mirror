From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Mon, 15 Jan 2007 22:54:21 +0200
Message-ID: <45ABE9FD.4050601@cc.jyu.fi>
References: <200701150221.l0F2LlwJ016982@laptop13.inf.utfsm.cl>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 21:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6YlX-0006ex-Qe
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 21:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXAOUtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXAOUtN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 15:49:13 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:44794 "EHLO posti6.jyu.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbXAOUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 15:49:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti6.jyu.fi (8.13.6/8.13.6) with ESMTP id l0FKmsnm001455;
	Mon, 15 Jan 2007 22:48:54 +0200
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti6.jyu.fi ([127.0.0.1])
	by localhost (posti6.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qa4QznLpwKx3; Mon, 15 Jan 2007 22:48:54 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.120])
	by posti6.jyu.fi (8.13.6/8.13.6) with ESMTP id l0FKmpBE001450;
	Mon, 15 Jan 2007 22:48:52 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 55071468194;
	Mon, 15 Jan 2007 22:54:22 +0200 (EET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070111)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701150221.l0F2LlwJ016982@laptop13.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36883>


>> Would it make sense to add something like this to the announcements as
>> it is not very easy to find references to the git-repository itself from
>> the net.
>>
>>    You can get the git repository-itself by using a following commands
>>
>>            git-clone git://git.kernel.org/pub/scm/git/git.git git_repo
>>
>>    After that you can switch to tagged version <v1.5.0-rc1> or sources
>> from the repository by using command
>>
>>           git-checkout -f v1.5.0-rc1 master
>>
>>    Alternatively you can download the tar packed version of sources from
>>       
>>           http://www.kernel.org/pub/software/scm/git/
>>     
>
> Be careful, this gives you a old-fashioned repository, the repositories
> created by 1.5.0-rc are different, and 1.4.4.4 doesn't grok them:
>
>    * refusing to create funny ref 'remotes/origin/*' locally
>   
So that would also not work if one uses git-1.4.4 client for fetching
from the git-1.5.x repository?
How one is then supposed to jump from head/master to tagged version?

Mika
