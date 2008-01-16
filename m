From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:25:28 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com>
 <20080116141836.GA22639@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9EY-00056R-0d
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYAPO0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbYAPO0p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:26:45 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:36174 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752310AbYAPO0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:26:45 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF9Dz-0007Qk-1e; Wed, 16 Jan 2008 16:26:39 +0200
In-Reply-To: <20080116141836.GA22639@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70680>

On Wed, 16 Jan 2008, Jeff King wrote:

> On Wed, Jan 16, 2008 at 04:14:30PM +0200, Petko Manolov wrote:
>
>>> How big are your firmware files? How often do they change, and how large
>>> are the changes? IOW, have you confirmed that repacking does not produce
>>> an acceptable delta, meaning you get versioning for very low space cost?
>>
>> Changes don't happen too often, but the size of everything binary in the
>> tree easily goes to about 100MB.  Three commits later it ends up at about
>> 300MB...
>
> Right, as loose objects. Did you try running "git-gc" to repack?

I did "git repack -f -a -d", but it didn't reduce the repository size. 
Those binaries are already compressed so any change adds up their size 
once again.


cheers,
Petko
