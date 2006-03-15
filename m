From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 20:40:03 +0000
Message-ID: <20060315204003.GA6154@localhost.localdomain>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 21:40:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJcmq-0003RV-FR
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 21:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCOUj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 15:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCOUj7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 15:39:59 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:57865 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751360AbWCOUj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 15:39:58 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060315203956.CPHD29040.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 15 Mar 2006 20:39:56 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout01-winn.ispmail.ntl.com with SMTP
          id <20060315203956.CXBT20480.aamtaout01-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Wed, 15 Mar 2006 20:39:56 +0000
Received: (qmail 6177 invoked by uid 1000); 15 Mar 2006 20:40:03 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17615>

On Tue, Mar 14, 2006 at 03:07:39PM -0800, Linus Torvalds wrote:
> On Tue, 14 Mar 2006, Qingning Huo wrote:
> > We have "git-read-tree" and "git repo-config" at the same time.  Are
> > there any rules saying which form should be preferred?  How about pick
> > one form and stick to it?
> 
> I agree that it is inconsistent as-is. So a patch to make it use the 
> "git-repo-config" form (the argument being that internally, we use the 
> full names) might be good if just for consistency.
> 

Can these two patches be accepted then?  What do others think?

Qingning
