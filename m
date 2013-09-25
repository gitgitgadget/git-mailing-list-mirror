From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 19:47:50 +0000
Message-ID: <20130925194750.GA5796@dcvr.yhbt.net>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <20130925194402.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOv3y-0004Hd-O1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3IYTru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:47:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56600 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab3IYTru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:47:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230AC1F78D;
	Wed, 25 Sep 2013 19:47:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130925194402.GA9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235373>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Keshav Kini wrote:
> > +	tracking.  If necessary, rebuild the .git/svn/\*\*/.rev_map.*
> > +	files, given the requisite information exists in commit
> > +	messages (see the svn.noMetadata config option for more
> > +	information).  The name of the [svn-remote "..."] section in
> > +	the .git/config file may be specified as an optional
> > +	command-line argument.
> 
> Taking a step back, the reader might wonder *why* he would want
> to run "git svn fetch" to rebuilt these .rev_map.* files, and what
> they are for.
> 
> Perhaps there should be a separate REVISION MAP section describing
> this in more detail.  Something as simple as

I agree with Jonathan's suggestions.

Keshav: can you please resend with Jonathan's suggestions?
Thanks both.
