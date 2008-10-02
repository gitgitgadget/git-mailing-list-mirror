From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [PATCH] git-cvsexportcommit: handle file status reported out
 of order (was Re: [PATCH] Make git-cvsexportcommit "status" each file in
 turn)
Date: Thu, 02 Oct 2008 16:08:34 +0100
Message-ID: <48E4E3F2.4000401@yahoo.co.uk>
References: <48E4AB7D.5030705@yahoo.co.uk> <alpine.DEB.1.00.0810021428170.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:12:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPnb-0000pN-OE
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYJBPHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbYJBPHv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:07:51 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:4793 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbYJBPHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:07:50 -0400
Received: from 80-192-19-239.cable.ubr02.edin.blueyonder.co.uk ([80.192.19.239] helo=[192.168.0.123])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1KlPmP-0001aI-JR; Thu, 02 Oct 2008 16:07:49 +0100
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <alpine.DEB.1.00.0810021428170.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97354>

Johannes Schindelin wrote:
> Please research a bit better.  If the basenames are not unique, several 
> cvs status calls are used.  See commit
> fef3a7cc5593d3951a5f95c92986fb9982c2cc86.

Yes, I see. I did spend some time searching for prior art on this issue, 
but I obviously wasn't looking in the right places.

> I can only assume that you have not really hung out on this list for very 
> long; this is no way near the way patches are expected here.

Correct.

> Also, given the fact that you actually verified that it was fixed in 
> 1.6.0, what exactly is your proposed course of action?  Revert the fix in 
> 1.6.0 and apply your patch?  Apply your patch to 1.5.6.5, cracking a 
> release 1.5.6.6 with your patch?

Neither. At the moment, I can only offer what I have: a patch for 
1.5.6.5, representing an idea that may contribute something small to 
1.6.0 (using information from CVS on STDERR). It should be simple to 
adapt if it's useful, if not please ignore it.

By posting, I hoped to learn if it was useful and where to look for the 
information I was missing, which you've been helpful enough to point out.

Thanks,

N
