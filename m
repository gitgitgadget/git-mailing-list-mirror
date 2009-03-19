From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Introduce %<branch> as shortcut to the tracked   branch
Date: Thu, 19 Mar 2009 15:52:58 +0100
Message-ID: <49C25C4A.2010202@drmicha.warpmail.net>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJdv-0000AX-9w
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 15:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbZCSOxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbZCSOxP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 10:53:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57559 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752537AbZCSOxO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 10:53:14 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C8E322F6C14;
	Thu, 19 Mar 2009 10:53:12 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 10:53:12 -0400
X-Sasl-enc: yGWJklgDdaF+f3H+3BCbVqrrrkIfag/ALV3c5+i4gVwP 1237474392
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C606315A35;
	Thu, 19 Mar 2009 10:53:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113773>

Johannes Schindelin venit, vidit, dixit 18.03.2009 23:46:
> Hi,
> 
> On Wed, 18 Mar 2009, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Suggested by Pasky.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In the longer term who suggested matters much less than why such a 
>> feature is desirable, how it is used, and without it what is impossible 
>> and/or cumbersome.  What's the motivation behind this?
>>
>> You do not have to explain it to me, but you should explain it to the 
>> history that records this commit, and to the users who read doccos.
> 
> And that's not all... Documentation updates and tests for % and %<branch> 
> are missing, too.
> 
> My main motivation to make this patch was to see how fast I could come up 
> with something working that does not hurt my eyes.
> 
> But I do not have time to do more today: My main project as well as Git 
> got accepted into the Google Summer of Code program, so I am even more 
> swamped than usually.
> 
> So... if anybody feels like it, I would be very thankful for a proper 
> commit message, documentation and tests...

Just a quick note that I'm feeling like it... Though it seems this does
not quite work with local branches, i.e. a branch created with

git checkout --track -b tracking tracked

with "tracked" being a local branch. I don't see why on first inspection
of the code (branch.tracking.merge = refs/heads/tracked, so what), but
maybe you will...

Michael
