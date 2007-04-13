From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: cvsserver and wincvs (cvsgui)
Date: Thu, 12 Apr 2007 23:11:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704122309020.27922@iabervon.org>
References: <Pine.LNX.4.64.0704121821150.27922@iabervon.org>
 <20070413000532.GI7085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 05:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcCCG-0007A4-19
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 05:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbXDMDLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 23:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbXDMDLW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 23:11:22 -0400
Received: from iabervon.org ([66.92.72.58]:1186 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbXDMDLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 23:11:21 -0400
Received: (qmail 1867 invoked by uid 1000); 13 Apr 2007 03:11:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Apr 2007 03:11:19 -0000
In-Reply-To: <20070413000532.GI7085@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44377>

On Fri, 13 Apr 2007, Frank Lichtenheld wrote:

> On Thu, Apr 12, 2007 at 06:54:22PM -0400, Daniel Barkalow wrote:
> > Anybody got any experience with wincvs and cvsserver, or any idea how 
> > things could be different between git-cvsserver and real cvs? He's 
> > presently going to use his own version control and just send us results, 
> > but it would be nice if this could be magically worked out before we 
> > started working together closely again in a couple of weeks.
> 
> Looks like a problem with newline conversion. You should probably
> try the gitcvs.allbinary option (available since 1.5.0 I think),
> that makes git-cvsserver send all files with -kb which should suppress
> the conversion.

That seems plausible; I think I'd read the documentation too while too 
sick and thought the fact that cvsserver, like git in general, doesn't 
change anything meant that it would also tell clients that nothing should 
be changed. Thanks; I've got a suitable version, and I'll try it and see 
if the user still has problems.

	-Daniel
*This .sig left intentionally blank*
