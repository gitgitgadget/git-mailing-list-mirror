From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-remote-testgit: fix race when spawning fast-import
Date: Sun, 22 Apr 2012 11:49:34 +0200
Message-ID: <20120422094934.GA12132@ecki>
References: <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
 <20120421234555.GA11808@padd.com>
 <20120421234211.GC20473@ecki>
 <20120422021608.GA11892@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 12:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLtk5-0005QU-Sl
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 12:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2DVKJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 06:09:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:64749 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2DVKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 06:09:26 -0400
Received: from [127.0.0.1] (p5B22E4D1.dip.t-dialin.net [91.34.228.209])
	by bsmtp.bon.at (Postfix) with ESMTP id 07E1110016;
	Sun, 22 Apr 2012 12:05:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120422021608.GA11892@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196077>

On Sat, Apr 21, 2012 at 10:16:08PM -0400, Pete Wyckoff wrote:
> drizzd@aon.at wrote on Sun, 22 Apr 2012 01:42 +0200:
> > 
> > Should this test be running unconditionally? It will delay the otherwise
> > almost instant test by 2 seconds.
> 
> More like 6 seconds, in fact, for all three interactions in "git
> push".  I'll change the test to add a prereq on TOOSLOW; is there
> a better way to leave a test in to document the issue, but have
> it skipped?

Sounds good to me.
