From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 10:29:54 +0200
Message-ID: <4A1E4B82.9040809@drmicha.warpmail.net>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>	 <7vprdthezg.fsf@alter.siamese.dyndns.org> <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 10:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9b0Q-0000wi-4g
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 10:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761582AbZE1IaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 04:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbZE1IaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 04:30:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52227 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761015AbZE1IaF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 04:30:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D9612346B0E;
	Thu, 28 May 2009 04:30:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 28 May 2009 04:30:06 -0400
X-Sasl-enc: 6hxTMnKg95KDr031Xz0Eo2apL5jSzWiBivr4WCmaYMtS 1243499406
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0A2613BC1C;
	Thu, 28 May 2009 04:30:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120171>

Martin Langhoff venit, vidit, dixit 28.05.2009 09:22:
> On Thu, May 28, 2009 at 9:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "type --all git"?
>> "git --exec-path"?
>> "ls $(git --exec-path)"?
>>
> 
> It all looks fairly correct to me:

Yes, but your shell seems to find git-diff somewhere, so what about:

type --all git-diff
echo $PATH

In any case, Ubuntu seems to do something strange about binaries which
used to be installed. How can "git-diff" trigger a message about
"apt-get install git-core"?

For sure it does the same strange thing for everything else which used
to be in your PATH, and this makes current stash, gc etc. fail when
trying to call git-pack-objects and such. A "/usr/bin time machine"???

OTOH: The git-pack-objects usage line indicates that you clearly have
older plumbing lying around. I suspect there are at least 2 issues on
that box.

Michael
