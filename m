From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Fri, 14 Dec 2007 14:39:57 -0800
Message-ID: <20071214223957.GC7300@mail.oracle.com>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.99999.0712031258460.9605@xanadu.home> <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712132227090.8467@xanadu.home> <m3fxy5qwbq.fsf@roke.D-201> <alpine.LFD.0.999999.0712140836140.8467@xanadu.home> <20071214215206.GB7300@mail.oracle.com> <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 23:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3JE6-0006Ur-3Q
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935109AbXLNWlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934562AbXLNWk7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:40:59 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:21356 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935092AbXLNWk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 17:40:58 -0500
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id lBEMe08J028594;
	Fri, 14 Dec 2007 15:40:01 -0700
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBE85H5P025549;
	Fri, 14 Dec 2007 15:39:59 -0700
Received: from ca-server1.us.oracle.com by acsmt355.oracle.com
	with ESMTP id 6374869641197671998; Fri, 14 Dec 2007 14:39:58 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J3JCI-0007Dj-4p; Fri, 14 Dec 2007 14:39:58 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68358>

On Fri, Dec 14, 2007 at 05:34:49PM -0500, Nicolas Pitre wrote:
> On Fri, 14 Dec 2007, Joel Becker wrote:
> > 	We've seen that release notes are a poor way to communicate
> > this.  What will happen to a 1.4.4 user when they try to access the
> > repository?  Corruption, cryptic error message, or clean "this repo is
> > not compatible" message?
> 
> There won't be any corruption.
> 
> In the best case there will be a message along "x is not supported by 
> this version of Git -- please consider upgrading".  In the worst case 
> it'll say "x is bad".

	That would be excellent, especially the former message.
 
> But you know what? repositories with the change affecting 1.4.4 users 
> are _already_ out there and no one complained recently.  Anyone pushing 

	I did, as did people I work with.  It's on git-list, even.  I'm
pretty sure it corrupted too.

Joel

-- 

"Practice random acts of kindness and senseless acts of beauty."

 Oh, and don't forget where your towel is.

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
