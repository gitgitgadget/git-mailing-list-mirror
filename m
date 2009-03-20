From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Gnome chose Git
Date: Fri, 20 Mar 2009 09:33:16 +0100
Message-ID: <49C354CC.2020108@drmicha.warpmail.net>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pat Notz <patnotz@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:35:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkaC0-0005XJ-0P
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 09:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZCTIdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 04:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbZCTIdf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 04:33:35 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50588 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754030AbZCTIde (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 04:33:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7BCCF2F6665;
	Fri, 20 Mar 2009 04:33:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 04:33:31 -0400
X-Sasl-enc: jn2/cPFKX6m+WNjoV6cZf1qTc8Y5BKqO8XijaK1IQF3z 1237538011
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A8C4B4CEC5;
	Fri, 20 Mar 2009 04:33:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090319201405.GD17028@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113916>

Jeff King venit, vidit, dixit 19.03.2009 21:14:
> On Thu, Mar 19, 2009 at 09:50:39AM -0600, Pat Notz wrote:
> 
>> On Thu, Mar 19, 2009 at 9:16 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>>
>>> Why are people reinventing the reflog, and core.logallrefupdates ?
>>>
>>
>> Hmmm, lack of awareness of core.logallrefupdates in my case.  Thanks
>> for the pointer.
> 
> But do note that reflogs expire eventually, so you will want to also
> look at gc.reflogexpire and gc.reflogexpireunreachable if you want to
> keep this as an activity log forever.
> 
> -Peff

In any case, reflogs are local. I would assume that accountability
tracking should be public and transparent. Depends on the use case, of
course.

Michael
