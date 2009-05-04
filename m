From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Wrong conflicts on file splits
Date: Mon, 04 May 2009 15:27:08 +0200
Message-ID: <49FEED2C.8010501@drmicha.warpmail.net>
References: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 15:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0yCd-0007Gf-0P
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 15:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbZEDN1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 09:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbZEDN1Q
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 09:27:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42993 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753969AbZEDN1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 09:27:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E05A633A07F;
	Mon,  4 May 2009 09:27:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 May 2009 09:27:15 -0400
X-Sasl-enc: Wg+GjqST+iQ6oqyz0fsNQI4ZbQIBdxh2Yhk/ZdXgg1/1 1241443635
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5700F4E11D;
	Mon,  4 May 2009 09:27:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118233>

Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
> I keep running into this problem, is there anything I can do to make
> it better? I'm using stgit but this is a problem in git itself.
> 
> I have a patch that splits file A into two files, A and B.
> Now I merge with another tree and bring in a one line fix to A.
> The fix touches the pre-split file A in a section that is going to end up in B.
> Next I re-apply the patch that splits A into A and B.
> 
> This results in a large conflict in the post split file A.
> And no patch being applied to file B which is where the fix belongs.
> 
> Repeat this process with a multi-line fix and the whole automated
> merge process breaks down and I have to carefully figure everything
> out by hand.
> 
> The merge process seems to be unaware of the newly created file B. No
> patches or conflict ever end up in it.
> 

Can you provide a test case or at least a list of commands which you are
issuing? You complain about "merge", but you say you are "applying a
patch". Are you merging that patch from another branch, or are you
really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?

Cheers,
Michael
