From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: Is there a way to control the number of revisions will be
	saved by git
Date: Wed, 03 Dec 2008 22:37:06 +1100
Message-ID: <1228304226.23167.8.camel@therock.nsw.bigpond.net.au>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tzury Bar Yochay <tzury.by@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7pt9-0002Yl-H1
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYLCL0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYLCL0L
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:26:11 -0500
Received: from nschwmtas05p.mx.bigpond.com ([61.9.189.149]:51375 "EHLO
	nschwmtas05p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbYLCL0K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 06:26:10 -0500
Received: from nschwotgx03p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas05p.mx.bigpond.com with ESMTP
          id <20081203112607.UJDI1796.nschwmtas05p.mx.bigpond.com@nschwotgx03p.mx.bigpond.com>;
          Wed, 3 Dec 2008 11:26:07 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx03p.mx.bigpond.com with ESMTP
          id <20081203112607.YQKM7031.nschwotgx03p.mx.bigpond.com@therock.local>;
          Wed, 3 Dec 2008 11:26:07 +0000
In-Reply-To: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150201.49366CCF.00DB,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102244>

On Wed, 2008-12-03 at 13:01 +0200, Tzury Bar Yochay wrote:
<snip>
> Say I wish to save only 100 generations back (per branch).
> Is it possible to configure git so it will save only N records back.

What would be the advantage in doing that?  Git is designed so that you
have all your history available, and saves data in such a way that it
really doesn't take much space.

How would git be able to perform a merge from one branch to another if
it didn't have this history available?

That said, you could probably chop off the history you don't want by
doing tricks with grafting, and rewriting all your history, but this
would likely use more disk space because your branches wouldn't have
anything in common, and also make it very difficult to merge in the
future.
