From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: HTTP trees trailing GIT trees
Date: Thu, 24 May 2007 14:19:43 +0000 (UTC)
Message-ID: <loom.20070524T161814-702@post.gmane.org>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz> <loom.20070523T161537-175@post.gmane.org> <loom.20070524T142358-608@post.gmane.org> <Pine.LNX.4.64.0705241456080.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 16:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrEAg-0002zw-If
	for gcvg-git@gmane.org; Thu, 24 May 2007 16:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXEXOUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbXEXOUA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 10:20:00 -0400
Received: from main.gmane.org ([80.91.229.2]:53194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXEXOT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 10:19:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrEAS-0004w2-I6
	for git@vger.kernel.org; Thu, 24 May 2007 16:19:52 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 16:19:52 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 16:19:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48267>

Hi Dscho,

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> Hi,
> 
> On Thu, 24 May 2007, Panagiotis Issaris wrote:
> 
> > So, we're asking for /ffmpeg/info/refs, and the server is returning 
> > c30fa8391812..., but, using GitWeb one can see that c30fa839812... is 
> > not the last commit, this one is: 
> > http://git.mplayerhq.hu/?p=ffmpeg;a=commit; 
> > h=47d7dcb5a7d89f413064e7ef1b54d77e59fb8375
> 
> So, info/refs is still old. This file should have been updated by 
> git-update-server-info. I am not sure how this repo is updated, but I 
> suspect that the wrong hook contains the call to update-server-info, or 
> that the correct hook is not activated, or it does not have write 
> permission.

Thanks! I've just reported this on the ffmpeg mailinglist.

Thanks again for your fast reply,
With friendly regards,
Takis
