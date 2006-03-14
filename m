From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 21:30:14 +0000
Message-ID: <20060314213014.GA12862@localhost.localdomain>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.63.0603142219040.23646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 14 22:33:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJH5r-0002v0-JA
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 22:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWCNVaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWCNVaM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 16:30:12 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:28114 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751855AbWCNVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 16:30:10 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060314213009.WWYJ1060.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:30:09 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout01-winn.ispmail.ntl.com with SMTP
          id <20060314213008.IHBN20480.aamtaout01-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:30:08 +0000
Received: (qmail 12887 invoked by uid 1000); 14 Mar 2006 21:30:14 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603142219040.23646@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17599>

On Tue, Mar 14, 2006 at 10:20:53PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 14 Mar 2006, Qingning Huo wrote:
> 
> > -	var=`git repo-config --get pull.octopus`
> > +	var=`git-repo-config --get pull.octopus`
> 
> This is unlikely to be applied; there are plans to have a "libexec" path 
> in which all git executables are stored, and just the "git" wrapper in the 
> path. Your patch would break git in those setups.
> 

I do not mind whether this patch is applied.  What I want is git calls
its helper programs, instead of any random git program in my PATH.  If
git-programs are installed to libexec path, how about calling them
with absolute path?

Regards,
Qingning
