From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 21:59:17 +0100
Message-ID: <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com> <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com> <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de> <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrJt5-0004lc-S9
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXKKU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXKKU6S
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 15:58:18 -0500
Received: from mailer.zib.de ([130.73.108.11]:59983 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbXKKU6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 15:58:18 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABKwFho026359;
	Sun, 11 Nov 2007 21:58:15 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82006.pool.einsundeins.de [77.184.32.6])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABKwENA007552
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 21:58:15 +0100 (MET)
In-Reply-To: <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64512>


On Nov 11, 2007, at 8:36 PM, Jon Smirl wrote:

> On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> On Nov 11, 2007, at 7:02 PM, Jon Smirl wrote:
>>
>>> Is the remote config not correct?
>>
>> This is the configuration for remote "dreamhost". In your
>> previous mail you also mentioned a remote "linus". But
>> this seems to be unrelated to your question.
>>
>>
>>> [remote "dreamhost"]
>>>         url = ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
>>>         fetch = +refs/heads/*:refs/remotes/dreamhost/*
>>
>> correct. This fetches the branches from the remote and stores
>> them locally as remote tracking branches "dreamhost/<branch>".
>>
>>>         push = +refs/heads/*:refs/remotes/linus/*
>>
>> This "renames" your branches when you push. Your local branches
>> get pushed to "dreamhost" and are stored there as remote branches
>> "linus/<branch>". From your previous mail I assume you like to store
>> them as normal branches. You'd need to say
>
> I did this part incorrectly. I was trying to push my local definition
> of the linus remote to the dreamhost repo so that when someone clones
> dreamhost linus would be defined in their repo.
>
> jonsmirl@terra:~/mpc5200b$ git remote show linus
> * remote linus
>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/ 
> linux-2.6.git
>
> How do I push the definition of the linus remote repo?

You can't. Remotes are local to a repository. They cannot be
"pushed" nor will they be "cloned" or "fetched".

	Steffen
