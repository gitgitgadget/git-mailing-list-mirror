From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 8 Mar 2011 23:18:55 +0100
Message-ID: <20110308221855.GA4030@ugly.local>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <loom.20110308T134920-72@post.gmane.org>
 <20110308220843.GA27156@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Martin Svensson <martin.k.svensson@netinsight.se>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:25:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5Ld-0002FP-7E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1CHWZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:25:37 -0500
Received: from ktown.kde.org ([131.246.120.250]:43461 "HELO ktown.kde.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755024Ab1CHWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:25:35 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 17:25:35 EST
Received: (qmail 25479 invoked from network); 8 Mar 2011 22:18:54 -0000
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 8 Mar 2011 22:18:54 -0000
Received: from ossi by ugly.local with local (masqmail 0.2.27) id
 1Px5F1-14N-00; Tue, 08 Mar 2011 23:18:55 +0100
Content-Disposition: inline
In-Reply-To: <20110308220843.GA27156@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168710>

On Tue, Mar 08, 2011 at 04:08:43PM -0600, Jonathan Nieder wrote:
> (please do not cull the CC list)
>
i posted via the gmane webform ...

> Oswald Buddenhagen wrote:
> > i really hate to tell my coworkers that they have to amend the
> > cherry-picks just to make them comply with git's own guidelines for
> > well-formed commit messages
> 
> I assume you are referring to one-line commit messages becoming
> two-line?
>
yes

> Here's something rough to start.
> 
i did a much simpler patch in that vein as well, but scrapped it again -
totally overengineered. the idea is to optimize the simple case -
cherry-pick -x, push. everything else needs amends anyway.

regards
