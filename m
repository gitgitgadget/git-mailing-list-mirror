From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 16 gig, 350,000 file repository
Date: Thu, 18 Feb 2010 15:58:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002181556320.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
 <19325.40682.729141.973125@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiDST-0004U6-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab0BRU6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:58:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15700 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0BRU6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:58:43 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY200H3G29UWE20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Feb 2010 15:58:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <19325.40682.729141.973125@blake.zopyra.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140379>

On Thu, 18 Feb 2010, Bill Lear wrote:

> I'm starting a new, large project and would like a quick bit of advice.
> 
> Bringing in a set of test cases and other files from a ClearCase
> repository resulted in a 350,000 file git repo of about 16 gigabytes.
> 
> The time to clone over a fast network was about 250 minutes.  I could
> not verify if the repo had been packed properly, etc.

I'd start from there.  If you didn't do a 'git gc --aggressive' after 
the import then it is quite likely that your repo isn't well packed.

Of course you'll need a big machine to repack this.  But that should be 
needed only once.


Nicolas
