From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: EGIT branch checkout errors
Date: Wed, 12 Nov 2008 23:48:31 +0100
Message-ID: <200811122348.31423.robin.rosenberg.lists@dewire.com>
References: <491AFB40.4000800@oanda.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Dumoulin <dumoulin@oanda.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OX1-00033O-Hv
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbYKLWsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbYKLWsg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:48:36 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:34169 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064AbYKLWsf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 17:48:35 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA9501F74A35; Wed, 12 Nov 2008 23:48:32 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <491AFB40.4000800@oanda.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100827>

onsdag 12 november 2008 16:50:24 skrev Chris Dumoulin:
> Using EGIT in Eclipse, I'm able to create a new branch, but not able to 
> checkout a branch. When I try Team->Branch...->Checkout, nothing 
> happens, so I launched Eclipse from a terminal to see any output it 
> might be giving. Here's what I got:

Something is wrong in the WorkDirCheckout class. Could you send these
things

git ls-tree -r HEAD
git-ls-tree -r branch-you-try-to-switch-to
git diff --name-only

Then post it to http://code.google.com/p/egit/issues/list

-- robin
