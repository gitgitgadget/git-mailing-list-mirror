From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 13:56:35 +0100
Message-ID: <49B90683.1060501@drmicha.warpmail.net>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com> <alpine.LNX.1.00.0903111159530.19665@iabervon.org> <alpine.DEB.1.00.0903111742360.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkUL-0002nP-5G
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZCLM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbZCLM4t
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:56:49 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35597 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754972AbZCLM4s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:56:48 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F1FF92ECA94;
	Thu, 12 Mar 2009 08:56:46 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 12 Mar 2009 08:56:47 -0400
X-Sasl-enc: VdtfD+lsSwa70o/H9w+t1ErHOOkiJ8sLUMRH5m6TN1Wt 1236862606
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0836EE503;
	Thu, 12 Mar 2009 08:56:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903111742360.10498@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113063>

Johannes Schindelin venit, vidit, dixit 11.03.2009 17:44:
> Hi,
> 
> On Wed, 11 Mar 2009, Daniel Barkalow wrote:
> 
>> One thing that I think would be good whenever possible is to have the 
>> merge program generate a file in the same format which is easily 
>> recognizable as having conflict markers. For example, I think it should 
>> be possible to show conflicts in the text of office documents by having 
>> styles for each side of the merge, and show each side's content in the 
>> appropriate style. Then the user opens the document with their choice of 
>> office software, finds the things in the conflict styles, and decides 
>> what the result should be.
> That's a very good idea!  (Except for LaTeX, maybe...)

latexdiff (in perl) may give you a head start (or ache, I dunno).

> For SVG, you could add both versions of a modified object, for 
> example, maybe with some visual effect to show the version...

Layers maybe?

I think for most formats, content changes could be handled well, while
changes in macro definitions or global settings are somewhat hopeless.

Michael
