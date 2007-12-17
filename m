From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 12:09:21 -0800
Message-ID: <20071217200920.GB19816@mail.oracle.com>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712132227090.8467@xanadu.home> <m3fxy5qwbq.fsf@roke.D-201> <alpine.LFD.0.999999.0712140836140.8467@xanadu.home> <20071214215206.GB7300@mail.oracle.com> <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MKd-0001yz-Q6
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbXLQULO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937024AbXLQULN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:11:13 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:52756 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936773AbXLQULK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:11:10 -0500
Received: from agmgw1.us.oracle.com (agmgw1.us.oracle.com [152.68.180.212])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id lBHKAe9H027281;
	Mon, 17 Dec 2007 14:10:40 -0600
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by agmgw1.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBH5SRjK000590;
	Mon, 17 Dec 2007 13:10:39 -0700
Received: from ca-server1.us.oracle.com by acsmt353.oracle.com
	with ESMTP id 6405995441197922164; Mon, 17 Dec 2007 12:09:24 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J4MHD-0007Pj-AY; Mon, 17 Dec 2007 12:09:23 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68608>

On Fri, Dec 14, 2007 at 09:23:38PM -0500, Nicolas Pitre wrote:
> On Fri, 14 Dec 2007, Joel Becker wrote:
> > 	The relevant message is:
> > 
> > Message-ID: <7vveaindgp.fsf@gitster.siamese.dyndns.org>
> > 
> > See the paragraphs at the bottom.  The thread, started by me, begins
> > with:
> > 
> > Message-ID: <20070910205429.GE27837@tasint.org>
> 
> OK.  From those emails Junio forwarded to me, I don't see any case for 
> actual _corruptions_.  Git does indeed refuse to work with unknown pack 
> index or unknown objects in a pack.  Really old versions were not overly 
> clueful as to why they refused to work, but they should never corrupt a 
> pack which, for all purposes, is always read-only anyway.

	You may not see a case for actual corruptions, but my coworker
updated his tree on a box with 1.5.x, then tried to work on a box with
1.4.x (I think 1.4.2 back then), and ended up with a tree that was
unusable.  He had to re-clone, and I think he got lucky recovering
pending changes (probably using 1.5.x on the branches with the changes,
as master was what got broken).
	My point is not that change is always bad, but that we should
really look forward to what we're doing, and that "it's in the release
notes" is not sufficient if an older git gives an incomprehensible error
or a silent problem.  I was responding to the cavalier statement "well,
it's in the release notes, so don't worry about older versions".

Joel

-- 

"Vote early and vote often." 
        - Al Capone

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
