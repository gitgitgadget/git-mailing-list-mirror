From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:39:19 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161634080.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com>
 <20080116141836.GA22639@coredump.intra.peff.net> <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com> <20080116143219.GA22744@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9S3-0002VN-Af
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYAPOkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYAPOkg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:40:36 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:35102 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753778AbYAPOkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:40:35 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF9RN-0007SM-ST; Wed, 16 Jan 2008 16:40:29 +0200
In-Reply-To: <20080116143219.GA22744@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70683>

On Wed, 16 Jan 2008, Jeff King wrote:

> OK, that was the answer I was looking for; it looks like you are out
> of luck.

Story of my life. :-)

> As an experiment, it might be worth trying to store the uncompressed
> versions instead (git will delta _and_ compress them for you).

I don't have them uncompressed.

I can try to convert those files into ascii format and then save them in 
the repository.  Since most changes are incremental git should be able to 
generate relatively small delta, which should compress well enough.

Thanks for the hint.


 		Petko
