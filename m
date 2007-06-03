From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Sun, 03 Jun 2007 11:36:33 -0700
Message-ID: <46630A31.5090104@midwinter.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org> <Pine.LNX.4.64.0706030147520.4046@racer.site> <200706031228.58779.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 20:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuuwU-0003g7-Hj
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXFCSgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbXFCSgg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:36:36 -0400
Received: from tater.midwinter.com ([216.32.86.90]:59456 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbXFCSgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:36:35 -0400
Received: (qmail 6842 invoked from network); 3 Jun 2007 18:36:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=aFbaJhDmbRv4LbjckDzc+SshhpVTW4zronsmt+2VDsBDfyKieq3Y4lOhO8m918vg  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 3 Jun 2007 18:36:34 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200706031228.58779.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49020>

Jakub Narebski wrote:
> By the way, why did you change name to git-filter-branch, instead of
> leaving it [almost] as is, i.e. git-rewritehist. Or if you wanted to
> emphasize that it rewrites only one branch at a time, git-rewrite-branch?
>   

One argument against the name change is that one could easily imagine 
this tool being extended in the future to filter all branches rather 
than just one. For example, the "get rid of copyrighted file X in my 
repository" use case is a bit of a pain right now using 
cg-admin-rewritehist if the file was introduced early in the history of 
a large repo; in that scenario you want to be able to say, "filter this 
file out of my entire repo" without particularly caring which branches 
it appeared in (and without losing any of the branch structure in your 
history.)

-Steve
