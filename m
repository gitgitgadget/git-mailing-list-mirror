From: Sam Vilain <sam@vilain.net>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 16:54:56 +1200
Message-ID: <461DBBA0.3070609@vilain.net>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com> <20070412042308.GA22539@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 06:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbrLH-0007QK-QN
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 06:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbXDLEzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 00:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbXDLEzE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 00:55:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59814 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030656AbXDLEzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 00:55:03 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id D7F7813A403; Thu, 12 Apr 2007 16:54:59 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 6EEF713A3E1;
	Thu, 12 Apr 2007 16:54:56 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <20070412042308.GA22539@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44319>

Jeff King wrote:
>> Alas - I think support for it seems to be going the away... what I am
>> missing is a clear way to say git-clone <repo>#branch that has the
>> same properties that `cg-clone <repo>#branch` has. Namely, once you
>> are done, there are clear names for your "local tip" and "remote tip",
>> and push and pull do the right thing without extra params.
>>     
>
> I don't think there is a way to clone _just_ that branch, but if you're
> OK with fetching all of the branches, then you should be able to do
> just:
>
> git-clone <repo>
> git-branch --track branch origin/branch
> git-checkout branch
>   

You can;

 mkdir moodle
 cd moodle
 git-init
 git-remote add -t mdl-topnz -f origin \
    git://git.catalyst.net.nz/moodle.git

But yes, not as easy as "cg-clone git://...#branch"

I sent a patch for 'git remote prune -c' recently that would help in the
transition between the two remotes formats.

Sam.
