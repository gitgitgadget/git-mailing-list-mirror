From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: proper detection of bare repositories
Date: Thu, 6 Nov 2008 01:45:22 -0800
Message-ID: <20081106094522.GB15686@untitled>
References: <20081103000903.GA1135@euler> <20081104083015.GA14405@untitled> <20081106050739.GA7713@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Nov 06 10:46:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky1Rk-0007Gi-8z
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 10:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYKFJpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 04:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbYKFJpY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 04:45:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38481 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbYKFJpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 04:45:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 50C862DC01A;
	Thu,  6 Nov 2008 09:45:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081106050739.GA7713@euler>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100222>

Deskin Miller <deskinm@umich.edu> wrote:
> On Tue, Nov 04, 2008 at 12:30:15AM -0800, Eric Wong wrote:
> > How about using git_cmd_try instead?
> > 
> > The Error.pm try/catch stuff makes me a bit uncomfortable.  I realize
> > it's (unfortunately) in Git.pm; but I'd rather keep it confined there so
> > we can more easily remove it later if someone were inclined.
> 
> Yeah, major thinko; I read the Git(3pm) manpage, looked at git_cmd_try, and for
> some reason thought that it wasn't what I want.  But it's exactly what I want.

Thanks, acked and pushed out to git://git.bogomips.org/git-svn.git

-- 
Eric Wong
