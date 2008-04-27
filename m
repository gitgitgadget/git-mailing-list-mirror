From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: git doesn't finds the parent of a commit (was: How to fetch missing pack)
Date: Sun, 27 Apr 2008 19:37:31 +0200
Message-ID: <20080427173731.GA9523@cuci.nl>
References: <slrng019fg.nd8.joerg@alea.gnuu.de> <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de> <200804240801.13674.chriscool@tuxfamily.org> <20080424060857.GX29771@spearce.org> <20080427104704.GA11784@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:38:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqApP-0006oV-AX
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbYD0Rhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYD0Rhc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:37:32 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43465 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbYD0Rhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:37:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 41691545E; Sun, 27 Apr 2008 19:37:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080427104704.GA11784@alea.gnuu.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80467>

J?rg Sommer wrote:
>% git rev-parse b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>fatal: ambiguous argument 'b63e99500137c913bd801a2f22b6cf88c63b95c5~1': unknown revision or path not in the working tree.
>Use '--' to separate paths from revisions

>Can someone tell me what I'm doing wrong?

I've had similar symptoms when I had circular references in the
repository.  They're not reported by any of the existing checks, I've
submitted a patch (resent it just now) which causes git to check for
(and report) circular references when using --topo-order on e.g.
git-rev-list.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
