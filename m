From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 16:38:23 +0200
Message-ID: <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Lars Hoss <lars@woeye.net>, Jeff King <peff@peff.net>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 16:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq7XU-0005rs-Ca
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 16:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbYJOOig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbYJOOif
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 10:38:35 -0400
Received: from frim.nl ([87.230.85.232]:40136 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755960AbYJOOie (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 10:38:34 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Kq7WA-0001u3-AN; Wed, 15 Oct 2008 16:38:30 +0200
In-Reply-To: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98275>


On 15 okt 2008, at 14:07, Lars Hoss wrote:

> two days ago I posted about an issue:
> http://thread.gmane.org/gmane.comp.version-control.git/98171
>
> After more testing I can confirm it is indeed a bug.
>
> 1.6.0.2 on OSX Leopard doesn't work. After adding a submodule
> the folder of the submodule will always get listed under
> "Untracked files" when calling git status.
>
> 1.5.6, however, works fine. I have not tested trunk yet.
>
> So as a workaround I have to go back to 1.5.6 for now.

Works for me on Leopard

Vienna:a pieter$ git submodule add ~/projects/GitX/ gitx
Initialized empty Git repository in /Users/pieter/a/gitx/.git/
Vienna:a pieter$ git st
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   .gitmodules
#	new file:   gitx
#
Vienna:a pieter$ git --version
git version 1.6.0.2.415.gf9137

- Pieter
