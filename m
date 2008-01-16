From: Jeff King <peff@peff.net>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 09:18:36 -0500
Message-ID: <20080116141836.GA22639@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF96h-00021H-7W
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYAPOSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYAPOSj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:18:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3257 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbYAPOSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:18:38 -0500
Received: (qmail 24168 invoked by uid 111); 16 Jan 2008 14:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 16 Jan 2008 09:18:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2008 09:18:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70677>

On Wed, Jan 16, 2008 at 04:14:30PM +0200, Petko Manolov wrote:

>> How big are your firmware files? How often do they change, and how large 
>> are the changes? IOW, have you confirmed that repacking does not produce 
>> an acceptable delta, meaning you get versioning for very low space cost?
>
> Changes don't happen too often, but the size of everything binary in the  
> tree easily goes to about 100MB.  Three commits later it ends up at about  
> 300MB...

Right, as loose objects. Did you try running "git-gc" to repack?

-Peff
