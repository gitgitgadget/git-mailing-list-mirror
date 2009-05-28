From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 11:47:40 +0200
Message-ID: <4A1E5DBC.2090908@drmicha.warpmail.net>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>	 <7vprdthezg.fsf@alter.siamese.dyndns.org>	 <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>	 <4A1E4B82.9040809@drmicha.warpmail.net> <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 11:48:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9cDl-0005en-KF
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZE1Jrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZE1Jrw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:47:52 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34698 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753285AbZE1Jrv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 05:47:51 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1C289346B3F;
	Thu, 28 May 2009 05:47:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 28 May 2009 05:47:53 -0400
X-Sasl-enc: CDBQS1+keJIUynNbQamyva4SrckhfP0xqyocrC55479t 1243504072
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 462EF58764;
	Thu, 28 May 2009 05:47:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120181>

Martin Langhoff venit, vidit, dixit 28.05.2009 11:34:
> On Thu, May 28, 2009 at 10:29 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Yes, but your shell seems to find git-diff somewhere, so what about:
>>
>> type --all git-diff
>> echo $PATH
> 
> $ type --all git-diff
> bash: type: git-diff: not found
> $ echo $PATH
> /home/martin/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
> 
> there is _no other_ git-diff. It's bash magic. See
> http://popey.com/command_not_found

This is insane. Don't they even distinguish between an interactive shell
and a non-interactive one?

> 
> Note that all the key commands work. I clone, diff, commit, push,
> merge daily on this machine.
> 
>> OTOH: The git-pack-objects usage line indicates that you clearly have
>> older plumbing lying around. I suspect there are at least 2 issues on
>> that box.
> 
> Might be. Maybe ~/bin got cleaned up but not libexec? Or the bisecting
> back-and-forth left stray bits in ~/bin?

Well, I would say go "find / git-diff-index", or simply nuke anything
git you find and do a clean install... "find"ing the left over bits
would help making sure that git's own search path is OK.

Michael
