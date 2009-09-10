From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 16:17:11 +0200
Message-ID: <4AA90A67.401@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <200909101218.06789.johan@herland.net> <4AA8DC23.6050500@drmicha.warpmail.net> <200909101429.30190.johan@herland.net> <alpine.DEB.1.00.0909101534440.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlkSo-0006JG-EC
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbZIJORV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755722AbZIJORV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:17:21 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54116 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712AbZIJORV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 10:17:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 255D7693A4;
	Thu, 10 Sep 2009 10:17:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Sep 2009 10:17:24 -0400
X-Sasl-enc: 2j3p938aLNG9rDK94VAw0Yewv57ATfRDDK7gMbbLVwlC 1252592243
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E9BB3691C4;
	Thu, 10 Sep 2009 10:17:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.1.00.0909101534440.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128116>

Johannes Schindelin venit, vidit, dixit 10.09.2009 15:35:
> Hi,
> 
> On Thu, 10 Sep 2009, Johan Herland wrote:
> 
>> I think I vote for the second option, renaming 'git branch --track' 
>> to 'git branch --upstream', and s/@{tracked}/@{upstream}/.
> 
> That does not make any sense, as that --track is to be understood as a 
> verb.  How do you "upstream a branch"?

Well, that brunch also got its granma wrong tho his speeling is right ;)

Seriously: In

git branch --track branch1 branch2

who tracks whom if you read "--track" as a verb?
So, "--track" can only be understood as an attribute to the main (first)
argument, saying it's tracking something. Just as --upstream could be
read as an attribute meaning "has an upstream".

(Note also how different this is from how -b works for checkout, -b
actually taking an argument: git checkout -b branch1 branch2)

Cheers,
Michael
