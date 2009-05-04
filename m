From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Mon, 04 May 2009 14:33:42 +0200
Message-ID: <49FEE0A6.3060905@drmicha.warpmail.net>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: elupus <elupus@ecce.se>
X-From: git-owner@vger.kernel.org Mon May 04 14:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0xN1-0000IK-Co
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 14:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbZEDMdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 08:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZEDMdv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 08:33:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44937 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753455AbZEDMdu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 08:33:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1627C338A7C;
	Mon,  4 May 2009 08:33:51 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 May 2009 08:33:51 -0400
X-Sasl-enc: ACkm3SeAVqr3hUByqT8LyA2b6rZLsZ4lM4gHG/Sk+gLm 1241440430
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B17A4FF20;
	Mon,  4 May 2009 08:33:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118227>

elupus venit, vidit, dixit 27.04.2009 17:51:
> Hi, 
> 
> I recently had a problem with git push honoring the grafts file. It caused
> it not to push all data required for a branch to the remote repository,
> rendering it impossible to clone the remote repository (missing blobs)
> 
> This was with an not so fresh git version of 1.5.4.3 (ubuntu hardy).
> 
> Has this issue been fixed in later git version? I saw a thread talking

How about testing this yourself, since you have a test case in your
hands and only need to build a more current git? Alternatively,
providing a simple test script would allow others to test this for you.

Cheers,
Michael

> about it a long time ago (long before my release in question) on this
> mailing list, but nothing was mentioned about if it was actually solved.
> 
> Regards
> Joakim Plate
> 
