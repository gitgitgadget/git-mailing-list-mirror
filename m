From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Fri, 14 Dec 2007 13:52:06 -0800
Message-ID: <20071214215206.GB7300@mail.oracle.com>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.99999.0712031258460.9605@xanadu.home> <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712132227090.8467@xanadu.home> <m3fxy5qwbq.fsf@roke.D-201> <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 22:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ITN-0006jR-7B
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXLNVxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXLNVxD
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:53:03 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:40472 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXLNVxB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:53:01 -0500
Received: from agmgw1.us.oracle.com (agmgw1.us.oracle.com [152.68.180.212])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id lBELqbnj006767;
	Fri, 14 Dec 2007 15:52:37 -0600
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by agmgw1.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBE131sx014199;
	Fri, 14 Dec 2007 14:52:36 -0700
Received: from ca-server1.us.oracle.com by acsmt358.oracle.com
	with ESMTP id 6372202561197669127; Fri, 14 Dec 2007 15:52:07 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J3IRz-0006MF-8Y; Fri, 14 Dec 2007 13:52:07 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68351>

On Fri, Dec 14, 2007 at 08:38:51AM -0500, Nicolas Pitre wrote:
> On Fri, 14 Dec 2007, Jakub Narebski wrote:
> > Which means what? Local clone with shortcut (hardlinking and remotes)?
> > Dumb protocols (http, ftp, rsync)?
> 
> Right, or simply shared repo over NFS or the like.
> 
> The 1.5.5 release notes will contain a note reminding people to set the 
> corresponding config variables if they wish to retain the legacy 
> behaviors.

	We've seen that release notes are a poor way to communicate
this.  What will happen to a 1.4.4 user when they try to access the
repository?  Corruption, cryptic error message, or clean "this repo is
not compatible" message?

Joel

-- 

"Depend on the rabbit's foot if you will, but remember, it didn't
 help the rabbit."
	- R. E. Shay

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
