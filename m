From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 12:27:10 +0200
Message-ID: <20070808102710.GI999MdfPADPa@greensroom.kotnet.org>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <Pine.LNX.4.64.0708072344450.14781@racer.site>
 <a1bbc6950708071610g4ea4d874t458cec14a444b519@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 12:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIil6-0003Ij-L6
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 12:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029AbXHHK1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 06:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759677AbXHHK1P
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 06:27:15 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:63123 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758863AbXHHK1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 06:27:13 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMG0029OADASN@psmtp09.wxs.nl> for git@vger.kernel.org; Wed,
 08 Aug 2007 12:27:10 +0200 (MEST)
Received: (qmail 23988 invoked by uid 500); Wed, 08 Aug 2007 10:27:10 +0000
In-reply-to: <a1bbc6950708071610g4ea4d874t458cec14a444b519@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55315>

On Tue, Aug 07, 2007 at 04:10:38PM -0700, Dmitry Kakurin wrote:
> Yeah, I've already went thru these. But I want (much) more details.
> I can ask a bunch of random questions on this list, like:
> 
> * Why after 'submodule update' it becomes detached, what if I want it
> to stay on certain branch?

You'd need to have a way to specify which branch you want to have updated.
There was some discussion about this some time ago and the general
conclusion was that a detached HEAD was the best solution.

> * How do I control which branches are fetched?

Currently, you can't.

> * What if I do 'commit -a' standing in /super, will /super/submodule
> commit as well?

No.

> * What if I'm standing in /super/submodule and do 'commit -a'? Will
> super notice it in any way?

Any commit in the submodule will be seen as a "change" to the submodule
from the perspective of the supermodule.

skimo
