From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: HTTP trees trailing GIT trees
Date: Fri, 25 May 2007 13:15:49 +0200
Organization: At home
Message-ID: <f36g7l$2oe$1@sea.gmane.org>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz> <loom.20070523T161537-175@post.gmane.org> <loom.20070524T142358-608@post.gmane.org> <Pine.LNX.4.64.0705241456080.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 13:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXhQ-0006kM-FQ
	for gcvg-git@gmane.org; Fri, 25 May 2007 13:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbXEYLLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXEYLLI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 07:11:08 -0400
Received: from main.gmane.org ([80.91.229.2]:40034 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbXEYLLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 07:11:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrXhG-0005fv-SR
	for git@vger.kernel.org; Fri, 25 May 2007 13:11:04 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 13:11:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 13:11:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48360>

Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 24 May 2007, Panagiotis Issaris wrote:
> 
>> So, we're asking for /ffmpeg/info/refs, and the server is returning 
>> c30fa8391812..., but, using GitWeb one can see that c30fa839812... is 
>> not the last commit, this one is: 
>> http://git.mplayerhq.hu/?p=ffmpeg;a=commit; 
>> h=47d7dcb5a7d89f413064e7ef1b54d77e59fb8375
> 
> So, info/refs is still old. This file should have been updated by 
> git-update-server-info. I am not sure how this repo is updated, but I 
> suspect that the wrong hook contains the call to update-server-info, or 
> that the correct hook is not activated, or it does not have write 
> permission.

If you push to repository (it is the usual setup for public
repositories), it would be enough to simply enable default 
'post-update' hook (make it executable).

If you however for example commit to this public repository directly,
you would need to put call to git-update-server-info in the 'post-commit'
hook.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
