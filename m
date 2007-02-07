From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why are commits on detached heads good, again?
Date: Wed, 7 Feb 2007 16:32:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071629210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070207142642.23503.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Feb 07 16:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEomW-0007OO-6t
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbXBGPcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbXBGPcV
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:32:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:49984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030629AbXBGPcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:32:20 -0500
Received: (qmail invoked by alias); 07 Feb 2007 15:32:19 -0000
X-Provags-ID: V01U2FsdGVkX19ARsIb/sJAepGceaBglSYeN68PcTrsGDRxJgd42U
	Pffg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070207142642.23503.qmail@science.horizon.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38932>

Hi,

On Wed, 7 Feb 2007, linux@horizon.com wrote:

> Can someone explain why committing on top of a detached head is a killer 
> feature and thinking up a name sooner rather than later is a huge 
> inconvenience?

I agree that "because I could" is a weak excuse for this feature.

But actually, I think it is more convenient to be able to play around with 
an idea, properly committing simple steps, and finally, if, and only if, 
it works as expected, make a topic branch of it.

IOW:

checkout v2.6.20
<hackhackhack>
commit
<hackhackhack>
commit
<hackhack..
	Oh darn, it _cannot_ work after all, so let's forget about it.

No hard thinking of a proper name, no cleanup required.

Yeah, maybe not a killer feature, but maybe a butcher feature ;-)

Ciao,
Dscho
