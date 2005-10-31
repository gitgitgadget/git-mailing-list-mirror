From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 13:36:16 -0800
Message-ID: <20051031213616.GO11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhKL-00074K-AG
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVJaVgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVJaVgW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:36:22 -0500
Received: from rgminet04.oracle.com ([148.87.122.33]:61245 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S932538AbVJaVgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:36:22 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet04.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j9VLaHN0012455;
	Mon, 31 Oct 2005 14:36:17 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VLaGY3030375;
	Mon, 31 Oct 2005 14:36:16 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VLaGaM030365
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 14:36:16 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWhKC-00062z-3D; Mon, 31 Oct 2005 13:36:16 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10892>

On Mon, Oct 31, 2005 at 01:00:18PM -0800, Junio C Hamano wrote:
> Do you think anybody is that perfect?

	I was being slightly facetious.  Of course everyone makes
mistakes and corrects them.  But if you _want_ the history, you have to
take it.  Otherwise, you are required to throw away the history
completely.  And that -- do you want the whole history or none of it --
is the crux of my question.

> What happens in reality is something like this:

[ understood work model snipped ]

> I do not know about the kernel tree but I would be surprised if
> any self-respecting developer wouldn't be doing this.  The
> review-decomposition-reapplication cycle is *very* important for
> both keeping the public history clean and reviewable, and
> preservign your public image ;-).

	I could care less about preserving my public image.  I'm an
idiot, I screw up all the time.  I only care that the tip of my tree is
respectable.
	I've seen arguments from folks on both sides -- the intermediate
history is important, warts and all, vs throw it all out for a clean
public history.  It seems that you fall into the second camp.
	That's fine, but can we make that work model a first-class
citizen?  Can we get a script that pulls one branch as a single,
un-historied (sic) commit into the current branch?  If this is The Way,
I should have to be mucking about with many steps of diff/patch (at
least unless my change is large enough to require split patches).

Joel
 

-- 

"It is not the function of our government to keep the citizen from
 falling into error; it is the function of the citizen to keep the
 government from falling into error."
	- Robert H. Jackson

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
