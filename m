From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Document and test the new % shotcut for the tracked branch
Date: Fri, 20 Mar 2009 11:38:56 +0100
Message-ID: <49C37240.6070604@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkc9k-0004l4-0D
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbZCTKjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZCTKjO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:39:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41045 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbZCTKjN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 06:39:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A9BC52F3C6A;
	Fri, 20 Mar 2009 06:39:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 06:39:11 -0400
X-Sasl-enc: 4xd06EQZ45ZnbarratInyz4XHh5KHXE459lRfcxslVjf 1237545551
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 838A528555;
	Fri, 20 Mar 2009 06:39:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113937>

Johannes Schindelin venit, vidit, dixit 20.03.2009 11:31:
> Hi,
> 
> On Fri, 20 Mar 2009, Michael J Gruber wrote:
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
> 
> That is brutal.  First shot, then cut.

I'm sorry! But you're a tough guy, you'll recover...

> 
>> Johannes Schindelin venit, vidit, dixit 20.03.2009 10:29:
>>>
>>> Often, it is quite interesting to inspect the branch tracked by a 
>>> given branch.  This patch introduces a nice notation to get at the 
>>> tracked branch: 'BEL<branch>' can be used to access that tracked 
>>> branch.
>>>
>>> A special shortcut 'BEL' refers to the branch tracked by the current 
>>> branch.
>>>
>>> Suggested by Pasky and Shawn.
>>>
>>> This patch extends the function introduced to handle the nth-last 
>>> branch (via the {-<n>} notation); therefore that function name was 
>>> renamed to something more general.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> I guess you beat me to it then, which is fine.
> 
> I had it ready yesterday!  But the real problem is not addressed by your 
> patch, either: '%<branch>' is a legal branch name.

No, of course, I just added doc+test to your patch v2, since you seemed
to encourage people to do so.

I would have sent it out yesterday if my tests hadn't shown a problem.
(Or did you misunderstand my doc notation? <branch> = ${branch} =
"branch" placeholder for a generic branch name)

> I briefly considered <branch>^{tracked}, but
> 
> - the ^{} codepath does not try to substitute branch _names_, so we'd have 
>   to duplicate that ^{} detection, and,
> 
> - it is really cumbersome to write.
> 
>> But haven't you seen my note about the failing test either? The code 
>> below tests with branches which track local branches. merge and remote 
>> is set for the branch in question ("tracking"), it's just that remote is 
>> ".". It seems that the remote.c code does not set up merge info for 
>> these branches.
> 
> I have seen it, it's just not my itch, and I am busy enough as it is.

If I'm not totally off-track (which I may well be) then that problem
should show up with other uses of the merge/track setting as well. I
guess it's just that everyone tracks remote branches, not local ones.

I'll see if I have time...

>> <Goes to figure out how to enter BEL...>
> 
> Ctrl-v Ctrl-g
> 
> Ciao,
> Dscho

Bing bing bing...

Michael
