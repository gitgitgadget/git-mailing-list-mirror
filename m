From: James Westby <jw+debian@jameswestby.net>
Subject: Re: "commit"s without "from" in fast-import
Date: Wed, 19 Mar 2008 18:39:13 +0000
Message-ID: <1205951953.32007.22.camel@flash>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no>
	 <20080318034321.GK8410@spearce.org>
	 <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no>
	 <20080319020625.GA3535@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	git@vger.kernel.org,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4r9-0004ng-Gn
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762684AbYCSUDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbYCSUDc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:03:32 -0400
Received: from jameswestby.net ([89.145.97.141]:33771 "EHLO jameswestby.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762674AbYCSUDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:03:30 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2008 16:03:30 EDT
Received: from 77-99-12-164.cable.ubr13.azte.blueyonder.co.uk ([77.99.12.164] helo=[192.168.1.109])
	by jameswestby.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jw+debian@jameswestby.net>)
	id 1Jc3Bx-0000fJ-Ch; Wed, 19 Mar 2008 18:39:13 +0000
In-Reply-To: <20080319020625.GA3535@spearce.org>
X-Mailer: Evolution 2.22.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77530>

On Tue, 2008-03-18 at 22:06 -0400, Shawn O. Pearce wrote:
> James, Ian -- to give you the short backstory we are talking about
> creating a new branch _without_ a "from", but instead using a single
> "merge" to specify the sole ancestor revision of a new commit to
> be placed on the new branch.  This allows the frontend to supply
> all files for the tree as none were inherited from the sole ancestor.
> 
> The other (more obvious?) approach to accomplish the same result
> is to use "from" followed by a "filedeleteall" to clear the files,
> then supply the new files.  Both approaches have the exact same
> result in git-fast-import.
> 

I don't see why this would cause a fundamental problem for 
bzr-fastimport, and shouldn't be difficult to implement, so I'm
happy for you to proceed however you like.

Thanks,

James
