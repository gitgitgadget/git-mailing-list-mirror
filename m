From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Fri, 13 Mar 2009 15:08:17 +0100
Message-ID: <49BA68D1.2070102@drmicha.warpmail.net>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <43d8ce650903120714g782b98e8t81340546547fe98d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 15:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li85I-0002H9-Ns
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 15:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZCMOIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 10:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZCMOIc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 10:08:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53347 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299AbZCMOIb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 10:08:31 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CEE5C2EFC62;
	Fri, 13 Mar 2009 10:08:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 13 Mar 2009 10:08:29 -0400
X-Sasl-enc: 3s8KIzXjfkeOaiZFGQodcbkG6LcseOSYcwiVdA7+aCj4 1236953309
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0E5F6301D6;
	Fri, 13 Mar 2009 10:08:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090313 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <43d8ce650903120714g782b98e8t81340546547fe98d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113190>

John Tapsell venit, vidit, dixit 12.03.2009 15:14:
> 2009/3/12 Sverre Rabbelier <srabbelier@gmail.com>:
>> Heya,
>>
>> On Thu, Mar 12, 2009 at 14:18, John Tapsell <johnflux@gmail.com> wrote:
>>> Is probably a mistake by the user.  We should warn the user and point
>>> them in the right direction.
>>
>> The point is that we _already_ warned the user (like Dscho pointed
>> out), and that(as you pointed out), it didn't work :P.
> 
> Just doing:
> 
> git branch -b origin/master origin/master
> 
> gives no error or warning at all.

...and it really should not. If you have a repo with lots of remotes and
tracking branches, it makes a lot of sense to have a local branch
reponame/branchname which tracks the remote branch reponame/branchname.
Note that the first is refs/heads/reponame/branchname whereas the latter
is refs/remotes/reponame/branchname. It gives warnings when it's
ambiguous, yay.

Michael J Gruber
