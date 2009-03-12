From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 14:15:16 +0100
Message-ID: <49B90AE4.9030904@drmicha.warpmail.net>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com> <alpine.LNX.1.00.0903111159530.19665@iabervon.org> <alpine.DEB.1.00.0903111742360.10498@intel-tinevez-2-302> <49B90683.1060501@drmicha.warpmail.net> <alpine.DEB.1.00.0903121407070.6335@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkmY-0000rA-7Y
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbZCLNPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 09:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbZCLNPa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:15:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39727 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756248AbZCLNP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 09:15:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9404A2EDA14;
	Thu, 12 Mar 2009 09:15:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 12 Mar 2009 09:15:27 -0400
X-Sasl-enc: ZGNLKMTgC/ogM9d1GvF1pXBgADFJZBYt1P7VSmGVeHWc 1236863727
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B12E62B80D;
	Thu, 12 Mar 2009 09:15:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903121407070.6335@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113067>

Johannes Schindelin venit, vidit, dixit 12.03.2009 14:07:
> Hi,
> 
> On Thu, 12 Mar 2009, Michael J Gruber wrote:
> 
>> Johannes Schindelin venit, vidit, dixit 11.03.2009 17:44:
>>
>>> On Wed, 11 Mar 2009, Daniel Barkalow wrote:
>>>
>>>> One thing that I think would be good whenever possible is to have the 
>>>> merge program generate a file in the same format which is easily 
>>>> recognizable as having conflict markers. For example, I think it 
>>>> should be possible to show conflicts in the text of office documents 
>>>> by having styles for each side of the merge, and show each side's 
>>>> content in the appropriate style. Then the user opens the document 
>>>> with their choice of office software, finds the things in the 
>>>> conflict styles, and decides what the result should be.
>>> That's a very good idea!  (Except for LaTeX, maybe...)
>> latexdiff (in perl) may give you a head start (or ache, I dunno).
> No.  latexdiff is about diffing.  It does nothing to help me resolve a 
> conflict.

Sure. If you want to merge you have to diff first (and display it). That
would be the "head start". Then you have to think about the merge.
That's where the "head ache" kicks in...

Michael
